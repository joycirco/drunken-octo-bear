//
//  PickerItem.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "PickerItem.h"

@implementation PickerItem

@synthesize itemTitle = _itemTitle;
@synthesize itemObject = _itemObject;

- (id) initWithTitleObject:(NSString*)title :(id)object
{
    if(self = [super init])
    {
        self.itemTitle = title;
        self.itemObject = object;
    }
    return self;
}


@end
