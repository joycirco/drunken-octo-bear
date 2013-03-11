//
//  PickerPopoverViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerPopoverViewController;

@protocol PickerPopoverViewControllerDelegate
- (void)pickerPopoverViewControllerDidFinish:(PickerPopoverViewController *)controller;
- (void)setObjectFromPicker:(id)object;
@end

@interface PickerPopoverViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id <PickerPopoverViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

- (IBAction)doneAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *myPickerItems;

@property (assign, nonatomic) int selectedRow;
@property (retain, nonatomic) NSString* titleForSelectedRow;

@end

