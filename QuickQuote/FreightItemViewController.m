//
//  FreightItemViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/9/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "FreightItemViewController.h"
#import "FreightItem.h"
#import "QuoteRequest.h"
#import "PickerItem.h"
#import "HandlingUnitType.h"
#import "PickerHelper.h"
#import "DataModel.h"
#import "UserSettings.h"

@interface FreightItemViewController ()
{
    NSNumberFormatter *decimalFormatter;
    NSNumberFormatter *noStyleFormatter;
    NSString* currentPickerSegue;
    NSString* validationErrorTitle;
    
    UserSettings* _userSettings;
}

- (void)configureView;
- (void)saveFreightItem;
- (BOOL) isValid;
- (void)calculateDensity;

@end

@implementation FreightItemViewController

@synthesize freightItem = _freightItem;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize quoteRequest = _quoteRequest;
@synthesize isAdding = _isAdding;

@synthesize redLabel = _redLabel;

@synthesize pickerHelper = _pickerHelper;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    decimalFormatter = [[NSNumberFormatter alloc]init];
    [decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    noStyleFormatter = [[NSNumberFormatter alloc]init];
    [noStyleFormatter setNumberStyle:NSNumberFormatterNoStyle];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [_redLabel setHidden:true];
    
    _pickerHelper = [[PickerHelper alloc] initWithContext:_managedObjectContext];

    [self configureView];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	//return YES;
	return NO;
}

- (void)configureView
{
    _userSettings = [DataModel sharedInstance].currentUser.userSettings;

    validationErrorTitle = @"Validation Error";
    
    [_pickerHelper initPickerItems];
    
    // Update the user interface for the freight item.
    if (_isAdding)
    {
        _freightItem = [NSEntityDescription
                        insertNewObjectForEntityForName:@"FreightItem"
                        inManagedObjectContext:_managedObjectContext];
        
        [_freightItem setDefaults];
        _freightItem.weight = nil;
        _freightItem.handlingUnits = nil;
        
        if (_userSettings.defaultHandlingUnitTypeID != nil)
            _freightItem.handlingUnitTypeID = _userSettings.defaultHandlingUnitTypeID;
        
        if (_userSettings.defaultFreightClass != nil)
            _freightItem.freightClass = _userSettings.defaultFreightClass;
        
        self.title = @"Add Freight Item...";
    }
    
    self.weight.delegate = self;
    self.units.delegate = self;
    self.length.delegate = self;
    self.width.delegate = self;
    self.height.delegate = self;
    self.freightDescription.delegate = self;
    self.nmfc.delegate = self;

    if (! self.editing)
    {
        self.weight.enabled = false;
        self.units.enabled = false;
        self.length.enabled = false;
        self.width.enabled = false;
        self.height.enabled = false;
        self.btnFreightClass.enabled = false;
        self.btnHandlingUnitType.enabled = false;
        self.stackable.enabled = false;
        self.nmfc.enabled = false;
    }

    self.btnFreightClass.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnFreightClass.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.btnHandlingUnitType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnHandlingUnitType.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //self.freightDescription.editable = NO;
    
    // Update the user interface for the freight item.
    if (_freightItem != nil)
    {
        if (_freightItem.weight != nil)
            self.weight.text = [noStyleFormatter stringFromNumber:_freightItem.weight];
        
        self.units.text = [noStyleFormatter stringFromNumber: _freightItem.handlingUnits];
        [self.btnFreightClass setTitle:[decimalFormatter stringFromNumber:_freightItem.freightClass]forState:UIControlStateNormal];
        [self.btnHandlingUnitType setTitle:[_pickerHelper getHandlingUnitName:_freightItem.handlingUnitTypeID] forState:UIControlStateNormal];
        
        if (_freightItem.freightDescription != nil && _freightItem.freightDescription.length)
            self.freightDescription.text = _freightItem.freightDescription;
        
        self.length.text = [decimalFormatter stringFromNumber:_freightItem.length];
        self.width.text = [decimalFormatter stringFromNumber:_freightItem.width];
        self.height.text = [decimalFormatter stringFromNumber:_freightItem.height];
        self.nmfc.text = _freightItem.nmfc;
        [self.stackable setOn:[_freightItem.isStackable boolValue]];
        
        [self handlingUnitTypeChanged:[_freightItem.handlingUnitTypeID intValue]];
    }
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    bool bEditing;
    
    // turn off any error messages
    //[_redLabel setHidden:true];
    
    [super setEditing:flag animated:animated];
    
    if (flag == YES)
    {
        // Change views to edit mode.
        bEditing = true;
        self.weight.enabled = true;
        self.units.enabled = true;
        self.length.enabled = true;
        self.width.enabled = true;
        self.height.enabled = true;
        self.btnFreightClass.enabled = true;
        self.btnHandlingUnitType.enabled = true;
        self.nmfc.enabled=true;
        self.stackable.enabled=true;
        
        //self.freightDescription.editable = YES;
        if (!_isAdding)
            self.title = @"Edit freight Item Detail";
    }
    else
    {
        [self.view endEditing:YES];

        if (! [self isValid])
        {
            [self setEditing:YES animated:FALSE];
            return;
        }
        else
        {
            [_redLabel setHidden:true];
            // Save the changes if needed and change the views to noneditable.
            bEditing = false;
            self.weight.enabled = false;
            self.units.enabled = false;
            self.length.enabled = false;
            self.width.enabled = false;
            self.height.enabled = false;
            self.btnFreightClass.enabled = false;
            self.btnHandlingUnitType.enabled = false;
            self.stackable.enabled = false;
            self.nmfc.enabled = false;
            //self.freightDescription.editable = NO;

            // to do - validate input
            // if isValid
            [self saveFreightItem];
            self.title = @"Freight Item Detail";
        }
    }
}

