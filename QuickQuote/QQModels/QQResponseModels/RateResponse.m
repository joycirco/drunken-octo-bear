//
//  RateResponse.m
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import "RateResponse.h"

#import "RSPRateResponsePrivileged.h"
#import "RSPArrayOfPricingAccessorial.h"
#import "RSPArrayOfFreightPricingDetails.h"
#import "RSPArrayOfRatedAccessorialPrivileged.h"
#import "RSPArrayOfTerminalInfo.h"
#import "AccessorialPricingDetail.h"
#import "FreightPricingDetail.h"
#import "TerminalInfo.h"


@implementation RateResponse

@synthesize accessorialPricingDetails = _accessorialPricingDetails;
@synthesize freightPricingDetails = _freightPricingDetails;
@synthesize accessorialTotalCost = _accessorialTotalCost;
@synthesize carrierTotalCost = _carrierTotalCost;
@synthesize fuelTotalCost = _fuelTotalCost;
@synthesize subTotalCost = _subTotalCost;
@synthesize insuranceCost = _insuranceCost;
@synthesize insuranceCharge = _insuranceCharge;
@synthesize accessorialTotalCharge = _accessorialTotalCharge;
@synthesize carrierTotalCharge = _carrierTotalCharge;
@synthesize fuelTotalCharge = _fuelTotalCharge;
@synthesize subTotalCharge = _subTotalCharge;
@synthesize carrierGrossTotal = _carrierGrossTotal;
@synthesize originName = _originName;
@synthesize originAddr1 = _originAddr1;
@synthesize originAddr2 = _originAddr2;
@synthesize originCity = _originCity;
@synthesize originState = _originState;
@synthesize originZip = _originZip;
@synthesize originCountry = _originCountry;
@synthesize originWarehouseId = _originWarehouseId;
@synthesize destName = _destName;
@synthesize destAddr1 = _destAddr1;
@synthesize destAddr2 = _destAddr2;
@synthesize destCity = _destCity;
@synthesize destState = _destState;
@synthesize destZip = _destZip;
@synthesize destCountry = _destCountry;
@synthesize destWarehouseId = _destWarehouseId;
@synthesize carrierScac = _carrierScac;
@synthesize carrierName = _carrierName;
@synthesize mode = _mode;
@synthesize serviceMode = _serviceMode;
@synthesize parcelServiceCode = _parcelServiceCode;
@synthesize transitDays = _transitDays;
@synthesize distance = _calculatedMiles;
@synthesize mileCalculationUsed = _mileCalculationUsed;
@synthesize miler = _miler;
@synthesize milerDescription = _milerDescription;
@synthesize estimatedDelivery = _etimatedDelivery;


- (id) init
{
    if(self = [super init])
    {
        self.accessorialPricingDetails = [[NSMutableArray alloc] init];
        self.freightPricingDetails = [[NSMutableArray alloc] init];
        self.accessorialTotalCost = nil;
        self.carrierTotalCost = nil;
        self.fuelTotalCost = nil;
        self.subTotalCost = nil;
        self.insuranceCost = nil;
        self.insuranceCharge = nil;
        self.accessorialTotalCharge = nil;
        self.carrierTotalCharge = nil;
        self.fuelTotalCharge = nil;
        self.subTotalCharge = nil;
        self.carrierGrossTotal = nil;
        self.originName = nil;
        self.originAddr1 = nil;
        self.originAddr2 = nil;
        self.originCity = nil;
        self.originState = nil;
        self.originZip = nil;
        self.originCountry = nil;
        self.destName = nil;
        self.destAddr1 = nil;
        self.destAddr2 = nil;
        self.destCity = nil;
        self.destState = nil;
        self.destZip = nil;
        self.destCountry = nil;
        self.carrierScac = nil;
        self.carrierName = nil;
        self.mode = nil;
        self.serviceMode = nil;
        self.parcelServiceCode = nil;
        self.mileCalculationUsed = nil;
        self.milerDescription = nil;
        self.estimatedDelivery = nil;
        self.terminals = [[NSMutableArray alloc] init];
    }
    return self;
}


+ (RateResponse*) createWithRSPRateResponse:(RSPRateResponsePrivileged *)rateResponse
{
    if(rateResponse == nil) { return nil; }
    return [[self alloc] initWithRSPRateResponse: rateResponse];
}

