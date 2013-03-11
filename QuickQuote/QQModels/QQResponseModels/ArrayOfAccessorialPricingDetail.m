//
//  ArrayOfAccessorialPricingDetail.m
//  QuickQuote
//
//  Created by Darin Raffety on 2/23/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "ArrayOfAccessorialPricingDetail.h"
#import "AccessorialPricingDetail.h"
#import "RSPRatedAccessorialPrivileged.h"

@implementation ArrayOfAccessorialPricingDetail

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

+ (id) createWithRSPArrayOfAccessorial: (NSMutableArray*) arr
{
    return [[self alloc] initWithRSPArrayOfAccessorial: arr];
}

- (id) initWithRSPArrayOfAccessorial: (NSMutableArray*) arr
{
    for (RSPRatedAccessorialPrivileged *rsp in arr)
    {
        AccessorialPricingDetail* value = [AccessorialPricingDetail createWithRSPAccessorial: rsp];
        if(value != nil) {
             [self addObject: value];
        }
    }
    return self;
}

@end
