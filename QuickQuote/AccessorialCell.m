//
//  AccessorialCell.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/5/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "AccessorialCell.h"

@implementation AccessorialCell
@synthesize label;
@synthesize controlSwitch;
@synthesize accessorial;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}


- (IBAction)actionSwitchChanged:(id)sender {
    
    UISwitch* theSwitch = (UISwitch*) sender;
    BOOL theSwitchIsOn = theSwitch.on;
    
    [self.delegate stateChanged:theSwitchIsOn :accessorial];
}
@end
