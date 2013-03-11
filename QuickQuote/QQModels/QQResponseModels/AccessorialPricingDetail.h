//
//  AccessorialPricingDetail.h
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import <Foundation/Foundation.h>

@class RSPRatedAccessorialPrivileged;

@interface AccessorialPricingDetail : NSObject
{
	NSString* _accCode;
	NSString* _accDescription;
	NSString* _accCostRateQualifier;
//	NSString* _accChargeRateQualifier;
	NSDecimalNumber* _accRate;
	BOOL _accIsMin;
	BOOL _accIsMax;
	NSDecimalNumber* _accCharge;
//	NSDecimalNumber* _accCost;
}

@property (retain, nonatomic) NSString* accCode;
@property (retain, nonatomic) NSString* accDescription;
//@property (retain, nonatomic) NSString* accCostRateQualifier;
@property (retain, nonatomic) NSString* accChargeRateQualifier;
@property (retain, nonatomic) NSDecimalNumber* accRate;
@property BOOL accIsMin;
@property BOOL accIsMax;
@property (retain, nonatomic) NSDecimalNumber* accCharge;
//@property (retain, nonatomic) NSDecimalNumber* accCost;

+ (AccessorialPricingDetail*) createWithRSPAccessorial: (RSPRatedAccessorialPrivileged*) acc;
- (id) initWithRSPAccessorial: (RSPRatedAccessorialPrivileged*) acc;


@end
