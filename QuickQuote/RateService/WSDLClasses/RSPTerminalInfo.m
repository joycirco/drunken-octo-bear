/*
	RSPTerminalInfo.h
	The implementation of properties and methods for the RSPTerminalInfo object.
	Generated by SudzC.com
*/
#import "RSPTerminalInfo.h"

@implementation RSPTerminalInfo
	@synthesize termCity = _termCity;
	@synthesize termCode = _termCode;
	@synthesize termContact = _termContact;
	@synthesize termContactTitle = _termContactTitle;
	@synthesize termEmail = _termEmail;
	@synthesize termFax = _termFax;
	@synthesize termName = _termName;
	@synthesize termState = _termState;
	@synthesize termStreet1 = _termStreet1;
	@synthesize termStreet2 = _termStreet2;
	@synthesize termTel = _termTel;
	@synthesize termTollFree = _termTollFree;
	@synthesize termZip = _termZip;

	- (id) init
	{
		if(self = [super init])
		{
			self.termCity = nil;
			self.termCode = nil;
			self.termContact = nil;
			self.termContactTitle = nil;
			self.termEmail = nil;
			self.termFax = nil;
			self.termName = nil;
			self.termState = nil;
			self.termStreet1 = nil;
			self.termStreet2 = nil;
			self.termTel = nil;
			self.termTollFree = nil;
			self.termZip = nil;

		}
		return self;
	}

	+ (RSPTerminalInfo*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return [[self alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.termCity = [Soap getNodeValue: node withName: @"termCity"];
			self.termCode = [Soap getNodeValue: node withName: @"termCode"];
			self.termContact = [Soap getNodeValue: node withName: @"termContact"];
			self.termContactTitle = [Soap getNodeValue: node withName: @"termContactTitle"];
			self.termEmail = [Soap getNodeValue: node withName: @"termEmail"];
			self.termFax = [Soap getNodeValue: node withName: @"termFax"];
			self.termName = [Soap getNodeValue: node withName: @"termName"];
			self.termState = [Soap getNodeValue: node withName: @"termState"];
			self.termStreet1 = [Soap getNodeValue: node withName: @"termStreet1"];
			self.termStreet2 = [Soap getNodeValue: node withName: @"termStreet2"];
			self.termTel = [Soap getNodeValue: node withName: @"termTel"];
			self.termTollFree = [Soap getNodeValue: node withName: @"termTollFree"];
			self.termZip = [Soap getNodeValue: node withName: @"termZip"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"TerminalInfo"];
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
		if (self.termCity != nil) [s appendFormat: @"<termCity>%@</termCity>", [[self.termCity stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termCode != nil) [s appendFormat: @"<termCode>%@</termCode>", [[self.termCode stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termContact != nil) [s appendFormat: @"<termContact>%@</termContact>", [[self.termContact stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termContactTitle != nil) [s appendFormat: @"<termContactTitle>%@</termContactTitle>", [[self.termContactTitle stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termEmail != nil) [s appendFormat: @"<termEmail>%@</termEmail>", [[self.termEmail stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termFax != nil) [s appendFormat: @"<termFax>%@</termFax>", [[self.termFax stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termName != nil) [s appendFormat: @"<termName>%@</termName>", [[self.termName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termState != nil) [s appendFormat: @"<termState>%@</termState>", [[self.termState stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termStreet1 != nil) [s appendFormat: @"<termStreet1>%@</termStreet1>", [[self.termStreet1 stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termStreet2 != nil) [s appendFormat: @"<termStreet2>%@</termStreet2>", [[self.termStreet2 stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termTel != nil) [s appendFormat: @"<termTel>%@</termTel>", [[self.termTel stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termTollFree != nil) [s appendFormat: @"<termTollFree>%@</termTollFree>", [[self.termTollFree stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.termZip != nil) [s appendFormat: @"<termZip>%@</termZip>", [[self.termZip stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[RSPTerminalInfo class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end
