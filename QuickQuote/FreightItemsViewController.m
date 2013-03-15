//
//  FreightItemsViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/2/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "FreightItemsViewController.h"
#import "FreightItem.h"
#import "QuoteRequest.h"
#import "FreightItemViewController.h"

@interface FreightItemsViewController ()
{
    UIPopoverController *masterPopoverController;

    NSNumberFormatter *decimalFormatter;
    NSNumberFormatter *noStyleFormatter;
    int _selectedIndex;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (FreightItem*)getSelectedFreight;

@end

@implementation FreightItemsViewController

@synthesize masterPopoverController = _masterPopoverController;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize quoteRequest = _quoteRequest;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        if (self != self.tableView.delegate)
            self.tableView.delegate = self;
    }
    return self;
}

#pragma mark - Managing the detail item
/*
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (masterPopoverController != nil) {
        [masterPopoverController dismissPopoverAnimated:YES];
    }
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    decimalFormatter = [[NSNumberFormatter alloc]init];
    [decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

    noStyleFormatter = [[NSNumberFormatter alloc]init];
    [noStyleFormatter setNumberStyle:NSNumberFormatterNoStyle];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
	//return YES;
	return NO;
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

#pragma mark - Rate Detail Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    if ([[segue identifier] isEqualToString:@"freightItemDetail"]) {
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.detailPopoverController = popoverController;
        popoverController.delegate = self;
    }*/

    if ([[segue identifier] isEqualToString:@"freightItemAdd"])
    {
        //FreightItemEditViewController* destinationView = [segue destinationViewController];
        FreightItemViewController* destinationView = [segue destinationViewController];
        destinationView.managedObjectContext = self.managedObjectContext;
        destinationView.quoteRequest = _quoteRequest;
        destinationView.isAdding = true;
        destinationView.freightItem = nil;
        [destinationView setEditing:true animated:true];
    }

    if ([[segue identifier] isEqualToString:@"freightItemEdit"])
    {
        FreightItemEditViewController* destinationView = [segue destinationViewController];
        destinationView.managedObjectContext = self.managedObjectContext;
        destinationView.quoteRequest = _quoteRequest;
        destinationView.freightItem = [self getSelectedFreight];
        destinationView.isAdding = false;
    }

    if ([[segue identifier] isEqualToString:@"freightItemView"])
    {
        FreightItemViewController* destinationView = [segue destinationViewController];
        destinationView.managedObjectContext = self.managedObjectContext;
        destinationView.quoteRequest = _quoteRequest;
        destinationView.freightItem = [self getSelectedFreight];
    }
}

- (void)freightEditViewControllerDidFinish:(FreightItemEditViewController *)controller
{
    [self.detailPopoverController dismissPopoverAnimated:YES];
    self.detailPopoverController = nil;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.detailPopoverController = nil;
}

-(IBAction)cancelledFreightItemEdit:(UIStoryboardSegue *)segue
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)saveFreightItemEdit:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"saveFreightEdit"])
    {
        FreightItemEditViewController* editController = [segue sourceViewController];
        // to do validate
        if (editController.freightItem)
        {
            if (editController.isAdding)
            {
                [_quoteRequest addFreightItemsObject:editController.freightItem];
            }
        }
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    //if (self.detailItem) {
    //    self.detailDescriptionLabel.text = [self.detailItem description];
    //}
}

- (FreightItem*)getSelectedFreight
{
    FreightItem *freight = nil;
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    
    if (indexPath != nil)
    {
        freight = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }

    return freight;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    FreightItem *freight = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (freight.freightDescription != nil && freight.freightDescription.length > 0)
    {
        cell.textLabel.text = freight.freightDescription;
    }
    else
    {
        NSMutableString* str = [[NSMutableString alloc]init];
        [str appendString:@"Freight Item "];
        NSInteger i = 1;
        [str appendString: [NSString stringWithFormat:@"%d", (indexPath.row + i)]];
        
        cell.textLabel.text = str;
    }
    
    NSMutableString* detail = [[NSMutableString alloc]init];
    
    [detail appendString:[decimalFormatter stringFromNumber:freight.weight]];
    [detail appendString:freight.weightUOM];
    [detail appendString:@", Class: "];
    [detail appendString:[decimalFormatter stringFromNumber:freight.freightClass]];
    [detail appendString:@", "];
    [detail appendString:[noStyleFormatter stringFromNumber:freight.handlingUnits]];
    [detail appendString:@" Pallets"];
    
    cell.detailTextLabel.text = detail;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FreightItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // configure the cell
    if (cell != nil && _quoteRequest.freightItems != nil && _quoteRequest.freightItems.count > 0)
    {
        [self configureCell:cell atIndexPath:indexPath];
    }
    
    return cell;
}


#pragma mark Freight Item Management

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    /*else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    } */
}

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
    /*if (_quoteRequest.freightItems.count > 0)
    {
        NSArray* f = [_quoteRequest.freightItems allObjects];
        _selectedFreight = [f objectAtIndex:indexPath.row];
        _selectedIndex = indexPath.row;
    }*/
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */

    //Get the cell from your table that presents the popover
    //UITableViewCell *cell = (UITableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    //if (_freightItems.count > 0)
    //{
    //    _selectedFreight = _freightItems[indexPath.row];
    //}
    
    //FreightItemEditViewController* detailViewController = [[FreightItemEditViewController alloc] init];
    //detailViewController.freightItem = _selectedFreight;

    //[self.navigationController pushViewController:detailViewController animated:YES];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FreightItem" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];

    // Set predicate to only pull freight items for this _quoteRequest
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"quoteRequest=%@", _quoteRequest];
    [fetchRequest setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"FreightItem"];
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
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
  /*  switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }*/
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;

    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;

        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
     
 }
*/

@end