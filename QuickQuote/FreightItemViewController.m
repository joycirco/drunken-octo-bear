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

@interface FreightItemViewController ()
{
    UIPopoverController *masterPopoverController;

    NSNumberFormatter *decimalFormatter;
    NSNumberFormatter *noStyleFormatter;
    NSString* currentPickerSegue;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;
- (void)saveFreightItem;
- (void)initPickerItems;
- (NSString*)getHandlingUnitName:(NSNumber*)htID;
- (NSNumber*)getHandlingUnitTypeID:(NSString*)htName;

@end

@implementation FreightItemViewController

@synthesize masterPopoverController = _masterPopoverController;
@synthesize freightItem = _freightItem;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize quoteRequest = _quoteRequest;
@synthesize isAdding = _isAdding;

@synthesize freightClasses = _freightClasses;
@synthesize handlingUnitTypes = _handlingUnitTypes;


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

    [self configureView];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - SubstitutableDetailViewController
#pragma mark Managing the popover

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

- (void)startActivityIndicator
{
}

-(void)stopActivityIndicator
{
}

- (void)configureView
{
    [self initPickerItems];
    
    // Update the user interface for the freight item.
    if (_isAdding)
    {
        _freightItem = [NSEntityDescription
                        insertNewObjectForEntityForName:@"FreightItem"
                        inManagedObjectContext:_managedObjectContext];
        
        [_freightItem setDefaults];
        
        self.title = @"Add Freight Item...";
    }
    
    self.weight.delegate = self;
    self.units.delegate = self;
    self.length.delegate = self;
    self.width.delegate = self;
    self.height.delegate = self;

    if (! self.editing)
    {
        self.weight.enabled = false;
        self.units.enabled = false;
        self.length.enabled = false;
        self.width.enabled = false;
        self.height.enabled = false;
        self.btnFreightClass.enabled = false;
        self.btnHandlingUnitType.enabled = false;
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
        [self.btnHandlingUnitType setTitle:[self getHandlingUnitName:_freightItem.handlingUnitTypeID] forState:UIControlStateNormal];
        
        if (_freightItem.freightDescription != nil && _freightItem.freightDescription.length)
            self.freightDescription.text = _freightItem.freightDescription;
        
        self.length.text = [decimalFormatter stringFromNumber:_freightItem.length];
        self.width.text = [decimalFormatter stringFromNumber:_freightItem.width];
        self.height.text = [decimalFormatter stringFromNumber:_freightItem.height];
    }
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    bool bEditing;
    
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
        //self.freightDescription.editable = YES;
        if (!_isAdding)
            self.title = @"Edit freight Item Detail";
    }
    else
    {
        // Save the changes if needed and change the views to noneditable.
        bEditing = false;
        self.weight.enabled = false;
        self.units.enabled = false;
        self.length.enabled = false;
        self.width.enabled = false;
        self.height.enabled = false;
        self.btnFreightClass.enabled = false;
        self.btnHandlingUnitType.enabled = false;
        //self.freightDescription.editable = NO;

        // to do - validate input
        // if isValid
        [self saveFreightItem];
        self.title = @"Freight Item Detail";
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.isEditing)
    {
        
    }
}

-(void)saveFreightItem
{
    // populate freight item from input
    _freightItem.weight = [NSDecimalNumber decimalNumberWithString:self.weight.text];
    _freightItem.freightClass = [NSDecimalNumber decimalNumberWithString:self.btnFreightClass.titleLabel.text];
    _freightItem.freightDescription = self.freightDescription.text;
    _freightItem.handlingUnits = [noStyleFormatter numberFromString: self.units.text];
    _freightItem.handlingUnitTypeID = [self getHandlingUnitTypeID:self.btnHandlingUnitType.titleLabel.text];
    _freightItem.isStackable = FALSE;
    _freightItem.length = [NSDecimalNumber decimalNumberWithString:self.length.text];
    _freightItem.width = [NSDecimalNumber decimalNumberWithString:self.width.text];
    _freightItem.height = [NSDecimalNumber decimalNumberWithString:self.height.text];
        
    if (_isAdding)
    {
       [_quoteRequest addFreightItemsObject:_freightItem];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    currentPickerSegue = nil;
    
    NSString* segueId = [segue identifier];
    
    if ([segueId isEqualToString:@"handlingUnitPopover"])
    {
        PickerPopoverViewController* pickerView = [segue destinationViewController];
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverViewController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.pickerPopoverController = popoverViewController;
        currentPickerSegue = segueId;
        pickerView.myPickerItems = _handlingUnitTypes;
        pickerView.titleForSelectedRow = self.btnHandlingUnitType.titleLabel.text;
        popoverViewController.delegate = self;
    }

    if ([segueId isEqualToString:@"freightClassPopover"])
    {
        PickerPopoverViewController* pickerView = [segue destinationViewController];
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverViewController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.pickerPopoverController = popoverViewController;
        currentPickerSegue = segueId;
        pickerView.myPickerItems = _freightClasses;
        pickerView.titleForSelectedRow = self.btnFreightClass.titleLabel.text;
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

- (IBAction)selectHandlingUnit:(id)sender {
}

- (IBAction)selectFreightClass:(id)sender {
}
@end