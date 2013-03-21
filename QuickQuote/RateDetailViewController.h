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

@property (retain, nonatomic) RateResponse* rate;
- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) id <RateDetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *carrierNameOrigin;
@property (weak, nonatomic) IBOutlet UILabel *addressOrigin;
@property (weak, nonatomic) IBOutlet UILabel *cityStateZipOrigin;
@property (weak, nonatomic) IBOutlet UILabel *phoneFaxOrigin;
@property (weak, nonatomic) IBOutlet UILabel *contactEmailOrigin;
@property (weak, nonatomic) IBOutlet UILabel *contactOrigin;
@property (weak, nonatomic) IBOutlet UILabel *contactTitleOrigin;
@property (weak, nonatomic) IBOutlet UILabel *tollFreeOrigin;

@property (weak, nonatomic) IBOutlet UILabel *contactTitleDest;
@property (weak, nonatomic) IBOutlet UILabel *carrierNameDest;
@property (weak, nonatomic) IBOutlet UILabel *addressDest;
@property (weak, nonatomic) IBOutlet UILabel *cityStateZipDest;
@property (weak, nonatomic) IBOutlet UILabel *phoneFaxDest;
@property (weak, nonatomic) IBOutlet UILabel *contactEmailDest;
@property (weak, nonatomic) IBOutlet UILabel *contactDest;
@property (weak, nonatomic) IBOutlet UILabel *tollFreeDest;

@property (weak, nonatomic) IBOutlet UILabel *parametersUsed1;
@property (weak, nonatomic) IBOutlet UILabel *parametersUsed2;



@end
