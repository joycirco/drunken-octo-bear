//
//  FreightItemEditViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/2/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "FreightItemEditViewController.h"
#import "FreightItemsViewController.h"
#import "QuoteRequest.h"
#import "FreightItem.h"

@interface FreightItemEditViewController ()
{
    FreightItem* _freightItem;
    NSNumberFormatter *decimalFormatter;
    NSNumberFormatter *noStyleFormatter;
}

- (void)configureView;

@end

@implementation FreightItemEditViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize freightIndex = _freightIndex;
@synthesize quoteRequest = _quoteRequest;
@synthesize isAdding = _isAdding;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(480.0, 520.0);
    [super awakeFromNib];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    decimalFormatter = [[NSNumberFormatter alloc]init];
    [decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    noStyleFormatter = [[NSNumberFormatter alloc]init];
    [noStyleFormatter setNumberStyle:NSNumberFormatterNoStyle];
    
    [self configureView];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureView
{
    // Update the user interface for the freight item.
    if (_isAdding)
    {
        _freightItem = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"FreightItem"
                                    inManagedObjectContext:_managedObjectContext];
        
        [_freightItem setDefaults];
        //[_quoteRequest addFreightItemsObject:freightItem];
    }

    if (_freightItem.weight != nil)
        self.tfWeight.text = [noStyleFormatter stringFromNumber:_freightItem.weight];
    
    self.tfUnits.text = [noStyleFormatter stringFromNumber: _freightItem.handlingUnits];
    [self.btnClass setTitle:[decimalFormatter stringFromNumber:_freightItem.freightClass]forState:UIControlStateNormal];
    [self.btnHandlingUnitType setTitle:@"Pallets" forState:UIControlStateNormal];

    if (_freightItem.freightDescription != nil && _freightItem.freightDescription.length)
        self.tvDescription.text = _freightItem.freightDescription;
    
    self.tfLength.text = [decimalFormatter stringFromNumber:_freightItem.length];
    self.tfWidth.text = [decimalFormatter stringFromNumber:_freightItem.width];
    self.tfHeight.text = [decimalFormatter stringFromNumber:_freightItem.height];
    
}

// notify delegate we are done
- (IBAction)cancelAction:(id)sender
{
    [self.delegate freightEditViewControllerDidFinish:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.tfWeight) || (textField == self.tfUnits))
    {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"saveFreightEdit"])
    {
        // populate freight item from input
        _freightItem.weight = [NSDecimalNumber decimalNumberWithString:self.tfWeight.text];
        _freightItem.freightClass = [NSDecimalNumber decimalNumberWithString:self.btnClass.titleLabel.text];
        _freightItem.freightDescription = self.tvDescription.text;
        _freightItem.handlingUnits = [noStyleFormatter numberFromString: self.tfUnits.text];
        //_freightItem.handlingUnitType = [NSNumber numberWithInt: 1];  // to do convert from Handling Unit
        _freightItem.isStackable = FALSE;
        _freightItem.length = [NSDecimalNumber decimalNumberWithString:self.tfLength.text];
        _freightItem.width = [NSDecimalNumber decimalNumberWithString:self.tfWidth.text];
        _freightItem.height = [NSDecimalNumber decimalNumberWithString:self.tfHeight.text];
    }
}

@end
