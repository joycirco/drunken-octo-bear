/*
	RSPPricingIncentive.h
	The implementation of properties and methods for the RSPPricingIncentive object.
	Generated by SudzC.com
*/
#import "RSPPricingIncentive.h"

#import "RSPEffectivePricing.h"
@implementation RSPPricingIncentive
	@synthesize pricing_incentive_pk = _pricing_incentive_pk;
	@synthesize cust_id = _cust_id;
	@synthesize contract_id = _contract_id;
	@synthesize inbound = _inbound;
	@synthesize outbound = _outbound;
	@synthesize third_party = _third_party;
	@synthesize mode = _mode;
	@synthesize active = _active;
	@synthesize incentive_percent = _incentive_percent;
	@synthesize incentive_dollar = _incentive_dollar;
	@synthesize min_percent = _min_percent;
	@synthesize min_dollar = _min_dollar;
	@synthesize max_percent = _max_percent;
	@synthesize max_dollar = _max_dollar;
	@synthesize incentive_percent_applies = _incentive_percent_applies;
	@synthesize min_percent_applies = _min_percent_applies;
	@synthesize max_percent_applies = _max_percent_applies;
	@synthesize min_limit_enabled = _min_limit_enabled;
	@synthesize max_limit_enabled = _max_limit_enabled;
	@synthesize org_id = _org_id;
	@synthesize scac = _scac;
	@synthesize effectivePricing = _effectivePricing;

	- (id) init
	{
		if(self = [super init])
		{
			self.mode = nil;
			self.incentive_percent = nil;
			self.incentive_dollar = nil;
			self.min_percent = nil;
			self.min_dollar = nil;
			self.max_percent = nil;
			self.max_dollar = nil;
			self.scac = nil;
			self.effectivePricing = nil; // [[RSPEffectivePricing alloc] init];

		}
		return self;
	}

	+ (RSPPricingIncentive*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return [[self alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.pricing_incentive_pk = [[Soap getNodeValue: node withName: @"pricing_incentive_pk"] intValue];
			self.cust_id = [[Soap getNodeValue: node withName: @"cust_id"] intValue];
			self.contract_id = [[Soap getNodeValue: node withName: @"contract_id"] intValue];
			self.inbound = [[Soap getNodeValue: node withName: @"inbound"] boolValue];
			self.outbound = [[Soap getNodeValue: node withName: @"outbound"] boolValue];
			self.third_party = [[Soap getNodeValue: node withName: @"third_party"] boolValue];
			self.mode = [Soap getNodeValue: node withName: @"mode"];
			self.active = [[Soap getNodeValue: node withName: @"active"] boolValue];
			self.incentive_percent = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"incentive_percent"]];
			self.incentive_dollar = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"incentive_dollar"]];
			self.min_percent = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"min_percent"]];
			self.min_dollar = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"min_dollar"]];
			self.max_percent = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"max_percent"]];
			self.max_dollar = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"max_dollar"]];
			self.incentive_percent_applies = [[Soap getNodeValue: node withName: @"incentive_percent_applies"] boolValue];
			self.min_percent_applies = [[Soap getNodeValue: node withName: @"min_percent_applies"] boolValue];
			self.max_percent_applies = [[Soap getNodeValue: node withName: @"max_percent_applies"] boolValue];
			self.min_limit_enabled = [[Soap getNodeValue: node withName: @"min_limit_enabled"] boolValue];
			self.max_limit_enabled = [[Soap getNodeValue: node withName: @"max_limit_enabled"] boolValue];
			self.org_id = [[Soap getNodeValue: node withName: @"org_id"] intValue];
			self.scac = [Soap getNodeValue: node withName: @"scac"];
			self.effectivePricing = [[RSPEffectivePricing createWithNode: [Soap getNode: node withName: @"effectivePricing"]] object];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"PricingIncentive"];
	}
  
	- (NSMutableString*) serialize: (NSString*) nodeName
	{
		NSMutableString* s = [NSMutableString string];
		[s appendFormat: @"<%@", nodeName];
		[s appendString: [self serializeAttributes]];
		[s appendString: @">"];
		[s appendString: [self serializeElements]];
		[s appendFormat: @"</%@>", nodeName];
		return s;
	}
	
	- (NSMutableString*) serializeElements
	{
		NSMutableString* s = [super serializeElements];
		[s appendFormat: @"<pricing_incentive_pk>%@</pricing_incentive_pk>", [NSString stringWithFormat: @"%i", self.pricing_incentive_pk]];
		[s appendFormat: @"<cust_id>%@</cust_id>", [NSString stringWithFormat: @"%i", self.cust_id]];
		[s appendFormat: @"<contract_id>%@</contract_id>", [NSString stringWithFormat: @"%i", self.contract_id]];
		[s appendFormat: @"<inbound>%@</inbound>", (self.inbound)?@"true":@"false"];
		[s appendFormat: @"<outbound>%@</outbound>", (self.outbound)?@"true":@"false"];
		[s appendFormat: @"<third_party>%@</third_party>", (self.third_party)?@"true":@"false"];
		if (self.mode != nil) [s appendFormat: @"<mode>%@</mode>", [[self.mode stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<active>%@</active>", (self.active)?@"true":@"false"];
		if (self.incentive_percent != nil) [s appendFormat: @"<incentive_percent>%@</incentive_percent>", [NSString stringWithFormat: @"%@", self.incentive_percent]];
		if (self.incentive_dollar != nil) [s appendFormat: @"<incentive_dollar>%@</incentive_dollar>", [NSString stringWithFormat: @"%@", self.incentive_dollar]];
		if (self.min_percent != nil) [s appendFormat: @"<min_percent>%@</min_percent>", [NSString stringWithFormat: @"%@", self.min_percent]];
		if (self.min_dollar != nil) [s appendFormat: @"<min_dollar>%@</min_dollar>", [NSString stringWithFormat: @"%@", self.min_dollar]];
		if (self.max_percent != nil) [s appendFormat: @"<max_percent>%@</max_percent>", [NSString stringWithFormat: @"%@", self.max_percent]];
		if (self.max_dollar != nil) [s appendFormat: @"<max_dollar>%@</max_dollar>", [NSString stringWithFormat: @"%@", self.max_dollar]];
		[s appendFormat: @"<incentive_percent_applies>%@</incentive_percent_applies>", (self.incentive_percent_applies)?@"true":@"false"];
		[s appendFormat: @"<min_percent_applies>%@</min_percent_applies>", (self.min_percent_applies)?@"true":@"false"];
		[s appendFormat: @"<max_percent_applies>%@</max_percent_applies>", (self.max_percent_applies)?@"true":@"false"];
		[s appendFormat: @"<min_limit_enabled>%@</min_limit_enabled>", (self.min_limit_enabled)?@"true":@"false"];
		[s appendFormat: @"<max_limit_enabled>%@</max_limit_enabled>", (self.max_limit_enabled)?@"true":@"false"];
		[s appendFormat: @"<org_id>%@</org_id>", [NSString stringWithFormat: @"%i", self.org_id]];
		if (self.scac != nil) [s appendFormat: @"<scac>%@</scac>", [[self.scac stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.effectivePricing != nil) [s appendString: [self.effectivePricing serialize: @"effectivePricing"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[RSPPricingIncentive class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end