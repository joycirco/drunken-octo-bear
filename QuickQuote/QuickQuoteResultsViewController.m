//
//  QuickQuoteResultsViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 2/12/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "QuickQuoteResultsViewController.h"
#import "RSPRateResponsePrivileged.h"
#import "RateResponse.h"
#import "RateDetailViewController.h"
#import "RateResultCell.h"

@interface QuickQuoteResultsViewController ()
{
    UIPopoverController *masterPopoverController;
    NSMutableArray *_rates;
    
    NSNumberFormatter * currencyFormatter;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;

@end

//NSString *firstLoginTable = @"yes"; // just for now

@implementation QuickQuoteResultsViewController

@synthesize masterPopoverController = _masterPopoverController;
@synthesize selectedRate = _selectedRate;


- (void)configureView
{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _rates = [[NSMutableArray alloc] init];
    
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currencyFormatter = [[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
	// Do any additional setup after loading the view, typically from a nib.
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
    return YES;
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

#pragma mark Rate response Management

- (void) setRateResponseList:(NSMutableArray *)rateList
{
    if (_rates != rateList) {
        _rates = [rateList mutableCopy];
        [self.tableView reloadData];
    }
}

- (void) clearRateResponseList
{
    if (_rates != nil)
        [_rates removeAllObjects];
    [self.tableView reloadData];
}


#pragma mark - Rate Detail Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"rateDetailPopover"]) {
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.detailPopoverController = popoverController;
        popoverController.delegate = self;
    }
}

- (void)rateDetailPopoverViewControllerDidFinish:(RateDetailViewController *)controller
{
    [self.detailPopoverController dismissPopoverAnimated:YES];
    self.detailPopoverController = nil;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.detailPopoverController = nil;
}

- (void)insertNewObject:(id)sender
{
    if (!_rates) {
        _rates = [[NSMutableArray alloc] init];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (_rates != nil)
        return [_rates count];
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RateCell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    RateResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell != nil && _rates != nil && _rates.count > 0)
    {
        RateResponse *rate = _rates[indexPath.row];
        
        cell.carrierName.text = rate.carrierName;
        cell.transitDays.text = [NSString stringWithFormat:@"%d Days", rate.transitDays];
        cell.totalCarrierCharges.text = [currencyFormatter stringFromNumber: rate.carrierTotalCharge];
        cell.transitMode.text = rate.mode;
        cell.serviceMode.text = rate.serviceMode;
        cell.distance.text = [NSString stringWithFormat:@"%d Miles",rate.distance];
    }
    
    return cell;
}

- (void)openCustomPopOverForIndexPath:(NSIndexPath *)indexPath{
    //Get the cell from your table that presents the popover
    UITableViewCell *cell = (UITableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];

    if (_rates.count > 0)
    {
        _selectedRate = _rates[indexPath.row];
    }
    
    //Make the rect you want the popover to point at
    CGRect displayFrom = CGRectMake(cell.frame.origin.x + cell.frame.size.width, cell.center.y + self.tableView.frame.origin.y - self.tableView.contentOffset.y, 1, 1);

    //CGRect displayFrom = CGRectMake(cell.center.x, cell.center.y , 1, 1);
    
    //Now move your anchor button to this location (again, make sure you made your constraints allow this)
    self.popOverAnchorButton.frame = displayFrom;
    [self performSegueWithIdentifier:@"rateDetailPopover" sender:cell];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

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
    
    [self openCustomPopOverForIndexPath:indexPath];

    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
