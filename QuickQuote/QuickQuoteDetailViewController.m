//
//  QuickQuoteDetailViewController.m
//  QuickQuote
//
//  Created by Steven Tuckness on 1/24/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "QuickQuoteDetailViewController.h"
#import "QuickQuoteResultsViewController.h"

@interface QuickQuoteDetailViewController ()
{
    UIActivityIndicatorView* _progress_ind;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;

@end

// temporary...
NSString *firstLogin = @"yes"; // just for now

@implementation QuickQuoteDetailViewController

@synthesize cancelBtn = _cancelBtn;
@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize loginViewController;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
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
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (firstLogin == @"yes")
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


/*
// overrides the split/detail view and pulls up the login screen for us.
// Split Navigation views have to be the root, but that's okay...
// I turned animation off so there is no sneak peak at the inner
// portion of the application before the login screen is displayed...
- (void)viewDidAppear:(BOOL)animated
{
    if (firstLogin == @"yes")
    {
         firstLogin = @"no";
        [super viewDidAppear:animated];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        
        [self presentViewController:vc animated:NO completion:nil];
    }
    
}
*/

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
    if (_progress_ind == nil)
    {
        _progress_ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [self.view addSubview:_progress_ind];
        _progress_ind.center = self.view.center;
    }

    [_progress_ind startAnimating];
}

-(void)stopActivityIndicator
{
    if (_progress_ind != nil)
    {
        [_progress_ind stopAnimating];
        [_progress_ind removeFromSuperview];
        _progress_ind = nil;
    }
}

@end
