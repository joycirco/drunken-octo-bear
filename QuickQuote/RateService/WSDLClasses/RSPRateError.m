/*
	RSPRateError.h
	The implementation of properties and methods for the RSPRateError object.
	Generated by SudzC.com
*/
#import "RSPRateError.h"

@implementation RSPRateError
	@synthesize errorId = _errorId;
	@synthesize errorMessage = _errorMessage;

	- (id) init
	{
		if(self = [super init])
		{
			self.errorMessage = nil;

		}
		return self;
	}

	+ (RSPRateError*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return [[self alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.errorId = [[Soap getNodeValue: node withName: @"errorId"] intValue];
			self.errorMessage = [Soap getNodeValue: node withName: @"errorMessage"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"RateError"];
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
		[s appendFormat: @"<errorId>%@</errorId>", [NSString stringWithFormat: @"%i", self.errorId]];
		if (self.errorMessage != nil) [s appendFormat: @"<errorMessage>%@</errorMessage>", [[self.errorMessage stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[RSPRateError class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end