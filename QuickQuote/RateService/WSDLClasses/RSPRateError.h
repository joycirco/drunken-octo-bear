/*
	RSPRateError.h
	The interface definition of properties and methods for the RSPRateError object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface RSPRateError : SoapObject
{
	int _errorId;
	NSString* _errorMessage;
	
}
		
	@property int errorId;
	@property (retain, nonatomic) NSString* errorMessage;

	+ (RSPRateError*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
