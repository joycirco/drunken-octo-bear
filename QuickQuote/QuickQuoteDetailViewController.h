//
//  QuickQuoteDetailViewController.h
//  QuickQuote
//
//  Created by Steven Tuckness on 1/24/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickQuoteMasterViewController.h"
#import "QuickQuoteLoginViewController.h"

@interface QuickQuoteDetailViewController : UIViewController <PresentedLoginViewControllerDelegate,
    SubstitutableDetailViewController>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerMarker;
@property (strong, nonatomic) UIViewController *loginViewController;

@end
