//
//  DefaultAccessorialsViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickQuoteMasterViewController.h"
#import "AccessorialCell.h"

@class UserSettings;

@interface DefaultAccessorialsViewController  : UITableViewController <SubstitutableDetailViewController,
                                                                       UITableViewDelegate,
                                                                       NSFetchedResultsControllerDelegate,
                                                                       AccessorialCellDelegate>
{
    
}

@property (strong, nonatomic) NSNumber* accessorialTypeID;  // 1=Pickup Accessorial, 2=Delivery Accessorials, 3=Shipment Accessorials

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UserSettings* userSettings;

@property (strong, nonatomic) UIPopoverController *detailPopoverController;

@end
