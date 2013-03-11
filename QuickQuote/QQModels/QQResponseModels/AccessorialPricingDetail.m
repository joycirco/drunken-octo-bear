//
//  AccessorialPricingDetail.m
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import "AccessorialPricingDetail.h"
#import "RSPRatedAccessorialPrivileged.h"

@implementation AccessorialPricingDetail

@synthesize accCode = _accCode;
@synthesize accDescription = _accDescription;
//@synthesize accCostRateQualifier = _accCostRateQualifier;
@synthesize accChargeRateQualifier = _accChargeRateQualifier;
@synthesize accRate = _accRate;
@synthesize accIsMin = _accIsMin;
@synthesize accIsMax = _accIsMax;
@synthesize accCharge = _accCharge;
//@synthesize accCost = _accCost;


- (id) init
{
    if(self = [super init])
    {
        self.accCode = nil;
        self.accDescription = nil;
        self.accChargeRateQualifier = nil;
        self.accRate = nil;
        self.accCharge = nil;
    }
    return self;
}

+ (AccessorialPricingDetail*) createWithRSPAccessorial: (RSPRatedAccessorialPrivileged*) acc
{
    if(acc == nil) { return nil; }
    return [[self alloc] initWithRSPAccessorial: acc];
}

- (id) initWithRSPAccessorial: (RSPRatedAccessorialPrivileged*) acc
{
    if ([self init])
    {
        self.accCode = acc.accCode;
        self.accDescription = acc.accDescription;
    //  self.accCostRateQualifier = acc.accCostRateQualifier;
        self.accChargeRateQualifier = acc.accChargeRateQualifier;
        self.accRate = acc.accRate;
        self.accIsMin = acc.accIsMin;
        self.accIsMax = acc.accIsMax;
        self.accCharge = acc.accCharge;
    //  self.accCost = acc.accCost;
    }
    return self;
}

@end
