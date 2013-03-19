//
//  DatePopoverViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 2/8/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "DatePopoverViewController.h"
#import "QuickQuoteMasterViewController.h"

@interface DatePopoverViewController ()

@end


@implementation DatePopoverViewController


@synthesize dateString = _dateString;
@synthesize intitialDate = _intitialDate;
@synthesize titleText = _titleText;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 250.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _datePicker.date = _intitialDate; // ((QuickQuoteMasterViewController*)self.delegate).dateToSet;
    //self.title = _titleText;
    self.navigationBar.title = _titleText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender
{
    [self.delegate datePopoverViewControllerDidFinish:self];
}

// set the date in the delegate
- (IBAction)setDate:(id)sender {
    [self.delegate setDateFromPopover:((UIDatePicker*)sender).date];
}
@end
