//
//  AccessorialCell.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/5/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Accessorial;

@protocol AccessorialCellDelegate
- (void)stateChanged:(BOOL)newState : (Accessorial*)accessorial;
@end

@interface AccessorialCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *controlSwitch;
@property (weak, nonatomic) id <AccessorialCellDelegate> delegate;
- (IBAction)actionSwitchChanged:(id)sender;

@property (strong, nonatomic) Accessorial* accessorial;

@end
