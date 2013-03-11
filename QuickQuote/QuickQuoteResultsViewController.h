//
//  QuickQuoteResultsViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 2/12/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickQuoteMasterViewController.h"
#import "RateDetailViewController.h"

@class RateResponse;

@interface QuickQuoteResultsViewController : UITableViewController <SubstitutableDetailViewController, RateDetailViewControllerDelegate>
{
    RateResponse* _selectedRate;
}

@property (nonatomic, retain) RateResponse* selectedRate;
@property (weak, nonatomic) IBOutlet UIButton *popOverAnchorButton;
@property (strong, nonatomic) UIPopoverController *detailPopoverController;

- (void)setRateResponseList:(NSMutableArray *)rateList;
- (void)clearRateResponseList;
- (void)openCustomPopOverForIndexPath:(NSIndexPath *)indexPath;

@end