- (id) initWithRSPRateResponse:(RSPRateResponsePrivileged *) rateResponse
{
    if(self = [self init])
    {
        if (rateResponse.resFreightPricingDetails != nil)
        {
            [self createWithRSPArrayOfFreight:rateResponse.resFreightPricingDetails];
        }
    
        if (rateResponse.resRatedAccessorials != nil)
        {
            [self createWithRSPArrayOfAccessorial:rateResponse.resRatedAccessorials];
        }
    
        if (rateResponse.resTerminals != nil)
        {
            [self createWithRSPArrayOfTerminal: rateResponse.resTerminals];
        }
    
        self.accessorialTotalCost = rateResponse.resAccessorialTotalCost;
        self.carrierTotalCost = rateResponse.resCarrierTotalCost;
        self.fuelTotalCost = rateResponse.resFuelTotalCost;
        self.subTotalCost = rateResponse.resSubTotalCost;
        self.insuranceCost = rateResponse.resInsuranceCost;
        
        self.accessorialTotalCharge = rateResponse.resAccessorialTotalCharge;
        self.carrierTotalCharge = rateResponse.resCarrierTotalCharge;
        self.fuelTotalCharge = rateResponse.resFuelTotalCharge;
        self.subTotalCharge = rateResponse.resSubTotalCharge;
        self.insuranceCharge = rateResponse.resInsuranceCharge;
        
        self.carrierGrossTotal = rateResponse.resCarrierGrossTotal;
        
        self.originAddr1 = rateResponse.resOriginAddr1;
        self.originAddr2 = rateResponse.resOriginAddr2;
        self.originCity = rateResponse.resOriginCity;
        self.originCountry = rateResponse.resOriginCountry;
        self.originName = rateResponse.resOriginName;
        self.originState = rateResponse.resOriginState;
        self.originWarehouseId = rateResponse.resOriginWarehouseId;
        self.originZip = rateResponse.resOriginZip;

        self.destAddr1 = rateResponse.resDestAddr1;
        self.destAddr2 = rateResponse.resDestAddr2;
        self.destCity = rateResponse.resDestCity;
        self.destCountry = rateResponse.resDestCountry;
        self.destName = rateResponse.resDestName;
        self.destState = rateResponse.resDestState;
        self.destWarehouseId = rateResponse.resDestWarehouseId;
        self.destZip = rateResponse.resDestZip;

        self.carrierScac = rateResponse.resCarrierScac;
        self.carrierName = rateResponse.resCarrierName;
        self.mode = rateResponse.resMode;
        self.serviceMode = rateResponse.resService;
        self.parcelServiceCode = rateResponse.resParcelServiceCode;
        self.transitDays = rateResponse.resTransitDays;
        self.distance = rateResponse.resCalculatedMiles;
        self.mileCalculationUsed = rateResponse.resMileCalculationUsed;
        self.miler = rateResponse.resMiler;
        self.milerDescription = rateResponse.resMilerDescription;
        self.estimatedDelivery = rateResponse.resEstimatedDelivery;

    }
    return self;
}


- (void) createWithRSPArrayOfFreight: (NSMutableArray*) arr
{
    for (RSPFreightPricingDetails *rsp in arr)
    {
        FreightPricingDetail* value = [FreightPricingDetail createWithRSPFreight: rsp];
        if(value != nil)
        {
            [_freightPricingDetails addObject: value];
        }
    }
}

- (void) createWithRSPArrayOfAccessorial: (NSMutableArray*) arr
{
    for (RSPRatedAccessorialPrivileged *rsp in arr)
    {
        AccessorialPricingDetail* value = [AccessorialPricingDetail createWithRSPAccessorial: rsp];
        if(value != nil)
        {
            [_accessorialPricingDetails addObject: value];
        }
    }
}

- (void) createWithRSPArrayOfTerminal: (NSMutableArray*) arr
{
    for (RSPTerminalInfo *rsp in arr)
    {
        TerminalInfo* value = [TerminalInfo createWithRSPTerminal: rsp];
        if(value != nil)
        {
            [_terminals addObject: value];
        }
    }
}

@end
