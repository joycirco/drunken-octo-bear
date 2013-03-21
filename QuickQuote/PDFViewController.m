//
//  PDFViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/21/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()

-(void) configureView;

@end

@implementation PDFViewController

@synthesize fileURL = _fileURL;

- (void)awakeFromNib
{
    _fileURL = [NSURL URLWithString:@"http://test1.eshipmanager.com/pdf/carrier_return_RS20316661T.pdf?timestamp=1363901022185"];
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureView
{    
    //creating the object of the QLPreviewController
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    
    //settnig the datasource property to self
    previewController.dataSource = self;
    
    //pusing the QLPreviewController to the navigation stack
    [[self navigationController] pushViewController:previewController animated:YES];
    //remove the right bar print button
    [previewController.navigationItem setRightBarButtonItem:nil];
}

#pragma mark -
#pragma mark QLPreviewControllerDataSource

// Returns the number of items that the preview controller should preview
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController
{
    return 1; //you can increase the this
}

// returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx
{
    return _fileURL;
}

@end
