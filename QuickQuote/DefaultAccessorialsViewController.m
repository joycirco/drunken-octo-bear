//
//  DefaultAccessorialsViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "DefaultAccessorialsViewController.h"
#import "Accessorial.h"
#import "PersistedAccessorial.h"
#import "QuoteRequest.h"
#import "AccessorialType.h"
#import "AccessorialCell.h"
#import "UserSettings.h"
#import "DataModel.h"
#import "UserSettingsViewController.h"

@interface DefaultAccessorialsViewController ()
{
    AccessorialType* accessorialType;
    UIBarButtonItem* _rootViewBarButtonItem;
}

- (void)configureView;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) AccessorialType *accessorialType;


@end

@implementation DefaultAccessorialsViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;

@synthesize accessorialTypeID = _accessorialTypeID;
@synthesize accessorialType = _accessorialType;
@synthesize userSettings = _userSettings;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.fetchedResultsController = nil;
    
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

    // make sure parent that pushed this view has a handle to navigate back to the root controller 
    if (_rootViewBarButtonItem != nil)
    {
        for (UIViewController* vc in self.navigationController.viewControllers)
        {
            if ([vc isKindOfClass:[UserSettingsViewController class]])
            {
                [(UserSettingsViewController*)vc showRootPopoverButtonItem:_rootViewBarButtonItem ];
            }
            break;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)configureView
{
    // get accessorial type from data store
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AccessorialType"
                                              inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set predicate to only accessorials for this _quoteRequest
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"accessorialTypeID=%@", _accessorialTypeID];
    [fetchRequest setPredicate:predicate];
    
    _accessorialType = [[_managedObjectContext executeFetchRequest:fetchRequest error:&error] objectAtIndex:0];
    
    // set view title based on accessorial type
    if (_accessorialType != nil)
    {
        self.title =  [NSString stringWithFormat:@"%@ Accessorials", _accessorialType.accessorialTypeName];
    }
    
    //int count = self.fetchedResultsController.fetchedObjects.count;
    
    //[self.tableView reloadData];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    BOOL bIsOn = NO;
    
    PersistedAccessorial *pAcc = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (_userSettings.defaultAccessorials != nil)
    {
        for (PersistedAccessorial* p in _userSettings.defaultAccessorials)
        {
            if ([p.accessorialCode isEqualToString:pAcc.accessorialCode])
            {
                bIsOn = YES;
                break;
            }
        }
    }
    
    ((AccessorialCell*)cell).label.text = pAcc.accessorialName;
    ((AccessorialCell*)cell).accessorial = pAcc;
    ((AccessorialCell*)cell).delegate = self;
    [((AccessorialCell*)cell).controlSwitch setOn: bIsOn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.fetchedResultsController.fetchedObjects.count;
    //return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AccessorialCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - SubstitutableDetailViewController
#pragma mark Managing the popover

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem
{
    // just hold on to the reference, and we will pass it back to our parent
    _rootViewBarButtonItem = barButtonItem;
}

- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem
{
    // nil it?
    _rootViewBarButtonItem = nil;
}

- (void)startActivityIndicator
{
}

-(void)stopActivityIndicator
{
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.detailPopoverController = nil;
}


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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PersistedAccessorial" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Set predicate to only accessorials for this _quoteRequest
    //NSPredicate* predicate = [NSPredicate predicateWithFormat:@"quoteRequest=%@", _quoteRequest];
    //[fetchRequest setPredicate:predicate];
    
    // Set predicate to only accessorials for this _accessorialTypeID
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"accessorialTypeID=%@", _accessorialTypeID];
    [fetchRequest setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"accessorialName" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
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

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
}


/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 
 }
 */

#pragma AccessorialCellDelegate
- (void)stateChanged:(BOOL)newState : (PersistedAccessorial*)accessorial
{
    if (accessorial != nil)
    {
        // if adding
        if (newState)
        {
            // add default
            if (_userSettings != nil)
                [_userSettings addDefaultAccessorialsObject:accessorial];
        }
        else
        {
            if (_userSettings != nil)
                [_userSettings removeDefaultAccessorialsObject:accessorial];
        }
        
//        NSError *error;
//        if (![_managedObjectContext save:&error])
//        {
//            NSLog(@"Could not save: %@", [error localizedDescription]);
//        }
    }
}

@end
