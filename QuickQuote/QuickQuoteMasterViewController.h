//
//  QuickQuoteMasterViewController.h
//  QuickQuote
//
//  Created by Steven Tuckness on 1/24/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "DatePopoverViewController.h"

/******  Swapable Detail View Code ******/
@protocol SubstitutableDetailViewController <NSObject>

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)startActivityIndicator;
- (void)stopActivityIndicator;

@end

@class QuoteReturn, QuoteRequest, PersistedContext, QuickQuoteDetailViewController;

@interface QuickQuoteMasterViewController : UITableViewController
        <NSFetchedResultsControllerDelegate, UISplitViewControllerDelegate,
        DatePopoverViewControllerDelegate, UIPopoverControllerDelegate,
        UITextFieldDelegate>
{

    /******  Swapable Detail View Code ******/
    UISplitViewController *splitViewController;
    UIPopoverController *popoverController;
    UIBarButtonItem *rootPopoverButtonItem;
    
    NSDate* _dateToSet;

    QuoteReturn* _quoteResults;
    QuoteRequest* _quoteRequest;
}

@property (weak, nonatomic) IBOutlet UITableViewCell *cellPickupDate;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellDeliveryDate;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellFreightSummary;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellPickupAccessorials;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellDeliveryAccessorials;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellShipmentAccessorials;
@property (weak, nonatomic) IBOutlet UITextField *originZip;
@property (weak, nonatomic) IBOutlet UITextField *destinationZip;
@property (weak, nonatomic) IBOutlet UITextField *storeLocationCode;
@property (weak, nonatomic) IBOutlet UIButton *btnRate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnUserSettings;
@property (nonatomic, retain) NSDate* dateToSet;
@property (nonatomic, retain) QuoteReturn* quoteReturn;
@property (nonatomic, retain) QuoteRequest* quoteRequest;

/******  Swapable Detail View Code ******/
@property (nonatomic, strong) UISplitViewController *splitViewController;
@property (nonatomic, strong) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) UIBarButtonItem *rootPopoverButtonItem;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) PersistedContext *persistedContext;
@property (nonatomic,strong) NSArray* quoteRequests;

@property (strong, nonatomic) UIPopoverController *datePopoverController;
@property (strong, nonatomic) QuickQuoteDetailViewController *quickQuoteDetailViewController;

- (IBAction)rateAction:(id)sender;

- (IBAction)resetAction:(id)sender;

- (void)setDateFromPopover:(NSDate *)aDate;

@end
