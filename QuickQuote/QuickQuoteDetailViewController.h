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

@property (weak, nonatomic) IBOutlet UILabel *centerMarker;
@property (strong, nonatomic) UIViewController *loginViewController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
