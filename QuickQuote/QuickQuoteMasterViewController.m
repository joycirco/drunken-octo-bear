//
//  QuickQuoteMasterViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 1/24/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "QuickQuoteMasterViewController.h"
#import "QuickQuoteDetailViewController.h"
#import "QuickQuoteResultsViewController.h"
#import "FreightItemsViewController.h"
#import "AccessorialsViewController.h"
#import "UserSettingsViewController.h"

#import "QuoteRequest.h"
#import "Credentials.h"
#import "FreightItem.h"
#import "Accessorial.h"
#import "HandlingUnitType.h"

#import "DatePopoverViewController.h"

#import "RSPRateServicePrivileged.h"
#import "RSPArrayOfRateResponsePrivileged.h"
#import "RateResponse.h"
#import "QuoteReturn.h"
#import "Company.h"
#import "UserSettings.h"

#import "DataModel.h"
#import "User.h"

#import "PersistedContext.h"
#import "CarrierImage.h"

@interface QuickQuoteMasterViewController ()
{
    NSMutableArray *_objects;
    UITableViewCell* linkedDateCell;
    
    NSMutableDictionary* huMap;
    UserSettings* _userSettings;
   
}

- (void)configureView;
- (BOOL)canQuote;
-(QuoteRequest*) createNewQuoteRequest:(NSManagedObjectContext*)context :(UserSettings*)userSettings;

@end

@implementation QuickQuoteMasterViewController


/******  Swapable Detail View Code ******/
@synthesize masterPopoverController, splitViewController, rootPopoverButtonItem;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize quoteRequests = _quoteRequests;
@synthesize persistedContext = _persistedContext;

@synthesize dateToSet = _dateToSet;
@synthesize quoteReturn = _quoteReturn;
@synthesize quoteRequest = _quoteRequest;

