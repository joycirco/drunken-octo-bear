//
//  QuickQuoteCompanyPickerViewController.h
//  QuickQuote
//
//  Created by Steven Tuckness on 2/3/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enterprise.h"

@class CompanyPickerViewController;

@protocol CompanyPickerViewControllerDelegate
@required
-(void)companyPickerViewControllerDidFinish:(CompanyPickerViewController *)controller;
-(void)selectedACompany:(NSString*)selectedCompanyName;
@end

@interface CompanyPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id <CompanyPickerViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet  UIPickerView *picker;
@property (strong, nonatomic)           NSArray *companies;

// interface builder actions
-(IBAction)doneAction:(id)sender;

@end
