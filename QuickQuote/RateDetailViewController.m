//
//  RateDetailViewController.m
//  QuickQuote
//
//  Created by Darin Raffety on 2/20/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "RateDetailViewController.h"

#import "RateResponse.h"
#import "TerminalInfo.h"

#import "QuickQuoteResultsViewController.h"

@interface RateDetailViewController ()

@end

@implementation RateDetailViewController

@synthesize rate = _rate;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(360.0, 620.0);
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
    if (_rate != nil)
    {
        int count = 0;
        self.parametersUsed1.text=[NSString stringWithFormat:@"Origin: %@  Destination: %@", _rate.originZip,_rate.destZip];
        self.parametersUsed2.text=[NSString stringWithFormat:@"SCAC: %@  Mode: %@", _rate.carrierScac,_rate.mode];
        for(TerminalInfo* t in _rate.terminals)
        {
            if (count == 0)
            {
                self.contactTitleOrigin.text = @"Title:";
                self.contactOrigin.text = @"Contact:";
                self.tollFreeOrigin.text = @"Toll Free:";
                self.phoneFaxOrigin.text = @"Phone:  @Fax:";
                self.contactEmailOrigin.text = @"Email:";
                
                self.carrierNameOrigin.text = _rate.carrierName;
                self.addressOrigin.text = [NSString stringWithFormat:@"%@ %@", t.termStreet1, t.termStreet2];
                
                if (t.termState != nil && t.termState.length > 0)
                    self.cityStateZipOrigin.text = [NSString stringWithFormat:@"%@, %@ %@", t.termCity, t.termState, t.termZip];
                else
                    self.cityStateZipOrigin.text = [NSString stringWithFormat:@"%@ %@ %@", t.termCity, t.termState, t.termZip];
                
                NSMutableString* txt = [[NSMutableString alloc]init];
                if (t.termTel != nil && t.termTel.length>0)
                    [txt appendFormat:@"Phone: %@",t.termTel];
                if (t.termFax != nil && t.termFax.length>0)
                    [txt appendFormat:@"Fax: %@",t.termFax];
                self.phoneFaxOrigin.text = txt;
                
                if (t.termTollFree != nil && t.termTollFree.length>0)
                    self.tollFreeOrigin.text = [NSString stringWithFormat:@"Toll Free: %@",t.termTollFree];
                
                if (t.termEmail != nil && t.termEmail.length > 0)
                    self.contactEmailOrigin.text = [NSString stringWithFormat:@"Email: %@",t.termEmail];
                
                if (t.termContact != nil && t.termContact.length > 0)
                    self.contactOrigin.text = [NSString stringWithFormat:@"Contact: %@",t.termContact];
                
                NSString* str = @"";
                if (t.termContactTitle != nil && t.termContactTitle.length >0)
                {
                    str = t.termContactTitle;
                }
                self.contactTitleOrigin.text = [NSString stringWithFormat:@"Title: %@",str];
            }
            else
            {
                self.contactTitleDest.text = @"Title:";
                self.contactDest.text = @"Contact:";
                self.tollFreeDest.text = @"Toll Free:";
                self.phoneFaxDest.text = @"Phone:  @Fax:";
                self.contactEmailDest.text = @"Email:";
                
                //self.carrierNameDest.text = @""; //_rate.carrierName;
                self.addressDest.text = [NSString stringWithFormat:@"%@ %@", t.termStreet1, t.termStreet2];
                
                if (t.termState != nil && t.termState.length > 0)
                    self.cityStateZipDest.text = [NSString stringWithFormat:@"%@, %@ %@", t.termCity, t.termState, t.termZip];
                else
                    self.cityStateZipDest.text = [NSString stringWithFormat:@"%@ %@ %@", t.termCity, t.termState, t.termZip];
                
                NSMutableString* txt = [[NSMutableString alloc]init];
                if (t.termTel != nil && t.termTel.length>0)
                    [txt appendFormat:@"Phone: %@",t.termTel];
                if (t.termFax != nil && t.termFax.length>0)
                    [txt appendFormat:@"Fax: %@",t.termFax];
                self.phoneFaxDest.text = txt;

                if (t.termTollFree != nil && t.termTollFree.length>0)
                    self.tollFreeDest.text = [NSString stringWithFormat:@"Toll Free: %@",t.termTollFree];

                if (t.termEmail != nil && t.termEmail.length > 0)
                    self.contactEmailDest.text = [NSString stringWithFormat:@"Email: %@",t.termEmail];

                if (t.termContact != nil && t.termContact.length > 0)
                    self.contactDest.text = [NSString stringWithFormat:@"Contact: %@",t.termContact];
                
                NSString* str = @"";
                if (t.termContactTitle != nil && t.termContactTitle.length >0)
                {
                    str = t.termContactTitle;
                }
                self.contactTitleDest.text = [NSString stringWithFormat:@"Title: %@",str];
            }
            count++;
        }
    }
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}*/

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
- (IBAction)closeAction:(id)sender
{
    [self.delegate rateDetailPopoverViewControllerDidFinish:self];
}
@end