#pragma mark - UITextFieldDelegate
// Close the keyboard if someone presses enter from any textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.isEditing)
    {
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // double
    if (textField == self.weight)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
    }
    
    // integers
    if (textField == self.units)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *expression =@"^([0-9]{1,5}+)?$";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
    }
    
    if (textField==self.nmfc)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString* expression = @"^([0-9-]{0,7})?$";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
    }

    if ((textField == self.length)
        || (textField == self.width)
        || (textField == self.height))
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *expression =@"^([0-9]{1,4}+)?$";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
    }
    
    return YES;
}


#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return self.isEditing;
}

-(BOOL) isValid
{
    BOOL bValid = YES;

    [_redLabel setHidden:true];
    
    // validate input
    double weight = [self.weight.text doubleValue];
    int handlingUnits = [self.units.text intValue];

    if ((weight <= 0) || (weight > 50000))
    {
        bValid = NO;
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:validationErrorTitle message:@"Weight is out of range." delegate:self  cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        //[alert show];
        if (weight <= 0)
            _redLabel.text = @"Weight is required.";
        else
            _redLabel.text = @"Weight is out of range.";
        
        [_redLabel setHidden:false];
        
    }
    else if (handlingUnits <= 0)
    {
        bValid = NO;
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:validationErrorTitle message:@"Handling Units are out of range." delegate:self  cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        //[alert show];
        _redLabel.text = @"Number of handling units is required.";
        [_redLabel setHidden:false];
        
    }
    return bValid;
}

