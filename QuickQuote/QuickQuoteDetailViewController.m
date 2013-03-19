//
//  QuickQuoteDetailViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 1/24/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "QuickQuoteDetailViewController.h"

@interface QuickQuoteDetailViewController ()
{
    UIActivityIndicatorView* _progress_ind;
    UIView* _subView;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;

@end

// temporary...
NSString *firstLogin = @"yes"; // just for now

@implementation QuickQuoteDetailViewController

@synthesize masterPopoverController = _masterPopoverController;
@synthesize loginViewController;
@synthesize managedObjectContext;

#pragma mark - Managing the detail item

- (void)configureView
{
    // Update the user interface for the detail item.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = self.view.bounds;
        
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

// there is also a reference to this in the rate call...to pop the right image back in place
// the screen keeps reverting back to storyboard settings...
-(void)configureBackgroundImage
{
    User *currentUser = [DataModel sharedInstance].currentUser;
    
    UIImage *image = [UIImage new];
    if ([currentUser.getCurrentEnterprise.enterpriseName
        isEqualToString:@"eShipping"] && ![currentUser.loginName isEqualToString:@"anonymous"])
    {
        image = [UIImage imageNamed: @"eShipping_Logo.png"];
    }
    else if ([currentUser.getCurrentEnterprise.enterpriseName
         isEqualToString:@"Exchange"] && ![currentUser.loginName isEqualToString:@"anonymous"])
    {
        image = [UIImage imageNamed: @"eShipping-Exchange.png"];
    }
    else
    {
        image = [UIImage imageNamed:@"ENGAGED_TECH_LOGO_LG.png"];
    }
        
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.alpha = .6;
    [self.imageView setImage:image];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([firstLogin isEqualToString:@"yes"])
    {
        firstLogin = @"no";
        [self showLoginScreen];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return YES;
    return NO;
}


- (IBAction)logOut:(id)sender {
    // empty models
    
    [self showLoginScreen];
}
-(void)showLoginScreen
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    QuickQuoteLoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    vc.delegate = self;
    [self presentViewController:vc animated:NO completion:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QuickQuoteLoginViewController *loginVc = segue.destinationViewController;
    loginVc.delegate = self;
}

- (void)quickQuoteLoginViewControllerDidFinish
{
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SubstitutableDetailViewController
#pragma mark Managing the popover

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    barButtonItem.title = NSLocalizedString(@"Shipment Information", @"Shipment Information");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

- (void)startActivityIndicator
{
    //if (_progress_ind == nil && _subView == nil)
    if (_progress_ind == nil)
    {
       _progress_ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _progress_ind.center = self.view.center;
        _progress_ind.alpha = 1.0;
       _subView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
       [_subView addSubview:_progress_ind];
       [self.imageView.superview addSubview:_subView];
       [self.imageView addSubview:_progress_ind];
        _subView.center = self.view.center;
        // center hack, because center to the view or image view isn't working well
        _progress_ind.frame = CGRectMake(300, 333, 100, 100);
    }

    [_progress_ind startAnimating];
    [self configureBackgroundImage]; // it keeps getting overwritten... put it back. (look into this more in depth)
}

-(void)stopActivityIndicator
{
    [_progress_ind stopAnimating];
}

@end
