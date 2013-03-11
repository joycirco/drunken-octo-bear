//
//  FreightItemQQ.m
//  ModelClasses
//
//  Created by Darin Raffety on 1/19/13.
//
//

#import "FreightItemQQ.h"
#import "AccessorialQQ.h"

@implementation FreightItemQQ

@synthesize handlingUnits = _handlingUnits;
@synthesize handlingUnitType = _handlingUnitType;
@synthesize freightClass = _freightClass;

@synthesize weight = _weight;
@synthesize weightUOM = _weightUOM;

@synthesize height = _height;
@synthesize length = _length;
@synthesize width = _width;
@synthesize dimUOM = _dimUOM;

@synthesize NMFC = _NMFC;

@synthesize freightDescription = _freightDescription;
@synthesize isStackable = _isStackable;

@synthesize accessorials = _accessorials;

- (id) init
{
    if(self = [super init])
    {
        self.handlingUnits = 0;
        self.handlingUnitType = 1;
        self.freightClass = [NSDecimalNumber decimalNumberWithString: @"50.0"];
        
        self.weight = [NSDecimalNumber decimalNumberWithString: @"0"];
        self.weightUOM = @"lb";

        self.length = nil;
        self.width = nil;
        self.height = nil;
        self.dimUOM = @"in";
        
        self.NMFC = nil;
        self.freightDescription = nil;
        self.isStackable = FALSE;
        self.accessorials = nil;
    }
    return self;
}

- (id) initWithDefaults
{
    if(self = [super init])
    {
        self.handlingUnits = 1;
        self.handlingUnitType = 1;
        self.freightClass = [NSDecimalNumber decimalNumberWithString: @"50.0"];
        
        self.weight = [NSDecimalNumber decimalNumberWithString: @"1000.0"];
        self.weightUOM = @"lb";
        
        self.length = [NSDecimalNumber decimalNumberWithString: @"48.0"];;
        self.width = [NSDecimalNumber decimalNumberWithString: @"40"];
        self.height = [NSDecimalNumber decimalNumberWithString: @"36"];
        self.dimUOM = @"in";
        
        self.NMFC = @"";
        self.freightDescription = @"";
        self.isStackable = FALSE;
        self.accessorials = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)addAccessorial:(Accessorial *)objAcc
{
    if (_accessorials == nil)
        _accessorials = [[NSMutableArray alloc] init];
    
    if (objAcc != nil)
        [_accessorials addObject:objAcc];
}

-(void)addAccessorials:(NSMutableArray *)objAccs
{
    if (_accessorials == nil)
        _accessorials = [[NSMutableArray alloc] init];
    
    [_accessorials addObjectsFromArray:objAccs];
    
}

-(void)removeAccessorial:(Accessorial *)objAcc
{
    if(_accessorials != nil && objAcc != nil)
      [_accessorials removeObject:objAcc];
}

-(void)clearAccessorials
{
    if(_accessorials != nil)
        [_accessorials removeAllObjects];
}

@end
