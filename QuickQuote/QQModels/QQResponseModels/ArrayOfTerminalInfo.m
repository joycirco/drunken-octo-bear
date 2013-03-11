//
//  ArrayOfTerminalInfo.m
//  QuickQuote
//
//  Created by Darin Raffety on 2/23/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "ArrayOfTerminalInfo.h"

#import "TerminalInfo.h"
#import "RSPTerminalInfo.h"

@implementation ArrayOfTerminalInfo

- (id) init
{
    if(self = [super init])
    {
        
    }
    return self;
}

- (NSUInteger)count
{
    return self.count;
}

+ (id) createWithRSPArrayOfTerminal: (NSMutableArray*) arr
{
    return [[self alloc] initWithRSPArrayOfTerminal: arr];
}

- (id) initWithRSPArrayOfTerminal: (NSMutableArray*) arr
{
    for (RSPTerminalInfo *rsp in arr)
    {
        TerminalInfo* value = [TerminalInfo createWithRSPTerminal: rsp];
        if(value != nil) {
            [self addObject: value];
        }
    }
    return self;
}
@end
