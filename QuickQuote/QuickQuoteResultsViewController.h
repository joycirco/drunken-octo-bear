//
//  QuickQuoteResultsViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 2/12/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import "QuickQuoteMasterViewController.h"
#import "RateDetailViewController.h"
#import "PickerPopoverViewController.h"

@class RateResponse, PickerHelper;

@interface QuickQuoteResultsViewController : UITableViewController <SubstitutableDetailViewController
                                                                    ,RateDetailViewControllerDelegate
                                                                    ,PickerPopoverViewControllerDelegate
                                                                    ,QLPreviewControllerDataSource
                                                                    ,QLPreviewControllerDelegate>
{
    RateResponse* _selectedRate;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) RateResponse* selectedRate;
@property (strong, nonatomic) UIPopoverController *detailPopoverController;
@property (weak, nonatomic) IBOutlet UIButton *popOverAnchorItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sortButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *pdfButton;

@property (nonatomic, retain) NSString* sortOption;

@property (retain, nonatomic) PickerHelper* pickerHelper;
@property (strong, nonatomic) UIPopoverController *pickerPopoverController;

- (IBAction)createPDFAction:(id)sender;

- (void)setRateResponseList:(NSMutableArray *)rateList;
- (void)clearRateResponseList;
- (void)openCustomPopOverForIndexPath:(NSIndexPath *)indexPath;

@end

