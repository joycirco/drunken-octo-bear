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

#import "QuoteRequest.h"
#import "Credentials.h"
#import "FreightItem.h"
#import "DatePopoverViewController.h"

#import "RSPRateServicePrivileged.h"
#import "RSPArrayOfRateResponsePrivileged.h"
#import "RateResponse.h"
#import "QuoteReturn.h"


@interface QuickQuoteMasterViewController ()
{
    NSMutableArray *_objects;
    UITableViewCell* linkedDateCell;
    
    UIActivityIndicatorView* _progress_ind;
}

- (void)configureView;

@end

@implementation QuickQuoteMasterViewController


/******  Swapable Detail View Code ******/
@synthesize masterPopoverController, splitViewController, rootPopoverButtonItem;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize quoteRequests = _quoteRequests;

@synthesize dateToSet = _dateToSet;
@synthesize quoteReturn = _quoteReturn;
@synthesize quoteRequest = _quoteRequest;

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

    // get quote request from data store (1st one for now)
    _quoteRequest = [[self.fetchedResultsController fetchedObjects] objectAtIndex:0];

    [self configureView];
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

    self.btnRate.enabled=NO;
    
    if (_quoteRequest != nil)
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        
        self.cellPickupDate.detailTextLabel.text = [dateFormat stringFromDate:_quoteRequest.pickupDateTime];
        
        self.originZip.text = _quoteRequest.originPostalCode;
        self.destinationZip.text = _quoteRequest.destinationPostalCode;
        self.cellFreightSummary.detailTextLabel.text = @"0";
        
        if (_quoteRequest.freightItems != nil)
        {
            NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
            [numFormat setNumberStyle:NSNumberFormatterNoStyle];
            self.cellFreightSummary.detailTextLabel.text = [NSString stringWithFormat:@"%d", _quoteRequest.freightItems.count];
            
            self.btnRate.enabled = _quoteRequest.freightItems.count > 0;
        }
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString* segueId = [segue identifier];
    
    if (([segueId isEqualToString:@"datePopoverSeguePU"]) ||
        ([segueId isEqualToString:@"datePopoverSegueDL"]))
    {
        DatePopoverViewController* datePickerView = [segue destinationViewController];
        datePickerView.delegate = self;
        [[segue destinationViewController] setDelegate:self];
        linkedDateCell = (UITableViewCell*)sender;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        //_dateToSet = [dateFormatter dateFromString:linkedDateCell.detailTextLabel.text];
        datePickerView.intitialDate = [dateFormatter dateFromString:linkedDateCell.detailTextLabel.text];

        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverDateController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.datePopoverController = popoverDateController;
        popoverDateController.delegate = self;
    }
        
    /******  Swapable Detail View Code ******/
    if ((rootPopoverButtonItem != nil)
        || [segueId isEqualToString:@"quoteResultsSegue"]
        || [segueId isEqualToString:@"freightItemsSegue"]
        || [segueId isEqualToString:@"pickupAccessorialsSegue"]
        || [segueId isEqualToString:@"deliveryAccessorialsSegue"]
        || [segueId isEqualToString:@"shipmentAccessorialsSegue"]
        || [segueId isEqualToString:@"ratingInProgress"]
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
                [(QuickQuoteResultsViewController*)detailViewController setRateResponseList:_quoteReturn.rateResponses];
            }
        }
        
        // send necessary data to Detail View
        if ([segueId isEqualToString:@"freightItemsSegue"])
        {
            FreightItemsViewController* detailView = (FreightItemsViewController*)detailViewController;
            detailView.managedObjectContext = self.managedObjectContext;
            detailView.quoteRequest = _quoteRequest;
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
        
        if (rootPopoverButtonItem != nil)
            [detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
    }
    
    if (masterPopoverController != nil)
    {
        [masterPopoverController dismissPopoverAnimated:YES];
    }
    
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
	if (![self.fetchedResultsController performFetch:&error]) {
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

// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
     // In the simplest, most efficient, case, reload the table view.
     //[self.tableView reloadData];
     
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
        linkedDateCell.detailTextLabel.text = [dateFormat stringFromDate:aDate];
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

#pragma mark - FetchedFreightItemsDelegate
-(void)didUpdateFreightItems:(NSMutableArray*) freightItems
{
    
}

- (IBAction)rateAction:(id)sender {
    
    [self performSegueWithIdentifier:@"ratingInProgress" sender:self];
    
    // clear the list
    //QuickQuoteResultsViewController* view = self.detailViewController;
    //if (view != nil)
    //    [view clearRateResponseList];
    
	// Create the service
	RSPRateServicePrivileged* service = [[RSPRateServicePrivileged alloc] init];
	service.logging = YES;
    
    service.username = _quoteRequest.credentials.loginName;
	service.password = _quoteRequest.credentials.password;
    
    RSPRateRequestPrivileged* reqRRP = [[RSPRateRequestPrivileged alloc] init];
    reqRRP.reqLoginName = _quoteRequest.credentials.loginName;
    reqRRP.reqLoginPassword = _quoteRequest.credentials.password;
    reqRRP.reqAccountId = _quoteRequest.credentials.accountId;
    reqRRP.reqRoutingCustomerCode = _quoteRequest.storeLocationCode;
    reqRRP.reqLoginToken = _quoteRequest.credentials.token;
    
    reqRRP.reqOriginZip = self.originZip.text;
    reqRRP.reqDestZip = self.destinationZip.text; // mutableCopy;
    
    //NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    //[df1 setDateFormat:@"MM/dd/yyyy"];
    //reqRRP.reqPickupDate = [df1 dateFromString: self.cellPickupDate.detailTextLabel.text];
    reqRRP.reqPickupDate = _quoteRequest.pickupDateTime;
    
    //NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
    //[df2 setDateFormat:@"MM/dd/yyyy"];
    //reqRRP.reqDropDate = [df2 dateFromString: self.cellDeliveryDate.detailTextLabel.text];
    
    int daysToAdd = 3;
    NSDate *newDate1 = [_quoteRequest.pickupDateTime dateByAddingTimeInterval:60*60*24*daysToAdd];
    reqRRP.reqDropDate = newDate1;
    
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
            f.length = fqr.length;
            f.width = fqr.width;
            f.height = fqr.height;            
            [reqRRP.reqFreight addObject: f];
        }
    }

    /*
    // add freight item
    RSPFreight* f = [[RSPFreight alloc] init];
    f.freightClass = [NSDecimalNumber decimalNumberWithString: self.freightClass.text];
    f.weight = [NSDecimalNumber decimalNumberWithString: self.weight.text];
    f.units =  [self.numHandlingUnits.text intValue];
    f.volume = [NSDecimalNumber decimalNumberWithString: @"90"];
    f.length = [NSDecimalNumber decimalNumberWithString: @"48"];
    f.width = [NSDecimalNumber decimalNumberWithString: @"40"];
    f.height = [NSDecimalNumber decimalNumberWithString: @"36"];
    [reqRRP.reqFreight addObject: f ];*/
    
    /*
    // add pallet position
    reqRRP.reqPalletCount = f.units;
    RSPPalletPositions* pp = [[RSPPalletPositions alloc] init];
    pp.length = 10;
    pp.height = 10;
    pp.width = 10;
    pp.weight = [f.weight doubleValue];
    pp.positionCount = f.units;
    [reqRRP.reqPalletPositions addObject: pp];*/
    
    reqRRP.reqViewSpecificCostContracts = true;
    reqRRP.reqViewGeneralCostContracts = true;
    reqRRP.reqViewGeneralBillingContracts = true;
    reqRRP.reqViewSpecificBillingContracts = true;
    reqRRP.reqViewWebCostContracts = true;
    reqRRP.reqViewWebBillingContracts = true;
    reqRRP.reqViewRatingCost = 1;
    
    /*
    QuoteRequest* req = [[QuoteRequest alloc] init];
    
    // credentials
    req.credentials = [[Credentials alloc] init];
    req.credentials.loginName = @"testbot";
    req.credentials.password = @"supersecret468";
    req.credentials.accountId =  @"32700120";
    req.credentials.token = @"268E46CD13B3A0B7CCC6D02CEF8DC92215C4F459";
    
    req.originPostalCode = @"50801";
    req.destinationPostalCode = @"66048";
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    req.pickupDateTime = [df1 dateFromString: @"2012-03-28 13:01"];
    
    FreightItem* f1 = [[FreightItem alloc] init];
    f1.weight = [NSDecimalNumber decimalNumberWithString: @"2000.0"];
    f1.weightUOM = @"LB";
    f1.freightClass = [NSDecimalNumber decimalNumberWithString: @"50"];
    f1.NMFC = @"8229";
    f1.handlingUnits = 3;
    f1.handlingUnitType = 1;
    f1.length = [NSDecimalNumber decimalNumberWithString: @"48"];
    f1.width = [NSDecimalNumber decimalNumberWithString: @"40"];
    f1.height = [NSDecimalNumber decimalNumberWithString:@"36"];
    f1.dimUOM = @"IN";
    [req addFreightItem:f1];
        */
    // now submit the request
    //[reqRRP submitRequest];
    
    _progress_ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _progress_ind.center = self.view.center; //CGPointMake (self.view.bounds.size.width * 0.5F, self.view.bounds.size.height * 0.5F);
    //_progress_ind.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    [_progress_ind startAnimating];
    [self.view addSubview:_progress_ind];

	[service RateShipment:self action:@selector(RateShipmentHandler:) rrp: reqRRP];
    
    //if (req != nil)
    //    [req directRequest];
}

// Handle the response from RateShipment.

- (void) RateShipmentHandler: (id) value {

    [_progress_ind stopAnimating];
    [_progress_ind removeFromSuperview];
    _progress_ind = nil;
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
        [self HandleError:value];
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
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
        
        //[view setRateResponseList:qr.rateResponses];
        [self performSegueWithIdentifier:@"quoteResultsSegue" sender:self];
    }
}

-(void) HandleError:(NSError*) error{

    NSString *errorString = [error localizedDescription];
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%d)", error.code];
    UIAlertView *errorView =
    [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [errorView show];
}

@end
