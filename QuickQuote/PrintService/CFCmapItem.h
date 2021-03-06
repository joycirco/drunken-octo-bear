/*
	CFCmapItem.h
	The interface definition of properties and methods for the CFCmapItem object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface CFCmapItem : SoapObject
{
	id _key;
	id _value;
	
}
		
	@property (retain, nonatomic) id key;
	@property (retain, nonatomic) id value;

	+ (CFCmapItem*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
