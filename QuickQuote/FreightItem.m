//
//  FreightItem.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "FreightItem.h"
#import "Accessorial.h"
#import "QuoteRequest.h"


@implementation FreightItem

@dynamic dimUOM;
@dynamic freightClass;
@dynamic freightDescription;
@dynamic handlingUnits;
@dynamic height;
@dynamic isStackable;
@dynamic length;
@dynamic nmfc;
@dynamic timeStamp;
@dynamic weight;
@dynamic weightUOM;
@dynamic width;
@dynamic handlingUnitTypeID;
@dynamic accessorials;
@dynamic quoteRequest;

- (id) init
{
    if(self = [super init])
    {
        self.handlingUnits = [[NSNumber alloc] initWithInt:0];
        self.handlingUnitTypeID = [[NSNumber alloc] initWithInt:1];
        self.freightClass = [NSDecimalNumber decimalNumberWithString: @"50.0"];
        
        self.weight = [NSDecimalNumber decimalNumberWithString: @"0"];
        self.weightUOM = @"lb";
        
        self.length = nil;
        self.width = nil;
        self.height = nil;
        self.dimUOM = @"in";
        
        self.nmfc = nil;
        self.freightDescription = nil;
        self.isStackable = FALSE;
        self.timeStamp = [NSDate date];
        //self.accessorials = nil;
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
    self.handlingUnits = [NSNumber numberWithInt: 1];
    self.handlingUnitTypeID = [NSNumber numberWithInt: 1];
    self.freightClass = [NSDecimalNumber decimalNumberWithString: @"50.0"];
    
    //self.weight = [NSDecimalNumber decimalNumberWithString: @"1000.0"];
    self.weight = [NSDecimalNumber decimalNumberWithString: @"0"];
    self.weightUOM = @"lb";
    
//    self.length = [NSDecimalNumber decimalNumberWithString: @"48.0"];;
//    self.width = [NSDecimalNumber decimalNumberWithString: @"40"];
//    self.height = [NSDecimalNumber decimalNumberWithString: @"36"];
    self.dimUOM = @"in";
    
    self.nmfc = @"";
    self.freightDescription = @"";
    self.isStackable = FALSE;
    self.timeStamp = [NSDate date];
    //self.accessorials = [[NSMutableArray alloc]init];
    
}

@end