@synthesize quickQuoteDetailViewController; // for home

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    _userSettings = [DataModel sharedInstance].currentUser.userSettings;
    
    // get quote request from data store (1st one for now)
    //_quoteRequest = [[self.fetchedResultsController fetchedObjects] objectAtIndex:0];

    // create new quote request if necessary
    if (_quoteRequest == nil)
        _quoteRequest = [self createNewQuoteRequest:_managedObjectContext :_userSettings];
    
    // load map for handling units
    huMap = [[NSMutableDictionary alloc]init];
   
    // get handling unit types from data store
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HandlingUnitType"
                                              inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray* hu = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for(HandlingUnitType* h in hu)
    {
        [huMap setObject:h forKey:h.handlingUnitTypeID];
    }
    
    // call this to init fetched controller
    [self fetchedResultsController];

    //[self configureView];
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
    
    [self configureView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (void)configureView
{
    User* currentUser = [DataModel sharedInstance].currentUser;
    if (currentUser != nil && currentUser.loginName != nil)
    {
        self.btnUserSettings.enabled = true;
        self.btnUserSettings.title = [DataModel sharedInstance].currentUser.loginName;
    }

    _userSettings = [DataModel sharedInstance].currentUser.userSettings;

    self.originZip.delegate = self;
    self.destinationZip.delegate = self;
    self.storeLocationCode.delegate = self;

    //self.btnRate.enabled=NO;
    
    if (_quoteRequest != nil)
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        
        self.cellPickupDate.detailTextLabel.text = [dateFormat stringFromDate:_quoteRequest.pickupDateTime];
        self.cellDeliveryDate.detailTextLabel.text = [dateFormat stringFromDate:_quoteRequest.deliveryDateTime];
        
        self.originZip.text = _quoteRequest.originPostalCode;
        self.destinationZip.text = _quoteRequest.destinationPostalCode;
        self.storeLocationCode.text = _quoteRequest.storeLocationCode;
        self.cellFreightSummary.detailTextLabel.text = @"0";
        
        if (_quoteRequest.freightItems != nil)
        {
            NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
            [numFormat setNumberStyle:NSNumberFormatterNoStyle];
            self.cellFreightSummary.textLabel.text = [NSString stringWithFormat:@"# Items: %d", _quoteRequest.freightItems.count];
            
            float totWeight = 0;
            NSString* uomWeight = @"";
            for (FreightItem* f in _quoteRequest.freightItems)
            {
                totWeight += [f.weight floatValue];
                uomWeight = f.weightUOM;
            }
            NSDecimalNumber* w = [[NSDecimalNumber alloc] initWithFloat:totWeight];
            self.cellFreightSummary.detailTextLabel.text = [NSString stringWithFormat:@"Weight: %@%@", [numFormat stringFromNumber:w], uomWeight];
        }
    
        int accPickup = 0;
        int accDeliver = 0;
        int accShip = 0;
        for(Accessorial* acc in _quoteRequest.accessorials)
        {
            if (acc.accessorialTypeID == [NSNumber numberWithInt:1])
                accPickup++;

            if (acc.accessorialTypeID == [NSNumber numberWithInt:2])
                accDeliver++;
            
            if (acc.accessorialTypeID == [NSNumber numberWithInt:3])
                accShip++;
            
        }
    
        self.cellPickupAccessorials.detailTextLabel.text = [NSString stringWithFormat:@"%d", accPickup];
        self.cellDeliveryAccessorials.detailTextLabel.text = [NSString stringWithFormat:@"%d", accDeliver];
        self.cellShipmentAccessorials.detailTextLabel.text = [NSString stringWithFormat:@"%d", accShip];
    }
    
    //self.btnRate.enabled = [self canQuote];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString* segueId = [segue identifier];
    
    if (([segueId isEqualToString:@"datePopoverSeguePU"]) ||
        ([segueId isEqualToString:@"datePopoverSegueDL"]))
    {
        DatePopoverViewController* datePickerView = [segue destinationViewController];
        datePickerView.delegate = self;
        linkedDateCell = (UITableViewCell*)sender;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        datePickerView.intitialDate = [dateFormatter dateFromString:linkedDateCell.detailTextLabel.text];
        if ([segueId isEqualToString:@"datePopoverSeguePU"])
            datePickerView.titleText = @"Pickup Date";
        else
            datePickerView.titleText = @"Delivery Date";

        //[[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverDateController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.datePopoverController = popoverDateController;
        popoverDateController.delegate = self;
    }
    else
    {
        /******  Swapable Detail View Code ******/
        if ((rootPopoverButtonItem != nil)
            || [segueId isEqualToString:@"quoteResultsSegue"]
            || [segueId isEqualToString:@"freightItemsSegue"]
            || [segueId isEqualToString:@"pickupAccessorialsSegue"]
            || [segueId isEqualToString:@"deliveryAccessorialsSegue"]
            || [segueId isEqualToString:@"shipmentAccessorialsSegue"]
            || [segueId isEqualToString:@"ratingInProgress"]
            || [segueId isEqualToString:@"userSettingsSegue"]
            || [segueId isEqualToString:@"homeViewSegue"]
            )
        {
            UIViewController<SubstitutableDetailViewController>* detailViewController = (UIViewController<SubstitutableDetailViewController>*)[segue.destinationViewController topViewController];

            // stop any activity indicators if we are rating
            [detailViewController stopActivityIndicator];
            
            // send necessary data to Detail View
            if ([segueId isEqualToString:@"ratingInProgress"])
            {
                [detailViewController startActivityIndicator];
            }
            
            // send necessary data to Detail View
            if ([segueId isEqualToString:@"quoteResultsSegue"])
            {
                if (_quoteReturn != nil && _quoteReturn.rateResponses != nil)
                {
                    ((QuickQuoteResultsViewController*)detailViewController).managedObjectContext = _managedObjectContext;
                    [(QuickQuoteResultsViewController*)detailViewController setRateResponseList:_quoteReturn.rateResponses];
                }
            }
            
            // send necessary data to Detail View
            if ([segueId isEqualToString:@"freightItemsSegue"])
            {
                FreightItemsViewController* detailView = (FreightItemsViewController*)detailViewController;
                detailView.managedObjectContext = self.managedObjectContext;
                detailView.quoteRequest = _quoteRequest;
                detailView.gotoAddFreight = (_quoteRequest.freightItems.count == 0);
            }
            
            // send necessary data to Detail View
            if ([segueId isEqualToString:@"pickupAccessorialsSegue"])
            {
                AccessorialsViewController* accView = (AccessorialsViewController*)detailViewController;
                accView.managedObjectContext = self.managedObjectContext;
                accView.quoteRequest = _quoteRequest;
                accView.accessorialTypeID = [NSNumber numberWithInt:1];
            }

            // send necessary data to Detail View
            if ([segueId isEqualToString:@"deliveryAccessorialsSegue"])
            {
                AccessorialsViewController* accView = (AccessorialsViewController*)detailViewController;
                accView.managedObjectContext = self.managedObjectContext;
                accView.quoteRequest = _quoteRequest;
                accView.accessorialTypeID = [NSNumber numberWithInt:2];
            }
            
            // send necessary data to Detail View
            if ([segueId isEqualToString:@"shipmentAccessorialsSegue"])
            {
                AccessorialsViewController* accView = (AccessorialsViewController*)detailViewController;
                accView.managedObjectContext = self.managedObjectContext;
                accView.quoteRequest = _quoteRequest;
                accView.accessorialTypeID = [NSNumber numberWithInt:3];
            }

            // send necessary data to Detail View
            if ([segueId isEqualToString:@"userSettingsSegue"])
            {
                UserSettingsViewController* uView = (UserSettingsViewController*)detailViewController;
                uView.managedObjectContext = self.managedObjectContext;
            }

            // send necessary data to Detail View
            if ([segueId isEqualToString:@"freightItemsSegue"])
            {
                FreightItemsViewController* detailView = (FreightItemsViewController*)detailViewController;
                detailView.managedObjectContext = self.managedObjectContext;
                detailView.quoteRequest = _quoteRequest;
            }
            
            // send necessary data to Detail View
            if ([segueId isEqualToString:@"homeViewSegue"])
            {
                QuickQuoteDetailViewController* detailView = (QuickQuoteDetailViewController*)detailViewController;
                detailView.managedObjectContext = self.managedObjectContext;
                quickQuoteDetailViewController = detailView; // save 
                //[detailView configureBackgroundImage];
            }

            if (rootPopoverButtonItem != nil)
                [detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
        }
        
        // don't hide for home screen reset
        if (! [segueId isEqualToString:@"homeViewSegue"])
        {
            if (masterPopoverController != nil)
            {
                [masterPopoverController dismissPopoverAnimated:YES];
            }
        }
    }
    
//    if (masterPopoverController != nil)
//    {
//        [masterPopoverController dismissPopoverAnimated:YES];
//    }
}

#pragma mark - Fetched results controller
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"QuoteRequest" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:1];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
    {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
}

// implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
     _quoteRequest = [[self.fetchedResultsController fetchedObjects] objectAtIndex:0];
    
     [self configureView];
 }

#pragma mark - UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
    
    // Keep references to the popover controller and the popover button, and tell the detail view controller to show the button.
    barButtonItem.title = @"Root View Controller";
    self.masterPopoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    UIViewController <SubstitutableDetailViewController> *detailViewController = (UIViewController<SubstitutableDetailViewController>*)[[splitViewController.viewControllers objectAtIndex:1] topViewController];
    [detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
}


- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    UIViewController <SubstitutableDetailViewController> *detailViewController = (UIViewController<SubstitutableDetailViewController>*)[[splitViewController.viewControllers objectAtIndex:1] topViewController];
    [detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    self.masterPopoverController = nil;
    self.rootPopoverButtonItem = nil;
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
    //NSLog([NSString stringWithFormat:@"textField ended editing... value is:%@",textField.text]);
    if (textField == self.originZip)
        _quoteRequest.originPostalCode = self.originZip.text;
    
    if (textField == self.destinationZip)
        _quoteRequest.destinationPostalCode = self.destinationZip.text;
    
    if (textField == self.storeLocationCode)
        _quoteRequest.storeLocationCode = self.storeLocationCode.text;
    
    [self configureView];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // zip codes
    if (textField == self.originZip || textField == self.destinationZip)
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   /* if(textField == self.storeLocationCode)
    {
        BOOL editingDate;
        editingDate = YES;
        UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 320, 320, 216)];
        UIDatePicker *pv = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0,320,216)];
        [myView addSubview:pv];
        
        [self.view.superview addSubview:myView];
        pv.userInteractionEnabled = YES;
        textField.placeholder = @"currently selecting below";
        [self scrollTheView:YES];
        return NO;
    } */
    return YES;
}


