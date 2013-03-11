//
//  ArrayOfRateResponse.m
//  QuickQuote
//
//  Created by Darin Raffety on 2/23/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "ArrayOfRateResponse.h"

#import "RSPRateResponsePrivileged.h"
#import "RateResponse.h"

@implementation ArrayOfRateResponse

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

+ (id) createWithRSPArrayOfRateResponse: (NSMutableArray*) arr
{
    return [[self alloc] initWithRSPArrayOfRateResponse: arr];
}

- (id) initWithRSPArrayOfRateResponse: (NSMutableArray*) arr
{
    for (RSPRateResponsePrivileged *rsp in arr)
    {
        RateResponse* value = [RateResponse createWithRSPRateResponse: rsp];
        if(value != nil) {
            [self addObject: value];
        }
    }
    return self;
}


@end
