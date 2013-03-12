//
//  QuickQuoteCompanyPickerViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 2/3/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "CompanyPickerViewController.h"
#import "Company.h"
#import "Data.h"

@interface CompanyPickerViewController ()

@end

@implementation CompanyPickerViewController

@synthesize fakeCompaniesDataArray;
@synthesize delegate;

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
    // this should be fixed...
    
    // clear & reallocate memory
    self.fakeCompaniesDataArray = [[NSMutableArray alloc] init];
    
    // reload
    for (Company* c in [Data sharedInstance].user.companies)
    {
        [self.fakeCompaniesDataArray addObject:c.company_display];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    // make changes to viewpicker here...
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
    NSLog(@"%i @", [self.fakeCompaniesDataArray count]);
    return [self.fakeCompaniesDataArray count];
 
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.fakeCompaniesDataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSString *selectedCompany = [NSString stringWithFormat:@"%@", [fakeCompaniesDataArray objectAtIndex:row]];
    [Data sharedInstance].user.selectedCompany = selectedCompany;
    //NSLog(@"%@", [Data sharedInstance].selectedCompany);
    
    [self.delegate selectedACompany];
    // send a message to the parent view controller to go ahead and update the button with the text...
    
}

- (IBAction)doneAction:(id)sender
{
    [self.delegate companyPickerViewControllerDidFinish:self];
}

@end
