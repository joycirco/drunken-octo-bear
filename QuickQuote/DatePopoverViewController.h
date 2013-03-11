//
//  DatePopoverViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 2/8/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePopoverViewController;

@protocol DatePopoverViewControllerDelegate
- (void)datePopoverViewControllerDidFinish:(DatePopoverViewController *)controller;
- (void)setDateFromPopover:(NSDate *)aDate;
@end

@interface DatePopoverViewController : UIViewController
{
    NSString* _dateString;
    NSDate* _date;

}
- (IBAction)setDate:(id)sender;

@property (weak, nonatomic) id <DatePopoverViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (retain, nonatomic) NSString* dateString;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate* intitialDate;

- (IBAction)doneAction:(id)sender;

@end
