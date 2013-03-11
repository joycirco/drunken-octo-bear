//
//  ArrayOfFreightPricingDetail.m
//  QuickQuote
//
//  Created by Darin Raffety on 2/23/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "ArrayOfFreightPricingDetail.h"

#import "RSPArrayOfFreightPricingDetails.h"
#import "ArrayOfFreightPricingDetail.h"
#import "FreightPricingDetail.h"

@implementation ArrayOfFreightPricingDetail

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

+ (id) createWithRSPArrayOfFreight: (NSMutableArray*) arr
{
    return [[self alloc] initWithRSPArrayOfFreight: arr];
}

- (id) initWithRSPArrayOfFreight: (NSMutableArray*) arr
{
    if ([self init])
    {
        for (RSPFreightPricingDetails *rsp in arr)
        {
            FreightPricingDetail* value = [FreightPricingDetail createWithRSPFreight: rsp];
            if(value != nil) {
                [self addObject: value];
            }
        }
    }
    return self;
}

@end
