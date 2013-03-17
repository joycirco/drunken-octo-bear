//
//  QuickQuoteCompanyPopUpViewController.h
//  QuickQuote
//
//  Created by Steven Tuckness on 2/3/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyPickerViewController.h"
#import "EnterprisePickerViewController.h"

@class QuickQuoteLoginViewController;

@protocol PresentedLoginViewControllerDelegate <NSObject>
@required
- (void)quickQuoteLoginViewControllerDidFinish;
@end

@interface QuickQuoteLoginViewController : UIViewController <UIPopoverControllerDelegate,
CompanyPickerViewControllerDelegate, EnterprisePickerViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <PresentedLoginViewControllerDelegate> delegate;

@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;

@property (strong, nonatomic) UIPopoverController *companyPickerViewController;
@property (strong, nonatomic) UIPopoverController *enterprisePickerViewController;

@property (strong, nonatomic) UIPopoverController *companyPickerViewController;
@property (strong, nonatomic) UIPopoverController *enterprisePickerViewController;

@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton *companyButton;
@property (strong, nonatomic) IBOutlet UIButton *enterpriseButton;
@property (weak, nonatomic) IBOutlet UIButton *signinButton;

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

// Interface Builder actions are used for custom click events
- (IBAction)signInAction:(id)sender;
- (IBAction)textFieldEdited;

@end

