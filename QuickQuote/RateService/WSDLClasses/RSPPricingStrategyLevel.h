/*
	RSPPricingStrategyLevel.h
	The interface definition of properties and methods for the RSPPricingStrategyLevel object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
#import "RSPPricingBase.h"
@class RSPPricingBase;


@interface RSPPricingStrategyLevel : RSPPricingBase
{
	int _pricing_strategy_pk;
	int _strategy_id;
	
}
		
	@property int pricing_strategy_pk;
	@property int strategy_id;

	+ (RSPPricingStrategyLevel*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end