- (void)scrollTheView:(BOOL) moveUp
{
    int scrollAmount = 212;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.view.frame;
    if(moveUp)
    {
        rect.origin.y -= scrollAmount;
    }
    else
    {
        rect.origin.y += scrollAmount;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}


#pragma mark - Date Popover Delegate

- (void)datePopoverViewControllerDidFinish:(DatePopoverViewController *)controller
{
    [self.datePopoverController dismissPopoverAnimated:YES];
    self.datePopoverController = nil;
}

- (void)setDateFromPopover:(NSDate *)aDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    if (linkedDateCell != nil)
    {
        linkedDateCell.detailTextLabel.text = [dateFormat stringFromDate:aDate];
        
        // set pickup date for quote as well
        if (linkedDateCell == self.cellPickupDate)
            _quoteRequest.pickupDateTime = aDate;

        // set delivery date for quote as well
        if (linkedDateCell == self.cellDeliveryDate)
            _quoteRequest.deliveryDateTime = aDate;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.datePopoverController = nil;
}

- (IBAction)togglePopover:(id)sender
{
    if (self.datePopoverController)
    {
        [self.datePopoverController dismissPopoverAnimated:YES];
        self.datePopoverController = nil;
    }
    else
    {
        UITableViewCell* cell = (UITableViewCell*)sender;
        if ([cell.reuseIdentifier isEqualToString:@"PickupDateCell"])
            [self performSegueWithIdentifier:@"datePopoverSeguePU" sender:self];
        else if ([cell.reuseIdentifier isEqualToString:@"DeliveryDateCell"])
            [self performSegueWithIdentifier:@"datePopoverSegueDL" sender:self];
        
    }
}

/*
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[managedObject valueForKey:@"timeStamp"] description];
}
*/

-(BOOL)canQuote
{
    BOOL bRet = NO;
    
    bRet = [self isValid];
    
    return bRet;
}

-(BOOL)isValid
{
    if (_quoteRequest == nil)
        return NO;
    
    if (_quoteRequest != nil && _quoteRequest.freightItems.count == 0)
        return NO;
    
    if (_quoteRequest.originPostalCode == nil || _quoteRequest.originPostalCode.length < 5)
        return NO;

    if (_quoteRequest.destinationPostalCode == nil || _quoteRequest.destinationPostalCode.length < 5)
        return NO;
    //if (! [self stringIsValid:self.originZip.text :@"^(\\d{5}(-\\d{4})?$|^([ABCEGHJKLMNPRSTVXY]{1}\\d{1}[A-Z]{1} *\\d{1}[A-Z]{1}\\d{1})?$"])
    //    return NO;

    //if (! [self stringIsValid:self.destinationZip.text :@"^(\\d{5}(-\\d{4})?$|^([ABCEGHJKLMNPRSTVXY]{1}\\d{1}[A-Z]{1} *\\d{1}[A-Z]{1}\\d{1})?$"])
    //    return NO;

    self.navigationItem.prompt = nil;
    return YES;
}

-(BOOL)stringIsValid:(NSString*)stringToValidate :(NSString*)regExpression
{
    NSRange range = [stringToValidate rangeOfString:stringToValidate];

    NSString *newString = [stringToValidate stringByReplacingCharactersInRange:range withString:stringToValidate];
   
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExpression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                        options:0
                                                          range:NSMakeRange(0, [newString length])];
    if (numberOfMatches == 0)
        return NO;

    return YES;
}

-(QuoteRequest*)createNewQuoteRequest:(NSManagedObjectContext *)context :(UserSettings*)userSettings
{
    QuoteRequest *request = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"QuoteRequest"
                                  inManagedObjectContext:context];
    [request setDefaults];
    
    if (userSettings.defaultOriginPostalCode != nil )
        request.originPostalCode = userSettings.defaultOriginPostalCode;
    
    if (userSettings.defaultDestinationPostalCode != nil )
        request.destinationPostalCode = userSettings.defaultDestinationPostalCode;
    
    return request;
}

