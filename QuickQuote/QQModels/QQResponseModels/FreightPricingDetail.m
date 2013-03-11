//
//  FreightPricingDetail.m
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import "FreightPricingDetail.h"
#import "RSPFreightPricingDetails.h"

@implementation FreightPricingDetail

@synthesize description = _description;
@synthesize length = _length;
@synthesize width = _width;
@synthesize height = _height;
@synthesize freightClass = _freightClass;
@synthesize weight = _weight;
@synthesize ratedWeight = _ratedWeight;
@synthesize volume = _volume;
@synthesize units = _units;
//@synthesize cost = _cost;
@synthesize charge = _charge;
//@synthesize costRate = _costRate;
@synthesize chargeRate = _chargeRate;


- (id) init
{
    if(self = [super init])
    {
        self.description = nil;
        self.length = nil;
        self.width = nil;
        self.height = nil;
        self.freightClass = nil;
        self.weight = nil;
        self.ratedWeight = nil;
        self.volume = nil;
        self.charge = nil;
        self.chargeRate = nil;
        
    }
    return self;
}

+ (FreightPricingDetail*) createWithRSPFreight: (RSPFreightPricingDetails*) freight
{
    if(freight == nil) { return nil; }
    return [[self alloc] initWithRSPFreight: freight];
}

- (id) initWithRSPFreight: (RSPFreightPricingDetails*) freight
{
    if ([self init])
    {
        self.description = freight.description;
        self.length = freight.length;
        self.width = freight.width;
        self.height = freight.height;
        self.freightClass = freight.freightClass;
        self.weight = freight.weight;
        self.ratedWeight = freight.ratedWeight;
        self.volume = freight.volume;
        self.units = freight.units;
    //    self.cost = freight.cost;
        self.charge = freight.charge;
    //    self.costRate = freight.costRate;
        self.chargeRate = freight.chargeRate;
    }
    
    return self;
}

@end
