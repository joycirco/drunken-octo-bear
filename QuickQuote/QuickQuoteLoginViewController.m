//
//  QuickQuoteCompanyPopUpViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 2/3/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "QuickQuoteAppDelegate.h"
#import "QuickQuoteLoginViewController.h"
#import "QuickQuoteAppDelegate.h"
#import "User.h"
#import "Enterprise.h"
#import "Company.h"

@interface QuickQuoteLoginViewController ()

@end

@implementation QuickQuoteLoginViewController

@synthesize currentPopoverSegue;

@synthesize companyPickerViewController;
@synthesize enterprisePickerViewController;

@synthesize managedObjectContext;
@synthesize fetchedResultsController;

@synthesize redLabel;
@synthesize greenLabel;

@synthesize userTextField;
@synthesize passwordTextField;

@synthesize companyButton;
@synthesize enterpriseButton;
@synthesize signinButton;

@synthesize delegate;
//@synthesize dataModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // Get a reference to the Managed Object Context
    // note: This is NOT the best way to do this, just quick and dirty
    QuickQuoteAppDelegate *appDelegate =  (QuickQuoteAppDelegate *)[[UIApplication sharedApplication] delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    [DataModel sharedInstance].managedObjectContext = appDelegate.managedObjectContext;

    userTextField.delegate = self;
    passwordTextField.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:FALSE];
    
    // if I do it immediately it doesn't work...
    [self performSelector:@selector(configureButtonPositions) withObject:nil afterDelay:0.1f];
}

