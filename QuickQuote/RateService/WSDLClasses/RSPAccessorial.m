/*
	RSPAccessorial.h
	The implementation of properties and methods for the RSPAccessorial object.
	Generated by SudzC.com
*/
#import "RSPAccessorial.h"

@implementation RSPAccessorial
	@synthesize accCode = _accCode;

	- (id) init
	{
		if(self = [super init])
		{
			self.accCode = nil;

		}
		return self;
	}

	+ (RSPAccessorial*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return [[self alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.accCode = [Soap getNodeValue: node withName: @"accCode"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"Accessorial"];
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
		if (self.accCode != nil) [s appendFormat: @"<accCode>%@</accCode>", [[self.accCode stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[RSPAccessorial class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end
