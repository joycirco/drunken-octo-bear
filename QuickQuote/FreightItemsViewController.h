//
//  FreightItemsViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/2/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickQuoteMasterViewController.h"
#import "FreightItemEditViewController.h"

@class FreightItem;
@class QuoteRequest;

@interface FreightItemsViewController : UITableViewController
                                    <UITableViewDelegate, SubstitutableDetailViewController,
                                    FreightItemEditViewControllerDelegate, NSFetchedResultsControllerDelegate>
{

}

@property (nonatomic, retain) FreightItem* selectedFreight;

//@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) UIPopoverController *detailPopoverController;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAddFreight;

-(IBAction)cancelledFreightItemEdit:(UIStoryboardSegue *)segue;
-(IBAction)saveFreightItemEdit:(UIStoryboardSegue *)segue;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) QuoteRequest *quoteRequest;

@end