-(void)resetControls
{
    [companyButton setHidden:true];
    [companyButton setTitle:@"Select Company" forState:UIControlStateNormal];
    [enterpriseButton setHidden:true];
    [enterpriseButton setTitle:@"Select Enterprise" forState:UIControlStateNormal];
    [self configureButtonPositions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

-(void)selectedACompany:(NSString*)selectedCompanyName
{
    // this top line appears to be resetting the view to original button positions
    [self.companyButton setTitle:selectedCompanyName forState:UIControlStateNormal];
    // we need to dispatch event or figure out a proper way to do this
    [self performSelector:@selector(updateLoginScreen) withObject:nil afterDelay:0.05f];
}

-(void)selectedAEnterprise:(NSString*)selectedEnterpriseName
{
    [self.enterpriseButton setTitle:selectedEnterpriseName forState:UIControlStateNormal];
    [self.companyButton setTitle:@"Select Company" forState:UIControlStateNormal];
     [self performSelector:@selector(updateLoginScreen) withObject:nil afterDelay:0.05f];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.companyPickerViewController = nil;
    self.enterprisePickerViewController = nil;
}

- (void)companyPickerViewControllerDidFinish:(CompanyPickerViewController *)controller
{
    [[currentPopoverSegue popoverController] dismissPopoverAnimated:YES];
}

-(void)enterprisePickerViewControllerDidFinish:(EnterprisePickerViewController *)controller
{
    [[currentPopoverSegue popoverController] dismissPopoverAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)signInAction:(id)sender
{
    if ([self authenticateUser:TRUE])
    {
        [self.delegate quickQuoteLoginViewControllerDidFinish];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{

}

-(void)textFieldEdited
{
    [self preAuthenticateUser:FALSE];
}


-(void)loadUser:(User*)userToLoad
{
    [DataModel sharedInstance].currentUser = userToLoad;
    [greenLabel setHidden:true];
    [redLabel setHidden:true];
    [self updateLoginScreen];
    NSLog(@"Welcome Legit User");
}

-(BOOL)preAuthenticateUser:(BOOL*)signInClicked
{
    NSString *userTextFieldString = [userTextField.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]];
    NSString *userPassTextFieldString = [passwordTextField.text stringByTrimmingCharactersInSet:
                                        [NSCharacterSet whitespaceCharacterSet]];
    
    // get reference to app delegate
    QuickQuoteAppDelegate *appDelegate = (QuickQuoteAppDelegate *)[[UIApplication sharedApplication] delegate];
    [DataModel sharedInstance].managedObjectContext = appDelegate.managedObjectContext;
    managedObjectContext = appDelegate.managedObjectContext;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
       
    // look for a user based of the entered information
     for (User *user in fetchedObjects)
    {
        if (([userTextFieldString caseInsensitiveCompare:user.loginName] == NSOrderedSame ||
             [userTextFieldString caseInsensitiveCompare:user.email] == NSOrderedSame) &&
             [userPassTextFieldString isEqualToString:user.password])
        {
            [self loadUser:user];
            return true;
        }
    }
    
    if (!signInClicked)
        [self resetControls];
    return false;
}

-(BOOL)authenticateUser:(BOOL*)signInClicked
{
    if ([self preAuthenticateUser:signInClicked])
    {
        return true;
    }
    
    if ([userTextField.text isEqualToString:[@"" stringByTrimmingCharactersInSet:
                                             [NSCharacterSet whitespaceCharacterSet]]] ||
        [passwordTextField.text isEqualToString:[@"" stringByTrimmingCharactersInSet:
                                                 [NSCharacterSet whitespaceCharacterSet]]])
    {
        // Skip sign in and rate anonymously for now...
        if (redLabel.hidden == false)
        {
            // load default sign in information at some point or just have it loaded and don't override it
            return true;
        }
        
        redLabel.text = @"Please enter all required information before continuing";
        greenLabel.hidden = false; 
        redLabel.hidden = false;
    }
    else
    {
        redLabel.text = @"The username for password you entered is incorrect";
        [redLabel setHidden:false];
    }
    
    return false;
}

-(void)updateLoginScreen
{
    User *currentUser = [DataModel sharedInstance].currentUser;
    
    [self configurePreSelections:currentUser];
    [self configureButtonVisibility: [self getCurrentEnterprise].companies.allObjects :companyButton :FALSE];
    [self configureButtonVisibility:currentUser.enterprises.allObjects :enterpriseButton :TRUE];
    [self configureButtonPositions];
}
-(void)configureButtonVisibility: (NSArray*)arrayToCheck : (UIButton*)button : (BOOL*)isEnterprise
{
    if ([arrayToCheck count] > 1)
    {
        
        if (isEnterprise)
        {
            if ([enterpriseButton.titleLabel.text isEqualToString:@"Select Enterprise"])
            {
                companyButton.hidden = TRUE;
                [self showButtonAnimated:button];
            }
        }
        else
        {
             [self showButtonAnimated:button];
        }
    }
    else
    {
        button.hidden = TRUE;
    }
}

-(void)configurePreSelections:(User*)currentUser
{
    NSArray *enterprises = currentUser.enterprises.allObjects;
    
    if (enterprises.count == 1)
    {
        Enterprise *enterprise = enterprises[0];
        currentUser.selectedEnterpriseId = enterprise.enterpriseId;
    }
    
    Enterprise *enterprise = [self getCurrentEnterprise];
    
    if (enterprise.companies.count == 1)
    {
        Company *company = enterprise.companies.allObjects[0];
        currentUser.selectedCompanyId = company.companyId;
    }
}

-(void)showButtonAnimated: (UIButton*)button
{
    button.alpha = 0.0;
    button.hidden = false;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [button setAlpha:1.0];
    [UIView commitAnimations];
}

-(void)configureButtonPositions
{
    // drawing information
    CGFloat const buttonX = 43.0;
    CGFloat const buttonWidth = 365.0;
    CGFloat const topButtonY = 170.0;
    CGFloat const bottomButtonY = 214.0;
    CGFloat const signinYGap = 63;
  
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
        signinButton.frame = CGRectMake(buttonX, bottomButtonY + signinYGap,
                                        buttonWidth, signinButton.frame.size.height);
    }
    else if(companyButton.hidden && enterpriseButton.hidden == false)
    {
        enterpriseButton.frame = CGRectMake(buttonX, topButtonY,
            enterpriseButton.frame.size.width, enterpriseButton.frame.size.height);
        signinButton.frame = CGRectMake(buttonX, bottomButtonY + signinYGap,
                                        buttonWidth, signinButton.frame.size.height);
    }
    else if(companyButton.hidden && enterpriseButton.hidden)
    {
        signinButton.frame = CGRectMake(buttonX, topButtonY,
                                        buttonWidth, signinButton.frame.size.height);
    }
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    //[self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{

}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{

}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //[self.tableView endUpdates];
}

- (Enterprise*)getCurrentEnterprise
{
    User *currentUser = [DataModel sharedInstance].currentUser;
    
    for (Enterprise *enterprise in currentUser.enterprises)
    {
        if (enterprise.enterpriseId == currentUser.selectedEnterpriseId)
        {
            return enterprise;
        }
    }
    return nil; // didn't find it
}

@end
