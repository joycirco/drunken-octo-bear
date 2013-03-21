//
//  TableViewPopoverViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/20/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "TableViewPopoverViewController.h"

@interface TableViewPopoverViewController ()

@end

@implementation TableViewPopoverViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellPopover";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // configure the cell
    //if (cell != nil && _quoteRequest.freightItems != nil && _quoteRequest.freightItems.count > 0)
    //{
    //    [self configureCell:cell atIndexPath:indexPath];
    //}
    
    return cell;
}


@end
