/*
	RSPBilling3rdParty.h
	The interface definition of properties and methods for the RSPBilling3rdParty object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface RSPBilling3rdParty : SoapObject
{
	NSString* _b3pBilltoHeader;
	NSString* _b3pName1;
	NSString* _b3pName2;
	NSString* _b3pName3;
	NSString* _b3pStreet1;
	NSString* _b3pStreet2;
	NSString* _b3pStreet3;
	NSString* _b3pStreet4;
	NSString* _b3pCity;
	NSString* _b3pState;
	NSString* _b3pCountry;
	NSString* _b3pZip;
	NSString* _b3pLatitude;
	NSString* _b3pLongitude;
	
}
		
	@property (retain, nonatomic) NSString* b3pBilltoHeader;
	@property (retain, nonatomic) NSString* b3pName1;
	@property (retain, nonatomic) NSString* b3pName2;
	@property (retain, nonatomic) NSString* b3pName3;
	@property (retain, nonatomic) NSString* b3pStreet1;
	@property (retain, nonatomic) NSString* b3pStreet2;
	@property (retain, nonatomic) NSString* b3pStreet3;
	@property (retain, nonatomic) NSString* b3pStreet4;
	@property (retain, nonatomic) NSString* b3pCity;
	@property (retain, nonatomic) NSString* b3pState;
	@property (retain, nonatomic) NSString* b3pCountry;
	@property (retain, nonatomic) NSString* b3pZip;
	@property (retain, nonatomic) NSString* b3pLatitude;
	@property (retain, nonatomic) NSString* b3pLongitude;

	+ (RSPBilling3rdParty*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
