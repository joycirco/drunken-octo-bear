//
//  UserSettingsViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "UserSettingsViewController.h"
#import "PickerHelper.h"
#import "HandlingUnitType.h"
#import "DataModel.h"
#import "User.h"
#import "UserSettings.h"
#import "DefaultAccessorialsViewController.h"
#import "QuickQuoteAppDelegate.h"

@interface UserSettingsViewController ()
{
    NSString* currentPickerSegue;
    NSNumberFormatter *decimalFormatter;
    
    UserSettings* _userSettings;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;


@end

@implementation UserSettingsViewController

@synthesize masterPopoverController = _masterPopoverController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize btnLogout;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;

    decimalFormatter = [[NSNumberFormatter alloc]init];
    [decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    _pickerHelper = [[PickerHelper alloc] initWithContext:_managedObjectContext];
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

    if (_managedObjectContext != nil)
    {
        NSError* error;
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return YES;
    return NO;
}

- (void)configureView
{
    BOOL hasSettings = NO;
    self.defOriginPostalCode.delegate = self;
    self.defDestinationPostalCode.delegate = self;
    
    [_pickerHelper initPickerItems];
    
    // get current user settings
    if ([DataModel sharedInstance].currentUser != nil)
    {
        _userSettings = [DataModel sharedInstance].currentUser.userSettings;
        
        // check if we really have settings
        if (_userSettings.defaultFreightClass != nil  && [_userSettings.defaultFreightClass doubleValue] >= 50.0 )
        {
            hasSettings = YES;
        }
    }
    
    if (! hasSettings)
    {
        _userSettings = [NSEntityDescription
                     insertNewObjectForEntityForName:@"UserSettings"
                     inManagedObjectContext:_managedObjectContext];
        _userSettings.defaultOriginPostalCode = @"";
        _userSettings.defaultDestinationPostalCode = @"";
        _userSettings.defaultFreightClass = [NSDecimalNumber decimalNumberWithString:@"50.0"];
        _userSettings.defaultHandlingUnitTypeID = [NSNumber numberWithInt:1];
       
        // add all of the accessorials to the defaults
        
        NSError* error;
        // Test listing all QuoteRequests from the store
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"PersistedAccessorial"
                                                  inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
       
        NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        [_userSettings addDefaultAccessorials:[NSSet setWithArray:fetchedObjects]];
        
        [DataModel sharedInstance].currentUser.userSettings = _userSettings;
    }

    self.defOriginPostalCode.text = _userSettings.defaultOriginPostalCode;
    self.defDestinationPostalCode.text = _userSettings.defaultDestinationPostalCode;
    [self.btnDefFreightClass setTitle:[decimalFormatter stringFromNumber:_userSettings.defaultFreightClass]forState:UIControlStateNormal];
    [self.btnDefHandlingUnitType setTitle:[_pickerHelper getHandlingUnitName:_userSettings.defaultHandlingUnitTypeID] forState:UIControlStateNormal];
}

-(void) saveSettings
{
    NSError* error = nil;
    
    if ([[DataModel sharedInstance].currentUser.userSettings.defaultFreightClass doubleValue] < 50.0)
    {
        [DataModel sharedInstance].currentUser.userSettings = _userSettings;
    }
    else
    {
        [DataModel sharedInstance].currentUser.userSettings.defaultOriginPostalCode = _userSettings.defaultOriginPostalCode;
        [DataModel sharedInstance].currentUser.userSettings.defaultDestinationPostalCode = _userSettings.defaultDestinationPostalCode;
        [DataModel sharedInstance].currentUser.userSettings.defaultFreightClass = _userSettings.defaultFreightClass;
        [DataModel sharedInstance].currentUser.userSettings.defaultHandlingUnitTypeID = _userSettings.defaultHandlingUnitTypeID;
    }
    
    if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        [self HandleError:error];
    }
}

-(void) HandleError:(NSError*) error{
    
    NSString *errorString = [error localizedDescription];
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%d)", error.code];
    UIAlertView *errorView =
    [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [errorView show];
}


#pragma mark - SubstitutableDetailViewController
#pragma mark Managing the popover

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    barButtonItem.title = NSLocalizedString(@"Shipment Information", @"Shipment Information");
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    currentPickerSegue = nil;
    
    NSString* segueId = [segue identifier];
    
    [self.view endEditing:YES];
    
