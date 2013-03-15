//
//  QuickQuoteCompanyPopUpViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 2/3/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "QuickQuoteLoginViewController.h"
#import "User.h"
#import "Data.h" // delete?

@interface QuickQuoteLoginViewController ()

@end

@implementation QuickQuoteLoginViewController

@synthesize currentPopoverSegue;

@synthesize companyPickerViewController;
@synthesize enterprisePickerViewController;

@synthesize redLabel;
@synthesize greenLabel;

@synthesize userTextField;
@synthesize passwordTextField;

@synthesize companyButton;
@synthesize enterpriseButton;
@synthesize signinButton;

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
	// Do any additional setup after loading the view.
    
    userTextField.delegate = self;
    passwordTextField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

-(void)resetControls
{
    [companyButton setHidden:true];
    [companyButton setTitle:@"Select Company" forState:UIControlStateNormal];
    [enterpriseButton setHidden:true];
    [enterpriseButton setTitle:@"Select Enterprise" forState:UIControlStateNormal];
    [self determineButtonPositions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// refactor this soon...like write some methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setDelegate:self];
    
    if ([[segue identifier] isEqualToString:@"companySegue"])
    {
        [self handleCompanyViewPickerSegue:segue];
    }
    else if([[segue identifier] isEqualToString:@"enterpriseSegue"])
    {
        [self handleEnterpriseViewPickerSegue:segue];
    }
    
    currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
    UIPopoverController *popoverController = [segue destinationViewController];
    [popoverController setDelegate:self];
} // end prepareForSegue

-(void)handleCompanyViewPickerSegue:(UIStoryboardSegue *)segue
{
    // stuff
}

-(void)handleEnterpriseViewPickerSegue:(UIStoryboardSegue *)segue
{
    // stuff
}

-(void)selectedACompany
{
    [self.companyButton setTitle:[Data sharedInstance].user.selectedCompany forState:UIControlStateNormal];
}

-(void)selectedAEnterprise
{
    [self.enterpriseButton setTitle:[Data sharedInstance].user.selectedEnterprise forState:UIControlStateNormal];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.companyPickerViewController = nil;
    self.enterprisePickerViewController = nil;
}

- (void)companyPickerViewControllerDidFinish:(CompanyPickerViewController *)controller
{
    // do stuff as we close it
    [[currentPopoverSegue popoverController] dismissPopoverAnimated:YES];
}

-(void)enterprisePickerViewControllerDidFinish:(EnterprisePickerViewController *)controller
{
    // do stuff as we close it...
    [[currentPopoverSegue popoverController] dismissPopoverAnimated:YES];
}

// Close the keyboard if someone presses enter from any textfield
// !Not working at the moment...fix this
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)signInAction:(id)sender
{
    if ([self authenticateUser])
    {
        [self.delegate quickQuoteLoginViewControllerDidFinish];
    }
}

// they entered a textfield
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

// they left a textfield by closing the keyboard...
-(void)textFieldDidEndEditing:(UITextField *)textField
{

}

-(void)textFieldEdited
{
    // check the user
    [self preAuthenticateUser];
}


-(void)loadUser:(User*)userToLoad
{
    [Data sharedInstance].user = userToLoad;
    [self updateLoginScreen:[Data sharedInstance].user];
    [greenLabel setHidden:true];
    [redLabel setHidden:true];
    NSLog(@"Welcome Legit User");
}

// see if we need to show the company/enterprise buttons
-(BOOL)preAuthenticateUser
{
    NSString *userTextFieldString = [userTextField.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]];
    NSString *userPassTextFieldString = [passwordTextField.text stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceCharacterSet]];
    
    // look for a user based of the entered information
    for (User* user in [Data sharedInstance].availableUsers)
    {
        if (([userTextFieldString isEqualToString:user.loginName] ||
             [userTextFieldString isEqualToString:user.email]) &&
            [userPassTextFieldString isEqualToString:user.password])
        {
            // we found our user
            [self loadUser:user];
            return true;
        }
    }
    [self resetControls];
    return false;
}

// might want to seperate this into more methods soon
// this pretty much verifies that the user is legit
-(BOOL)authenticateUser
{
    if ([self preAuthenticateUser])
    {
        return true;
    }
    
    if ([userTextField.text isEqualToString:[@"" stringByTrimmingCharactersInSet:
                                             [NSCharacterSet whitespaceCharacterSet]]] ||
        [passwordTextField.text isEqualToString:[@"" stringByTrimmingCharactersInSet:
                                                 [NSCharacterSet whitespaceCharacterSet]]])
    {
        redLabel.text = @"Please enter all required information before continuing";
        redLabel.hidden = false;
    }
    else
    {
        redLabel.text = @"The username for password you entered is incorrect";
        [redLabel setHidden:false];
    }
    
    return false;
}

-(void)updateLoginScreen:(User *)currentUser
{
    [self determineObjectVisibility:currentUser :currentUser.companies :companyButton];
    [self determineObjectVisibility:currentUser :currentUser.enterprises :enterpriseButton];
    [self determineButtonPositions];
}

// position the buttons on the screen accordingly...
-(void)determineButtonPositions
{
    // drawing information
    CGFloat const buttonX = 43.0;
    CGFloat const buttonWidth = 365.0;
    CGFloat const topButtonY = 170.0;
    CGFloat const bottomButtonY = 214.0;
    CGFloat const signinYGap = 63;
    
    // refactor...
    if (companyButton.hidden == false && enterpriseButton.hidden == false)
    {
        enterpriseButton.frame = CGRectMake(buttonX, topButtonY,
            enterpriseButton.frame.size.width, enterpriseButton.frame.size.height);
        companyButton.frame = CGRectMake(buttonX, bottomButtonY,
            companyButton.frame.size.width, companyButton.frame.size.height);
        signinButton.frame = CGRectMake(buttonX, bottomButtonY + signinYGap,
                                        buttonWidth, signinButton.frame.size.height);
    }
    else if (companyButton.hidden == false && enterpriseButton.hidden)
    {
        companyButton.frame = CGRectMake(buttonX, topButtonY,
            companyButton.frame.size.width, companyButton.frame.size.height);
        enterpriseButton.frame = CGRectMake(buttonX, bottomButtonY,
            enterpriseButton.frame.size.width, enterpriseButton.frame.size.height);
        signinButton.frame = CGRectMake(buttonX, topButtonY + signinYGap,
                                        buttonWidth, signinButton.frame.size.height);
    }
    else if(companyButton.hidden && enterpriseButton.hidden == false)
    {
        enterpriseButton.frame = CGRectMake(buttonX, topButtonY,
            enterpriseButton.frame.size.width, enterpriseButton.frame.size.height);
        companyButton.frame = CGRectMake(buttonX, bottomButtonY,
            companyButton.frame.size.width, companyButton.frame.size.height);
        signinButton.frame = CGRectMake(buttonX, topButtonY + signinYGap,
                                        buttonWidth, signinButton.frame.size.height);
    }
    else if(companyButton.hidden && enterpriseButton.hidden)
    {
        signinButton.frame = CGRectMake(buttonX, topButtonY,
                                        buttonWidth, signinButton.frame.size.height);
    }
    
} // determineButtonPositions


// we want to control the positions of elements rathering than animating the alpha property...
-(void)determineObjectVisibility:(User*)currentUser : (NSMutableArray*)objectToCheck : (UIButton*)button
{
    if (objectToCheck.count > 1)
    {
        button.alpha = 0.0;
        button.hidden = false;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [button setAlpha:1.0];
        [UIView commitAnimations];
    }
    else
    {
        button.hidden = true;
    }
}

@end
