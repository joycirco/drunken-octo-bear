/*
	RSPArrayOfPricingAccessorial.h
	The implementation of properties and methods for the RSPArrayOfPricingAccessorial array.
	Generated by SudzC.com
*/
#import "RSPArrayOfPricingAccessorial.h"

#import "RSPPricingAccessorial.h"
@implementation RSPArrayOfPricingAccessorial

	+ (id) createWithNode: (CXMLNode*) node
	{
		return [[self alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				RSPPricingAccessorial* value = [[RSPPricingAccessorial createWithNode: child] object];
				if(value != nil) {
					[self addObject: value];
				}
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [item serialize: @"PricingAccessorial"]];
		}
		return s;
	}
@end
