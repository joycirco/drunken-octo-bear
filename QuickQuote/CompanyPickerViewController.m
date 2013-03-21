//
//  QuickQuoteCompanyPickerViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 2/3/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "CompanyPickerViewController.h"
#import "Company.h"
#import "DataModel.h"

@interface CompanyPickerViewController ()

@end

@implementation CompanyPickerViewController

@synthesize companies;
@synthesize delegate;
@synthesize picker;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 250.0);
    [super awakeFromNib];
}

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
    
    // clear & reallocate memory
    self.companies = [[NSMutableArray alloc] init];
    self.companies = [[DataModel sharedInstance].currentUser getCurrentEnterprise].companies.allObjects;
    [self setPickerToSelectedCompany];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // make changes to viewpicker here...
    //[self setPickerToSelectedCompany];
  
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
    //NSLog(@"%i @", [self.companiesDataArray count]);
    return [self.companies count];
 
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Company *company = [self.companies objectAtIndex:row];
    return company.companyName;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Company *selectedCompany = [companies objectAtIndex:row];
    [DataModel sharedInstance].currentUser.selectedCompanyId = selectedCompany.companyId;
    [self.delegate selectedACompany:selectedCompany.companyName];
}

- (void)setPickerToSelectedCompany
{
    User *currentUser = [DataModel sharedInstance].currentUser;
    
    int i=0;
        
    for (Company *c in companies)
    {
        if (currentUser.selectedCompanyId == c.companyId)
        {
            [self.picker selectRow:i inComponent:0 animated:YES];
            break;
        }
        i++;
    }
}

- (IBAction)doneAction:(id)sender
{
    [self.delegate companyPickerViewControllerDidFinish:self];
}

@end
