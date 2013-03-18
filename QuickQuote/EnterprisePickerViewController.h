//
//  EnterprisePickerViewController.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/6/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EnterprisePickerViewController;

@protocol EnterprisePickerViewControllerDelegate
@required
-(void)enterprisePickerViewControllerDidFinish:(EnterprisePickerViewController *)controller;
-(void)selectedAEnterprise:(NSString*)enterpriseName;
@end

@interface EnterprisePickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id <EnterprisePickerViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic)          NSArray *enterpriseArray;

// interface builder actions
-(IBAction)doneAction:(id)sender;

@end
