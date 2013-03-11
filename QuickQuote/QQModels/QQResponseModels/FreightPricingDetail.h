//
//  FreightPricingDetail.h
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import <Foundation/Foundation.h>

@class RSPFreightPricingDetails;

@interface FreightPricingDetail : NSObject
{
	NSString* _description;
	NSDecimalNumber* _length;
	NSDecimalNumber* _width;
	NSDecimalNumber* _height;
	NSDecimalNumber* _freightClass;
	NSDecimalNumber* _weight;
	NSDecimalNumber* _ratedWeight;
	NSDecimalNumber* _volume;
	int _units;
//	NSDecimalNumber* _cost;
	NSDecimalNumber* _charge;
//	NSDecimalNumber* _costRate;
	NSDecimalNumber* _chargeRate;
}

@property (retain, nonatomic) NSString* description;
@property (retain, nonatomic) NSDecimalNumber* length;
@property (retain, nonatomic) NSDecimalNumber* width;
@property (retain, nonatomic) NSDecimalNumber* height;
@property (retain, nonatomic) NSDecimalNumber* freightClass;
@property (retain, nonatomic) NSDecimalNumber* weight;
@property (retain, nonatomic) NSDecimalNumber* ratedWeight;
@property (retain, nonatomic) NSDecimalNumber* volume;
@property int units;
//@property (retain, nonatomic) NSDecimalNumber* cost;
@property (retain, nonatomic) NSDecimalNumber* charge;
//@property (retain, nonatomic) NSDecimalNumber* costRate;
@property (retain, nonatomic) NSDecimalNumber* chargeRate;

+ (FreightPricingDetail*) createWithRSPFreight: (RSPFreightPricingDetails*) freight;
- (id) initWithRSPFreight: (RSPFreightPricingDetails*) freight;

@end
