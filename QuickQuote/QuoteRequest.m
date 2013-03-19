//
//  QuoteRequest.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/18/13.
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
    self.timeStamp = [NSDate date];
    //self.credentials = [[Credentials alloc]init];
    //self.credentials.loginName = @"testbot";
    //self.credentials.password = @"supersecret468";
    //self.credentials.accountId = @"32700120";
    //self.credentials.token = @"268E46CD13B3A0B7CCC6D02CEF8DC92215C4F459";
    //self.freightItems = nil;
    //self.accessorials = nil;
}



@end