#pragma mark - QuoickQuoteMasterView Actions

- (IBAction)resetAction:(id)sender
{
    if (_quoteRequest != nil)
    {
        [_managedObjectContext deleteObject:_quoteRequest];
    }
    
    _quoteRequest = [self createNewQuoteRequest:_managedObjectContext :_userSettings];
    
    [self configureView];

    [self performSegueWithIdentifier:@"homeViewSegue" sender:self];
}

- (IBAction)rateAction:(id)sender
{
    if ([self canQuote])
    {
        [self performSegueWithIdentifier:@"ratingInProgress" sender:self];

        Enterprise *e = [[DataModel sharedInstance].currentUser getCurrentEnterprise];
        Company *c = [e getCurrentCompany];
        _quoteRequest.credentials = c.credentials;
        
        // Create the service
        RSPRateServicePrivileged* service = [[RSPRateServicePrivileged alloc] init];
        service.logging = YES;
        
        service.username = _quoteRequest.credentials.loginName;
        service.password = _quoteRequest.credentials.password;
        
        RSPRateRequestPrivileged* reqRRP = [[RSPRateRequestPrivileged alloc] init];
        reqRRP.reqLoginName = _quoteRequest.credentials.loginName;
        reqRRP.reqLoginPassword = _quoteRequest.credentials.password;
        reqRRP.reqAccountId = _quoteRequest.credentials.accountId;
        if (self.storeLocationCode.text != nil)
            reqRRP.reqRoutingCustomerCode =  _quoteRequest.storeLocationCode; // = self.storeLocationCode.text;
        reqRRP.reqLoginToken = _quoteRequest.credentials.token;
        
        reqRRP.reqOriginZip = _quoteRequest.originPostalCode; // = self.originZip.text;
        reqRRP.reqDestZip = _quoteRequest.destinationPostalCode; // = self.destinationZip.text;
        
        reqRRP.reqPickupDate = _quoteRequest.pickupDateTime;
        
        //int daysToAdd = 3;
        //NSDate *newDate1 = [_quoteRequest.pickupDateTime dateByAddingTimeInterval:60*60*24*daysToAdd];
        //reqRRP.reqDropDate = newDate1;
        reqRRP.reqDropDate = _quoteRequest.deliveryDateTime;
        
        // keep track if any freight is stackable
        BOOL isStackable = NO;
        int palletCount = 0;
        // iterate through the freight items
        if (_quoteRequest.freightItems != nil)
        {
            for(FreightItem* fqr in _quoteRequest.freightItems)
            {
                //[fqr performSelector];
                RSPFreight* f = [[RSPFreight alloc] init];
                f.freightClass = fqr.freightClass;
                f.weight = fqr.weight;
                f.units = [fqr.handlingUnits intValue];
                if ([fqr.length doubleValue] > 0)
                    f.length = fqr.length;
                if ([fqr.width doubleValue] > 0)
                    f.width = fqr.width;
                if ([fqr.height doubleValue] > 0)
                    f.height = fqr.height;
                
                if ([fqr.isStackable boolValue])
                    isStackable = YES;
                
                [reqRRP.reqFreight addObject: f];
                
                
                //freight is pallet ?
                HandlingUnitType* hu = [huMap objectForKey:fqr.handlingUnitTypeID];
                if ((hu != nil) && ([hu.handlingUnitTypeCode isEqualToString:@"PLT"] || [hu.handlingUnitTypeCode isEqualToString:@"SKD"]))
                {
                    // add pallet position
                    RSPPalletPositions* pp = [[RSPPalletPositions alloc] init];
                    if ([fqr.length doubleValue] > 0)
                        pp.length = [fqr.length doubleValue];
                    if ([fqr.width doubleValue] > 0)
                        pp.width = [fqr.width doubleValue];
                    if ([fqr.height doubleValue] > 0)
                        pp.height = [fqr.height doubleValue];
                    pp.weight = [fqr.weight doubleValue];
                    pp.positionCount = [fqr.handlingUnits integerValue];
                    palletCount += [fqr.handlingUnits integerValue];
                    [reqRRP.reqPalletPositions addObject: pp];
                }
            }
        }
        
        // set stackable
        reqRRP.reqFreightStackable = isStackable;
        
        // set pallet count
        reqRRP.reqPalletCount = palletCount;
        
        // iterate through accessorials
        if (_quoteRequest.accessorials != nil)
        {
            for(Accessorial* acc in _quoteRequest.accessorials)
            {
                RSPAccessorial* a = [[RSPAccessorial alloc]init];
                a.accCode = acc.accessorialCode;
                [reqRRP.reqAccessorials addObject:a];
            }
        }
        
        reqRRP.reqViewSpecificCostContracts = true;
        reqRRP.reqViewGeneralCostContracts = true;
        reqRRP.reqViewGeneralBillingContracts = true;
        reqRRP.reqViewSpecificBillingContracts = true;
        reqRRP.reqViewWebCostContracts = true;
        reqRRP.reqViewWebBillingContracts = true;
        reqRRP.reqViewRatingCost = 0;
        
        [service RateShipment:self action:@selector(RateShipmentHandler:) rrp: reqRRP];
    }
    else
    {
        self.navigationItem.prompt = @"* Required Items *";
    }
}

