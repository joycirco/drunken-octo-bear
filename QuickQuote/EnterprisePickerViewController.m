//
//  EnterprisePickerViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/6/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "EnterprisePickerViewController.h"
#import "DataModel.h"
#import "Enterprise.h"

@interface EnterprisePickerViewController ()

@end

@implementation EnterprisePickerViewController

@synthesize delegate;
@synthesize enterprises;

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
	// Do any additional setup after loading the view.
    
    // all companies are eShipping except 26 fitness
    self.enterprises = [DataModel sharedInstance].currentUser.enterprises.allObjects;
    [self setPickerToSelectedEnterprise];
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
    return [self.enterprises count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Enterprise *enterprise = [self.enterprises objectAtIndex:row];
    return enterprise.enterpriseName;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Enterprise *selectedEnterprise = [enterprises objectAtIndex:row];
    [DataModel sharedInstance].currentUser.selectedEnterpriseId = selectedEnterprise.enterpriseId;
    [self.delegate selectedAEnterprise:selectedEnterprise.enterpriseName];
}

- (void)setPickerToSelectedEnterprise
{
    User *currentUser = [DataModel sharedInstance].currentUser;
    
    int i=0;
    
    for (Enterprise *e in enterprises)
    {
        if (currentUser.selectedEnterpriseId == e.enterpriseId)
        {
            [self.picker selectRow:i inComponent:0 animated:YES];
            break;
        }
        i++;
    }
}

-(IBAction)doneAction:(id)sender
{
    [self.delegate enterprisePickerViewControllerDidFinish:self];
}

@end
