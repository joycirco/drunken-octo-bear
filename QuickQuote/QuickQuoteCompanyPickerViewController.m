//
//  QuickQuoteCompanyPickerViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 2/3/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "QuickQuoteCompanyPickerViewController.h"

@interface QuickQuoteCompanyPickerViewController ()

@end

@implementation QuickQuoteCompanyPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.fakeCompaniesDataArray = [[NSArray alloc] initWithObjects:@"Roberts Auto Plaza", @"Above Par Mortgage", @"Premier Mortgage Funding", @"Triumph", @"Weir", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [self.fakeCompaniesDataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    // don't do shit for now....but soon we should push this to the data model
    //  We need need to change elements in QuickQuoteLoginViewController...that company textbox...
    
    // we also need to close the popup when this happens...
}

@end
