/*
	RSPPricingTransactionCharge.h
	The implementation of properties and methods for the RSPPricingTransactionCharge object.
	Generated by SudzC.com
*/
#import "RSPPricingTransactionCharge.h"

#import "RSPEffectivePricing.h"
@implementation RSPPricingTransactionCharge
	@synthesize pricing_transaction_pk = _pricing_transaction_pk;
	@synthesize cust_id = _cust_id;
	@synthesize mode = _mode;
	@synthesize charge_percent = _charge_percent;
	@synthesize charge_dollar = _charge_dollar;
	@synthesize min_percent = _min_percent;
	@synthesize min_dollar = _min_dollar;
	@synthesize max_percent = _max_percent;
	@synthesize max_dollar = _max_dollar;
	@synthesize active = _active;
	@synthesize charge_percent_applies = _charge_percent_applies;
	@synthesize min_percent_applies = _min_percent_applies;
	@synthesize max_percent_applies = _max_percent_applies;
	@synthesize min_limit_enabled = _min_limit_enabled;
	@synthesize max_limit_enabled = _max_limit_enabled;
	@synthesize org_id = _org_id;
	@synthesize effectivePricing = _effectivePricing;

	- (id) init
	{
		if(self = [super init])
		{
			self.mode = nil;
			self.charge_percent = nil;
			self.charge_dollar = nil;
			self.min_percent = nil;
			self.min_dollar = nil;
			self.max_percent = nil;
			self.max_dollar = nil;
			self.effectivePricing = nil; // [[RSPEffectivePricing alloc] init];

		}
		return self;
	}

	+ (RSPPricingTransactionCharge*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return [[self alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.pricing_transaction_pk = [[Soap getNodeValue: node withName: @"pricing_transaction_pk"] intValue];
			self.cust_id = [[Soap getNodeValue: node withName: @"cust_id"] intValue];
			self.mode = [Soap getNodeValue: node withName: @"mode"];
			self.charge_percent = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"charge_percent"]];
			self.charge_dollar = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"charge_dollar"]];
			self.min_percent = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"min_percent"]];
			self.min_dollar = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"min_dollar"]];
			self.max_percent = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"max_percent"]];
			self.max_dollar = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"max_dollar"]];
			self.active = [[Soap getNodeValue: node withName: @"active"] boolValue];
			self.charge_percent_applies = [[Soap getNodeValue: node withName: @"charge_percent_applies"] boolValue];
			self.min_percent_applies = [[Soap getNodeValue: node withName: @"min_percent_applies"] boolValue];
			self.max_percent_applies = [[Soap getNodeValue: node withName: @"max_percent_applies"] boolValue];
			self.min_limit_enabled = [[Soap getNodeValue: node withName: @"min_limit_enabled"] boolValue];
			self.max_limit_enabled = [[Soap getNodeValue: node withName: @"max_limit_enabled"] boolValue];
			self.org_id = [[Soap getNodeValue: node withName: @"org_id"] intValue];
			self.effectivePricing = [[RSPEffectivePricing createWithNode: [Soap getNode: node withName: @"effectivePricing"]] object];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"PricingTransactionCharge"];
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
		[s appendFormat: @"<pricing_transaction_pk>%@</pricing_transaction_pk>", [NSString stringWithFormat: @"%i", self.pricing_transaction_pk]];
		[s appendFormat: @"<cust_id>%@</cust_id>", [NSString stringWithFormat: @"%i", self.cust_id]];
		if (self.mode != nil) [s appendFormat: @"<mode>%@</mode>", [[self.mode stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.charge_percent != nil) [s appendFormat: @"<charge_percent>%@</charge_percent>", [NSString stringWithFormat: @"%@", self.charge_percent]];
		if (self.charge_dollar != nil) [s appendFormat: @"<charge_dollar>%@</charge_dollar>", [NSString stringWithFormat: @"%@", self.charge_dollar]];
		if (self.min_percent != nil) [s appendFormat: @"<min_percent>%@</min_percent>", [NSString stringWithFormat: @"%@", self.min_percent]];
		if (self.min_dollar != nil) [s appendFormat: @"<min_dollar>%@</min_dollar>", [NSString stringWithFormat: @"%@", self.min_dollar]];
		if (self.max_percent != nil) [s appendFormat: @"<max_percent>%@</max_percent>", [NSString stringWithFormat: @"%@", self.max_percent]];
		if (self.max_dollar != nil) [s appendFormat: @"<max_dollar>%@</max_dollar>", [NSString stringWithFormat: @"%@", self.max_dollar]];
		[s appendFormat: @"<active>%@</active>", (self.active)?@"true":@"false"];
		[s appendFormat: @"<charge_percent_applies>%@</charge_percent_applies>", (self.charge_percent_applies)?@"true":@"false"];
		[s appendFormat: @"<min_percent_applies>%@</min_percent_applies>", (self.min_percent_applies)?@"true":@"false"];
		[s appendFormat: @"<max_percent_applies>%@</max_percent_applies>", (self.max_percent_applies)?@"true":@"false"];
		[s appendFormat: @"<min_limit_enabled>%@</min_limit_enabled>", (self.min_limit_enabled)?@"true":@"false"];
		[s appendFormat: @"<max_limit_enabled>%@</max_limit_enabled>", (self.max_limit_enabled)?@"true":@"false"];
		[s appendFormat: @"<org_id>%@</org_id>", [NSString stringWithFormat: @"%i", self.org_id]];
		if (self.effectivePricing != nil) [s appendString: [self.effectivePricing serialize: @"effectivePricing"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[RSPPricingTransactionCharge class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end
