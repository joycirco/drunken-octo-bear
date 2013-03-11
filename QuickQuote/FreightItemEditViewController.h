//
//  FreightItemEditViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/2/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FreightItemEditViewController, QuoteRequest;

@protocol FreightItemEditViewControllerDelegate
- (void)freightEditViewControllerDidFinish:(FreightItemEditViewController *)controller;
@end

@interface FreightItemEditViewController : UIViewController
{
    int _freightIndex;
}

@property (weak, nonatomic) IBOutlet UITextField *tfWeight;
@property (weak, nonatomic) IBOutlet UITextField *tfUnits;
@property (weak, nonatomic) IBOutlet UITextView *tvDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnHandlingUnitType;
@property (weak, nonatomic) IBOutlet UIButton *btnClass;
@property (weak, nonatomic) IBOutlet UITextField *tfLength;
@property (weak, nonatomic) IBOutlet UITextField *tfWidth;
@property (weak, nonatomic) IBOutlet UITextField *tfHeight;

@property (weak, nonatomic) id <FreightItemEditViewControllerDelegate> delegate;
@property (strong, nonatomic) id freightItem;
@property (nonatomic,assign) int freightIndex;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) QuoteRequest* quoteRequest;
@property (nonatomic,assign) bool isAdding;

- (IBAction)cancelAction:(id)sender;

@end