-(void)saveFreightItem
{
    // populate freight item from input
    _freightItem.weight = [NSDecimalNumber decimalNumberWithString:self.weight.text];
    _freightItem.freightClass = [NSDecimalNumber decimalNumberWithString:self.btnFreightClass.titleLabel.text];
    _freightItem.freightDescription = self.freightDescription.text;
    _freightItem.handlingUnits = [noStyleFormatter numberFromString: self.units.text];
    _freightItem.handlingUnitTypeID = [_pickerHelper getHandlingUnitTypeID:self.btnHandlingUnitType.titleLabel.text];
    //_freightItem.isStackable = FALSE;
    _freightItem.length = [NSDecimalNumber decimalNumberWithString:self.length.text];
    _freightItem.width = [NSDecimalNumber decimalNumberWithString:self.width.text];
    _freightItem.height = [NSDecimalNumber decimalNumberWithString:self.height.text];
    _freightItem.nmfc = self.nmfc.text;
    _freightItem.isStackable = [NSNumber numberWithBool:self.stackable.isOn];
    
    if (_isAdding)
    {
       [_quoteRequest addFreightItemsObject:_freightItem];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    currentPickerSegue = nil;
    
    NSString* segueId = [segue identifier];
    
    [self.view endEditing:YES];
    
    if ([segueId isEqualToString:@"handlingUnitPopover"])
    {
        PickerPopoverViewController* pickerView = [segue destinationViewController];
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverViewController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.pickerPopoverController = popoverViewController;
        currentPickerSegue = segueId;
        pickerView.myPickerItems = _pickerHelper.handlingUnitTypes;
        pickerView.titleForSelectedRow = self.btnHandlingUnitType.titleLabel.text;
        pickerView.popoverTitleText = @"Handling Unit";
        popoverViewController.delegate = self;
    }

    if ([segueId isEqualToString:@"freightClassPopover"])
    {
        PickerPopoverViewController* pickerView = [segue destinationViewController];
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverViewController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.pickerPopoverController = popoverViewController;
        currentPickerSegue = segueId;
        pickerView.myPickerItems = _pickerHelper.freightClasses;
        pickerView.titleForSelectedRow = self.btnFreightClass.titleLabel.text;
        pickerView.popoverTitleText = @"Freight Class";
        popoverViewController.delegate = self;
    }
}

- (void)pickerPopoverViewControllerDidFinish:(PickerPopoverViewController *)controller
{
    [self.pickerPopoverController dismissPopoverAnimated:YES];
    self.pickerPopoverController = nil;
}

- (void)setObjectFromPicker:(id)object
{
    if (currentPickerSegue != nil && [currentPickerSegue isEqualToString:@"handlingUnitPopover"])
    {
        HandlingUnitType* h = object;
        [self.btnHandlingUnitType setTitle:h.handlingUnitTypeDescription forState:UIControlStateNormal];
        [self handlingUnitTypeChanged:[h.handlingUnitTypeID intValue]];
    }

    if (currentPickerSegue != nil && [currentPickerSegue isEqualToString:@"freightClassPopover"])
    {
        NSDecimalNumber* dec = object;
   
        [self.btnFreightClass setTitle:[decimalFormatter stringFromNumber:dec]forState:UIControlStateNormal];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.pickerPopoverController = nil;
}

- (IBAction)togglePopover:(id)sender
{
    if (self.pickerPopoverController)
    {
        [self.pickerPopoverController dismissPopoverAnimated:YES];
        self.pickerPopoverController = nil;
    }
    else
    {
        //UITableViewCell* cell = (UITableViewCell*)sender;
        //if ([cell.reuseIdentifier isEqualToString:@"PickupDateCell"])
        //    [self performSegueWithIdentifier:@"datePopoverSeguePU" sender:self];
        //else if ([cell.reuseIdentifier isEqualToString:@"DeliveryDateCell"])
        //    [self performSegueWithIdentifier:@"datePopoverSegueDL" sender:self];
    }
}

/*
-(void)initPickerItems
{
    _handlingUnitTypes = [[NSMutableArray alloc]init];

    // get accessorial type from data store
    NSError* error;
    // Test listing all QuoteRequests from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HandlingUnitType"
                                              inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];

    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"handlingUnitTypeDescription" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (HandlingUnitType *h in fetchedObjects)
    {
        [_handlingUnitTypes addObject:[[PickerItem alloc] initWithTitleObject:h.handlingUnitTypeDescription : h]];
    }
    
    _freightClasses = [[NSMutableArray alloc] init];

    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"50" :[NSDecimalNumber numberWithFloat:50.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"55" :[NSDecimalNumber numberWithFloat:55.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"60" :[NSDecimalNumber numberWithFloat:60.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"65" :[NSDecimalNumber numberWithFloat:65.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"70" :[NSDecimalNumber numberWithFloat:70.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"77.5" :[NSDecimalNumber numberWithFloat:77.5]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"85" :[NSDecimalNumber numberWithFloat:85.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"92.5" :[NSDecimalNumber numberWithFloat:92.5]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"100" :[NSDecimalNumber numberWithFloat:100.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"110" :[NSDecimalNumber numberWithFloat:110.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"125" :[NSDecimalNumber numberWithFloat:125.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"150" :[NSDecimalNumber numberWithFloat:150.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"175" :[NSDecimalNumber numberWithFloat:175.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"200" :[NSDecimalNumber numberWithFloat:200.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"250" :[NSDecimalNumber numberWithFloat:250.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"300" :[NSDecimalNumber numberWithFloat:300.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"400" :[NSDecimalNumber numberWithFloat:400.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"500" :[NSDecimalNumber numberWithFloat:500.0]]];
}

- (NSString*)getHandlingUnitName:(NSNumber*)htID
{
    NSString* ret = nil;
    for(PickerItem* p in _handlingUnitTypes)
    {
        if ( [((HandlingUnitType*)p.itemObject).handlingUnitTypeID isEqualToNumber:htID])
        {
            ret = p.itemTitle;
            break;
        }
    }
    
    return ret;
}

- (NSNumber*)getHandlingUnitTypeID:(NSString*)htName
{
    NSNumber* ret = nil;
    for(PickerItem* p in _handlingUnitTypes)
    {
        if ( [p.itemTitle isEqualToString:htName])
        {
            ret = ((HandlingUnitType*)p.itemObject).handlingUnitTypeID;
            break;
        }
    }
    
    return ret;
}
*/

- (IBAction)selectHandlingUnit:(id)sender
{
}

- (IBAction)selectFreightClass:(id)sender
{
}

- (IBAction)stackableChanged:(id)sender
{
    
   // UISwitch* theSwitch = (UISwitch*) sender;
   // _freightItem.isStackable =  [NSNumber numberWithBool:theSwitch.on];
    
}

-(void)handlingUnitTypeChanged:(int)handlingUnitTypeID
{
    BOOL matchesFreight = NO;
    
    matchesFreight = (handlingUnitTypeID == [_freightItem.handlingUnitTypeID intValue]);
    
    if ((handlingUnitTypeID == 1) || (handlingUnitTypeID==2))
    {
        if (handlingUnitTypeID==1)
        {
            self.length.text = @"48";
            self.width.text = @"40";
            self.height.text = @"";
        }

        if (handlingUnitTypeID==2)
        {
            self.length.text = @"48";
            self.width.text = @"48";
            self.height.text = @"";
        }
        
        self.length.enabled = false;
        self.width.enabled = false;
        self.height.enabled = false;
    }
    else
    {
        if (self.isEditing)
        {
            self.length.enabled = true;
            self.width.enabled = true;
            self.height.enabled = true;
            
            if (!matchesFreight)
            {
                self.length.text = @"";
                self.width.text = @"";
                self.height.text = @"";
            }
        }
    }
}

-(void)calculateDensity
{
    
}

@end
