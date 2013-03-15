//
//  FreightItemViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/9/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerPopoverViewController.h"
#import "QuickQuoteMasterViewController.h"

@class QuoteRequest, FreightItem;

@interface FreightItemViewController : UIViewController <UITextFieldDelegate, PickerPopoverViewControllerDelegate, SubstitutableDetailViewController>
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UITextField *units;
@property (weak, nonatomic) IBOutlet UITextField *length;
@property (weak, nonatomic) IBOutlet UITextField *width;
@property (weak, nonatomic) IBOutlet UITextField *height;
@property (weak, nonatomic) IBOutlet UIButton *btnHandlingUnitType;
@property (weak, nonatomic) IBOutlet UIButton *btnFreightClass;
@property (weak, nonatomic) IBOutlet UITextView *freightDescription;
@property (weak, nonatomic) IBOutlet UISwitch *stackable;
@property (weak, nonatomic) IBOutlet UITextField *nmfc;
- (IBAction)stackableChanged:(id)sender;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) QuoteRequest* quoteRequest;
@property (strong, nonatomic) FreightItem* freightItem;

@property (strong, nonatomic) UIPopoverController *detailPopoverController;
@property (strong, nonatomic) UIPopoverController *pickerPopoverController;

@property (nonatomic,assign) bool isAdding;
- (IBAction)deleteFreightAction:(id)sender;

@property (retain, nonatomic) NSMutableArray* freightClasses;
@property (retain, nonatomic) NSMutableArray* handlingUnitTypes;

- (IBAction)selectHandlingUnit:(id)sender;
- (IBAction)selectFreightClass:(id)sender;

@end
