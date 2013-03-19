//
//  PickerPopoverViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "PickerPopoverViewController.h"
#import "PickerItem.h"

@interface PickerPopoverViewController ()

-(void) selectRowWithTitle:(NSString*)title;

@end

@implementation PickerPopoverViewController

@synthesize myPickerItems = _pickerItems;
@synthesize selectedRow = _selectedRow;
@synthesize titleForSelectedRow = _titleForSelectedRow;
@synthesize popoverTitleText = _popoverTitleText;

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
    if (_pickerItems == nil)
        _pickerItems = [[NSArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navBarItem.title = _popoverTitleText;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self selectRowWithTitle:_titleForSelectedRow];
}

-(void) selectRowWithTitle:(NSString*)title
{
    if (_pickerItems != nil && title != nil)
    {
        int nCount = 0;
        for(PickerItem* p in _pickerItems)
        {
            if ([p.itemTitle isEqualToString:title])
                break;
            nCount++;
        }
        
        [[self pickerView] selectRow:nCount inComponent:0 animated:YES];
    }
}

#pragma UIPickerViewDataSource Implementation
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_pickerItems != nil && component==0)
        return _pickerItems.count;
    else
        return 0;
}

#pragma UIPickerViewDelegate Implementation

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row  forComponent:(NSInteger)component
{
    if (component == 0)
    {
        PickerItem* p = [_pickerItems objectAtIndex:row];
        return p.itemTitle;
    }
    else
        return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row  inComponent:(NSInteger)component
{
    if (component == 0)
    {
        PickerItem* p = [_pickerItems objectAtIndex:row];
        [self.delegate setObjectFromPicker: p.itemObject];
    }
}

- (IBAction)doneAction:(id)sender
{
    [self.delegate pickerPopoverViewControllerDidFinish:self];
}

@end
