//
//  RateResponse.h
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import <Foundation/Foundation.h>

@class RSPRateResponsePrivileged;

@interface RateResponse : NSObject
{
	NSMutableArray* _accessorialPricingDetails;
	NSMutableArray* _freightPricingDetails;
	NSMutableArray* _terminals;

	NSDecimalNumber* _accessorialTotalCost;
	NSDecimalNumber* _carrierTotalCost;
	NSDecimalNumber* _fuelTotalCost;
	NSDecimalNumber* _subTotalCost;
	NSDecimalNumber* _insuranceCost;
	NSDecimalNumber* _insuranceCharge;
	NSDecimalNumber* _accessorialTotalCharge;
	NSDecimalNumber* _carrierTotalCharge;
	NSDecimalNumber* _fuelTotalCharge;
	NSDecimalNumber* _subTotalCharge;
	NSDecimalNumber* _carrierGrossTotal;

	NSString* _originName;
	NSString* _originAddr1;
	NSString* _originAddr2;
	NSString* _originCity;
	NSString* _originState;
	NSString* _originZip;
	NSString* _originCountry;
	int _originWarehouseId;
	NSString* _destName;
	NSString* _destAddr1;
	NSString* _destAddr2;
	NSString* _destCity;
	NSString* _destState;
	NSString* _destZip;
	NSString* _destCountry;
	int _destWarehouseId;
	NSString* _carrierScac;
	NSString* _carrierName;
    
	NSString* _mode;
	NSString* _serviceMode;
	NSString* _parcelServiceCode;
	int _transitDays;
	int _calculatedMiles;
	NSString* _mileCalculationUsed;
	int _miler;
	NSString* _milerDescription;
	NSDate* _estimatedDelivery;
    UIImage* _carrierImage;
}

@property (retain, nonatomic) NSDecimalNumber* accessorialTotalCost;
@property (retain, nonatomic) NSDecimalNumber* carrierTotalCost;
@property (retain, nonatomic) NSDecimalNumber* fuelTotalCost;
@property (retain, nonatomic) NSDecimalNumber* subTotalCost;
@property (retain, nonatomic) NSDecimalNumber* insuranceCost;
@property (retain, nonatomic) NSDecimalNumber* accessorialTotalCharge;
@property (retain, nonatomic) NSDecimalNumber* carrierTotalCharge;
@property (retain, nonatomic) NSDecimalNumber* fuelTotalCharge;
@property (retain, nonatomic) NSDecimalNumber* subTotalCharge;
@property (retain, nonatomic) NSDecimalNumber* insuranceCharge;
@property (retain, nonatomic) NSDecimalNumber* carrierGrossTotal;
@property (retain, nonatomic) NSString* originName;
@property (retain, nonatomic) NSString* originAddr1;
@property (retain, nonatomic) NSString* originAddr2;
@property (retain, nonatomic) NSString* originCity;
@property (retain, nonatomic) NSString* originState;
@property (retain, nonatomic) NSString* originZip;
@property (retain, nonatomic) NSString* originCountry;
@property int originWarehouseId;
@property (retain, nonatomic) NSString* destName;
@property (retain, nonatomic) NSString* destAddr1;
@property (retain, nonatomic) NSString* destAddr2;
@property (retain, nonatomic) NSString* destCity;
@property (retain, nonatomic) NSString* destState;
@property (retain, nonatomic) NSString* destZip;
@property (retain, nonatomic) NSString* destCountry;
@property int destWarehouseId;
@property (retain, nonatomic) NSString* carrierScac;
@property (retain, nonatomic) NSString* carrierName;

@property (retain, nonatomic) NSMutableArray* terminals;
@property (retain, nonatomic) NSMutableArray* accessorialPricingDetails;
@property (retain, nonatomic) NSMutableArray* freightPricingDetails;

@property (retain, nonatomic) NSString* mode;
@property (retain, nonatomic) NSString* serviceMode;
@property (retain, nonatomic) NSString* parcelServiceCode;
@property int transitDays;
@property int distance;
@property (retain, nonatomic) NSString* mileCalculationUsed;
@property int miler;
@property (retain, nonatomic) NSString* milerDescription;
@property (retain, nonatomic) NSDate* estimatedDelivery;

@property (nonatomic,retain) UIImage* carrierImage;

+ (RateResponse*) createWithRSPRateResponse: (RSPRateResponsePrivileged*) rateResponse;
- (id) initWithRSPRateResponse: (RSPRateResponsePrivileged*) rateResponse;

@end
