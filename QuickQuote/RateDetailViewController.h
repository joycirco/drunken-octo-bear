//
//  RateDetailViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 2/20/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RateDetailViewController;
@class RateResponse;

@protocol RateDetailViewControllerDelegate
- (void)rateDetailPopoverViewControllerDidFinish:(RateDetailViewController *)controller;
@end

@interface RateDetailViewController : UITableViewController
{
    RateResponse* _rate;
}


@property (weak, nonatomic) IBOutlet UILabel *carrierName;
@property (retain, nonatomic) RateResponse* rate;
- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) id <RateDetailViewControllerDelegate> delegate;

@end