    if ([segueId isEqualToString:@"defaultHandlingUnitPopover"])
    {
        PickerPopoverViewController* pickerView = [segue destinationViewController];
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverViewController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.pickerPopoverController = popoverViewController;
        currentPickerSegue = segueId;
        pickerView.myPickerItems = _pickerHelper.handlingUnitTypes;
        pickerView.titleForSelectedRow = self.btnDefHandlingUnitType.titleLabel.text;
        pickerView.popoverTitleText = @"Handling Unit";
        popoverViewController.delegate = self;
    }
    
    if ([segueId isEqualToString:@"defaultFreightClassPopover"])
    {
        PickerPopoverViewController* pickerView = [segue destinationViewController];
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverViewController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.pickerPopoverController = popoverViewController;
        currentPickerSegue = segueId;
        pickerView.myPickerItems = _pickerHelper.freightClasses;
        pickerView.titleForSelectedRow = self.btnDefFreightClass.titleLabel.text;
        pickerView.popoverTitleText = @"Freight Class";
        popoverViewController.delegate = self;
    }
    
    if ([segueId isEqualToString:@"defaultPickupAccessorials"])
    {
        DefaultAccessorialsViewController* defView = [segue destinationViewController];
        defView.managedObjectContext = self.managedObjectContext;
        defView.accessorialTypeID = [NSNumber numberWithInt:1];
        defView.userSettings = _userSettings;
    }
    
    if ([segueId isEqualToString:@"defaultDeliveryAccessorials"])
    {
        DefaultAccessorialsViewController* defView = [segue destinationViewController];
        defView.managedObjectContext = self.managedObjectContext;
        defView.accessorialTypeID = [NSNumber numberWithInt:2];
        defView.userSettings = _userSettings;
    }
    
    if ([segueId isEqualToString:@"defaultShipmentAccessorials"])
    {
        DefaultAccessorialsViewController* defView = [segue destinationViewController];
        defView.managedObjectContext = self.managedObjectContext;
        defView.accessorialTypeID = [NSNumber numberWithInt:3];
        defView.userSettings = _userSettings;
    }
    
    if ([segueId isEqualToString:@"defaultFreightAccessorials"])
    {
        DefaultAccessorialsViewController* defView = [segue destinationViewController];
        defView.managedObjectContext = self.managedObjectContext;
        defView.accessorialTypeID = [NSNumber numberWithInt:4];
        defView.userSettings = _userSettings;
    }
}

#pragma mark PickerPopoverViewDelegate
- (void)pickerPopoverViewControllerDidFinish:(PickerPopoverViewController *)controller
{
    [self.pickerPopoverController dismissPopoverAnimated:YES];
    self.pickerPopoverController = nil;
}

- (void)setObjectFromPicker:(id)object
{
    if (currentPickerSegue != nil && [currentPickerSegue isEqualToString:@"defaultHandlingUnitPopover"])
    {
        HandlingUnitType* h = object;
        [self.btnDefHandlingUnitType setTitle:h.handlingUnitTypeDescription forState:UIControlStateNormal];
        _userSettings.defaultHandlingUnitTypeID = h.handlingUnitTypeID;
    }
    
    if (currentPickerSegue != nil && [currentPickerSegue isEqualToString:@"defaultFreightClassPopover"])
    {
        NSDecimalNumber* dec = object;
        
        [self.btnDefFreightClass setTitle:[decimalFormatter stringFromNumber:dec]forState:UIControlStateNormal];
        _userSettings.defaultFreightClass = dec;
    }
}

-(void)handlingUnitTypeChanged:(int)handlingUnitTypeID
{
}


#pragma mark - UITextFieldDelegate
// Close the keyboard if someone presses enter from any textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.defOriginPostalCode)
        _userSettings.defaultOriginPostalCode = self.defOriginPostalCode.text;
    
    if (textField == self.defDestinationPostalCode)
        _userSettings.defaultDestinationPostalCode = self.defDestinationPostalCode.text;

    [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // zip codes
    if (textField == self.defOriginPostalCode || textField == self.defDestinationPostalCode)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *expression =@"^([a-zA-Z0-9-]{0,10})?$";
        
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

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)actionResetDefaults:(id)sender {
}

- (IBAction)logout:(id)sender
{
    NSLog(@"logout");
    QuickQuoteAppDelegate *appDelegate = (QuickQuoteAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate logout];
    //[appDelegate.masterNavigationController pushViewController:
}
@end
