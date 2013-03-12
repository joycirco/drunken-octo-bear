//
//  EnterprisePickerViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/6/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "EnterprisePickerViewController.h"
#import "Data.h"

@interface EnterprisePickerViewController ()

@end

@implementation EnterprisePickerViewController

@synthesize delegate;
@synthesize enterpriseArray;

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
    
    // all companies are eShipping except 26 fitness
    self.enterpriseArray = [Data sharedInstance].user.enterprises;
}

- (void)viewWillAppear:(BOOL)animated
{
    // make changes to view picker here...
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

// returns the number of rows in each component...
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.enterpriseArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.enterpriseArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectedEnterprise = [NSString stringWithFormat:@"%@", [enterpriseArray objectAtIndex:row]];
    [Data sharedInstance].user.selectedEnterprise = selectedEnterprise;
    //NSLog(@"%@", [Data sharedInstance].selectedCompany);
    
    [self.delegate selectedAEnterprise];
    // send a message to the parent view controller to go ahead and update the button with the text...
}

-(IBAction)doneAction:(id)sender
{
    [self.delegate enterprisePickerViewControllerDidFinish:self];
}

@end
