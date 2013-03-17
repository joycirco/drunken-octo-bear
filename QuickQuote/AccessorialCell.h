//
//  AccessorialCell.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/5/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersistedAccessorial;

@protocol AccessorialCellDelegate
- (void)stateChanged:(BOOL)newState : (PersistedAccessorial*)accessorial;
@end

@interface AccessorialCell : UITableViewCell
@property (weak, nonatomic) id <AccessorialCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *controlSwitch;
- (IBAction)actionSwitchChanged:(id)sender;

@property (strong, nonatomic) PersistedAccessorial* accessorial;

@end
