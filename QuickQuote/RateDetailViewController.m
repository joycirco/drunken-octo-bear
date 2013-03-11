//
//  RateDetailViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 2/20/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "RateDetailViewController.h"

#import "RateResponse.h"
#import "QuickQuoteResultsViewController.h"

@interface RateDetailViewController ()

@end

@implementation RateDetailViewController

@synthesize rate = _rate;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _rate = ((QuickQuoteResultsViewController*)self.delegate).selectedRate;
    
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
    self.carrierName.text = _rate.carrierName;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

// notify delegate we are done
- (IBAction)closeAction:(id)sender {
    [self.delegate rateDetailPopoverViewControllerDidFinish:self];
}
@end
