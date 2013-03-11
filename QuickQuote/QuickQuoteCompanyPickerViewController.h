//
//  QuickQuoteCompanyPickerViewController.h
//  QuickQuote
//
//  Created by Steven Tuckness on 2/3/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickQuoteCompanyPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet  UIPickerView *picker;
@property (strong, nonatomic)           NSArray *fakeCompaniesDataArray;

@end
