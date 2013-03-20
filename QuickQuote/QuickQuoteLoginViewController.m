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

-(void)textFieldEdited
{
    [self preAuthenticateUser:FALSE];
}

-(void)loadUser:(User*)userToLoad
{
    [DataModel sharedInstance].currentUser = userToLoad;

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

// reorganize this mess
-(BOOL)authenticateUser:(BOOL*)signInClicked
{
    BOOL *userNameAndPasswordCorrect = FALSE;
    
    if ([self preAuthenticateUser:signInClicked])
    {
        userNameAndPasswordCorrect = TRUE;
        
        if ([self validateButtonSelections])
            return TRUE;
        // everything is good
    }
    
    if ([userTextField.text isEqualToString:[@"" stringByTrimmingCharactersInSet:
                                             [NSCharacterSet whitespaceCharacterSet]]] ||
        [passwordTextField.text isEqualToString:[@"" stringByTrimmingCharactersInSet:
                                                 [NSCharacterSet whitespaceCharacterSet]]])
    {
        // Skip sign in and rate anonymously for now...
        if (redLabel.hidden == FALSE &&
            [redLabel.text isEqualToString:@"Please enter all required information before continuing"])
        {
            [self loadAnonymousUser];
            return TRUE;
        }
        
        redLabel.text = @"Please enter all required information before continuing";
        redLabel.hidden = FALSE;
    }

    if (userNameAndPasswordCorrect == FALSE && redLabel.hidden)
    {
        redLabel.text = @"The username for the password you entered is incorrect";
        [redLabel setHidden:FALSE];
    }
      
    return FALSE;
}

-(void)loadAnonymousUser
{
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Could not save: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    User *user = [User alloc];
                  
    user = [fetchedObjects objectAtIndex:3];
    [self loadUser:user];
    NSLog(@"loaded anonymous user");
}

// validate that they have selected an enterprise and a company
// if they are not logging as anonymous
-(BOOL)validateButtonSelections
{
    if ([self validateButtonSelection:@"Select Enterprise" : enterpriseButton] &&
        [self validateButtonSelection:@"Select Company" : companyButton])
 
    {
        return TRUE;
    }
    return FALSE;
}

-(BOOL)validateButtonSelection : (NSString*)title : (UIButton*)button
{
    if (![button.titleLabel.text isEqualToString:title])
    {
        return TRUE;
    }
    
    if ([button.titleLabel.text isEqualToString:@"Select Company"])
    {
        redLabel.text = @"Please select a Company";
    }
    
    if ([button.titleLabel.text isEqualToString:@"Select Enterprise"])
    {
        redLabel.text = @"Please select a Enterprise";
    }
    redLabel.hidden = FALSE;
    return FALSE;
}

-(void)updateLoginScreen
{
    User *currentUser = [DataModel sharedInstance].currentUser;
    
    [self configurePreSelections:currentUser];
    [self configureButtonVisibility: [currentUser getCurrentEnterprise].companies.allObjects :companyButton :FALSE];
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
        [enterpriseButton setTitle:enterprise.enterpriseName forState:UIControlStateNormal];
        [self performSelector:@selector(configureButtonPositions) withObject:nil afterDelay:0.05];
    }
    
    Enterprise *enterprise = [[DataModel sharedInstance].currentUser getCurrentEnterprise];
    
    if (enterprise.companies.count == 1)
    {
        Company *company = enterprise.companies.allObjects[0];
        currentUser.selectedCompanyId = company.companyId;
        [companyButton setTitle:company.companyName forState:UIControlStateNormal];
        [self performSelector:@selector(configureButtonPositions) withObject:nil afterDelay:0.05];
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
    return nil;
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


@end
