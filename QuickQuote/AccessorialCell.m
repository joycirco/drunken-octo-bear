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


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
