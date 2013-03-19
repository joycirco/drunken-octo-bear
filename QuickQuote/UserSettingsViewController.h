//
//  UserSettingsViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickQuoteMasterViewController.h"
#import "PickerPopoverViewController.h"

@class PickerHelper;

@interface UserSettingsViewController : UITableViewController <UITextFieldDelegate,
                                                                PickerPopoverViewControllerDelegate,
                                                                SubstitutableDetailViewController>

@property (weak, nonatomic) IBOutlet UITextField *defOriginPostalCode;
@property (weak, nonatomic) IBOutlet UITextField *defDestinationPostalCode;
@property (weak, nonatomic) IBOutlet UIButton *btnDefFreightClass;
@property (weak, nonatomic) IBOutlet UIButton *btnDefHandlingUnitType;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIPopoverController *pickerPopoverController;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnResetDefaults;
- (IBAction)actionResetDefaults:(id)sender;
@property (retain, nonatomic) PickerHelper* pickerHelper;

-(void)saveSettings;

@end
