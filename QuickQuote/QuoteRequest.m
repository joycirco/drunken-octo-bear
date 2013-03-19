//
//  QuoteRequest.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/19/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "QuoteRequest.h"
#import "Accessorial.h"
#import "Credentials.h"
#import "FreightItem.h"
#import "User.h"


@implementation QuoteRequest

@dynamic destinationPostalCode;
@dynamic originPostalCode;
@dynamic pickupDateTime;
@dynamic storeLocationCode;
@dynamic timeStamp;
@dynamic deliveryDateTime;
@dynamic accessorials;
@dynamic credentials;
@dynamic freightItems;
@dynamic user;


- (id) init
{
    if(self = [super init])
    {
        self.originPostalCode = nil;
        self.destinationPostalCode = nil;
        self.storeLocationCode = nil;
        self.credentials = nil;
        self.pickupDateTime = nil;
        self.freightItems = nil;
        self.accessorials = nil;
        self.storeLocationCode = nil;
        self.timeStamp = nil;
    }
    return self;
}

- (id) initWithDefaults
{
    if(self = [super init])
    {
        [self setDefaults];
    }
    return self;
}

- (void) setDefaults
{
    self.originPostalCode = @"50801";
    self.destinationPostalCode = @"66048";
    self.storeLocationCode =  @"13310001";
    self.pickupDateTime = [NSDate date];
    self.deliveryDateTime = [NSDate date];
    self.timeStamp = [NSDate date];
}


@end