// Handle the response from RateShipment.
- (void) RateShipmentHandler: (id) value
{
	// Handle errors
	if([value isKindOfClass:[NSError class]])
    {
		NSLog(@"%@", value);
        [self HandleError:value];
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]])
    {
		NSLog(@"%@", value);
        [self HandleSoapFault:value];
		return;
	}
        
	// Do something with the RSPRateReturn* result
    RSPRateReturn* result = (RSPRateReturn*)value;
	NSLog(@"RateShipment returned the value: %@", result);
    
    //QuickQuoteResultsViewController* view = self.detailViewController;
    //if (result != nil && result.rrp != nil && view != nil)
    if (result != nil && result.rrp != nil)
    {
        _quoteReturn = [QuoteReturn createWithRSPRateReturn:result];
        
        if (_quoteReturn != nil && _quoteReturn.rateResponses != nil && _quoteReturn.rateResponses.count > 0)
        {
            for (RateResponse* r in _quoteReturn.rateResponses)
            {
                [self setCarrierImage:r];
            }
            
            [self performSegueWithIdentifier:@"quoteResultsSegue" sender:self];
        }
        else
        {
            if (_quoteReturn.rateErrors != nil && _quoteReturn.rateErrors.count > 0)
            {
                [self HandleRSPError:_quoteReturn.rateErrors[0]];
            }
            else
            {
                NSString* errorString = @"No carriers returned for the given quote request paramters.";
                UIAlertView *errorView =
                [[UIAlertView alloc] initWithTitle:@"No rates returned." message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [errorView show];
            }
            
            [self performSegueWithIdentifier:@"homeViewSegue" sender:self];
        }
    }
}

-(void)setCarrierImage:(RateResponse*)rate
{
    bool hasImage = NO;
    for(CarrierImage* ci in _persistedContext.carrierImages)
    {
        if ([ci.scac isEqualToString:rate.carrierScac])
        {
            rate.carrierImage = ci.carrierImage;
            hasImage = YES;
            break;
        }
    }
    
    if (!hasImage )
    {
        rate.carrierImage = [UIImage imageNamed:@"xxxx.png"];
    }
}

-(void) HandleError:(NSError*) error{

    NSString *errorString = [error localizedDescription];
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%d)", error.code];
    UIAlertView *errorView =
    [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [errorView show];
}

-(void) HandleSoapFault:(SoapFault*) error{
    
    NSString *errorString = error.description;
    NSString *errorTitle = [NSString stringWithFormat:@"SOAP Error (%@)", error.faultCode];
    UIAlertView *errorView =
    [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [errorView show];
}

-(void) HandleRSPError:(RSPRateError*) error{
    
    NSString *errorString = error.errorMessage;
    NSString *errorTitle = [NSString stringWithFormat:@"RateService Error (%d)", error.errorId];
    UIAlertView *errorView =
    [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [errorView show];
}


- (UIViewController *)topViewController{
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

@end
