/*
	RSPRateRequestPrivileged.h
	The implementation of properties and methods for the RSPRateRequestPrivileged object.
	Generated by SudzC.com
*/
#import "RSPRateRequestPrivileged.h"

#import "RSPArrayOfStopOff.h"
#import "RSPArrayOfFreight.h"
#import "RSPArrayOfPalletPositions.h"
#import "RSPArrayOfAccessorial.h"
#import "RSPArrayOfAccessorialRateOverride.h"
#import "RSPCarrierScacs.h"
@implementation RSPRateRequestPrivileged
	@synthesize reqLoginName = _reqLoginName;
	@synthesize reqLoginPassword = _reqLoginPassword;
	@synthesize reqAccountId = _reqAccountId;
	@synthesize reqLoginToken = _reqLoginToken;
	@synthesize reqReqId = _reqReqId;
	@synthesize reqReqReference = _reqReqReference;
	@synthesize reqReqMsg = _reqReqMsg;
	@synthesize reqReqFlag = _reqReqFlag;
	@synthesize reqOriginName = _reqOriginName;
	@synthesize reqOriginAddr1 = _reqOriginAddr1;
	@synthesize reqOriginAddr2 = _reqOriginAddr2;
	@synthesize reqOriginCity = _reqOriginCity;
	@synthesize reqOriginState = _reqOriginState;
	@synthesize reqOriginZip = _reqOriginZip;
	@synthesize reqOriginCountry = _reqOriginCountry;
	@synthesize reqOriginWarehouseId = _reqOriginWarehouseId;
	@synthesize reqOriginWarehouseCode = _reqOriginWarehouseCode;
	@synthesize reqDestName = _reqDestName;
	@synthesize reqDestAddr1 = _reqDestAddr1;
	@synthesize reqDestAddr2 = _reqDestAddr2;
	@synthesize reqDestCity = _reqDestCity;
	@synthesize reqDestState = _reqDestState;
	@synthesize reqDestZip = _reqDestZip;
	@synthesize reqDestCountry = _reqDestCountry;
	@synthesize reqDestWarehouseId = _reqDestWarehouseId;
	@synthesize reqDestWarehouseCode = _reqDestWarehouseCode;
	@synthesize reqRoutingCustomerCode = _reqRoutingCustomerCode;
	@synthesize reqStopOffs = _reqStopOffs;
	@synthesize reqStopOffCount = _reqStopOffCount;
	@synthesize reqNoLtl = _reqNoLtl;
	@synthesize reqNoTl = _reqNoTl;
	@synthesize reqNoParcel = _reqNoParcel;
	@synthesize reqNoRail = _reqNoRail;
	@synthesize reqNoInterModal = _reqNoInterModal;
	@synthesize reqNoAir = _reqNoAir;
	@synthesize reqNoUSPS = _reqNoUSPS;
	@synthesize reqNoTariff = _reqNoTariff;
	@synthesize reqNoFlat = _reqNoFlat;
	@synthesize reqNoMiles = _reqNoMiles;
	@synthesize reqNoPieces = _reqNoPieces;
	@synthesize reqNoPallets = _reqNoPallets;
	@synthesize reqNoCwt = _reqNoCwt;
	@synthesize reqNoCube = _reqNoCube;
	@synthesize reqNoLinearFeet = _reqNoLinearFeet;
	@synthesize reqNoArea = _reqNoArea;
	@synthesize reqNoDensity = _reqNoDensity;
	@synthesize reqNoMarkup = _reqNoMarkup;
	@synthesize reqNoWebServices = _reqNoWebServices;
	@synthesize reqParcelServiceType = _reqParcelServiceType;
	@synthesize reqParcelResidential = _reqParcelResidential;
	@synthesize reqParcelPackCode = _reqParcelPackCode;
	@synthesize reqParcelAccountNumber = _reqParcelAccountNumber;
	@synthesize reqFreight = _reqFreight;
	@synthesize reqFreightStackable = _reqFreightStackable;
	@synthesize reqPalletCount = _reqPalletCount;
	@synthesize reqPalletPositions = _reqPalletPositions;
	@synthesize reqMiles = _reqMiles;
	@synthesize reqLinearFeet = _reqLinearFeet;
	@synthesize reqArea = _reqArea;
	@synthesize reqIsSingleShipment = _reqIsSingleShipment;
	@synthesize reqIsMetric = _reqIsMetric;
	@synthesize reqMilesCityToCity = _reqMilesCityToCity;
	@synthesize reqRequestedAccessorialsOnly = _reqRequestedAccessorialsOnly;
	@synthesize reqSortBasedOnService = _reqSortBasedOnService;
	@synthesize reqOutboundPrepaid = _reqOutboundPrepaid;
	@synthesize reqInboundCollect = _reqInboundCollect;
	@synthesize reqThirdParty = _reqThirdParty;
	@synthesize reqInboundPrepaid = _reqInboundPrepaid;
	@synthesize reqOutboundCollect = _reqOutboundCollect;
	@synthesize reqIsHazmat = _reqIsHazmat;
	@synthesize reqDisallowDeficitWeightRating = _reqDisallowDeficitWeightRating;
	@synthesize reqShowZeroRates = _reqShowZeroRates;
	@synthesize reqEnforceShipmentValue = _reqEnforceShipmentValue;
	@synthesize reqForceCityStateValidation = _reqForceCityStateValidation;
	@synthesize reqDoNotApplyFAK = _reqDoNotApplyFAK;
	@synthesize reqPickupDate = _reqPickupDate;
	@synthesize reqDropDate = _reqDropDate;
	@synthesize reqAccessorials = _reqAccessorials;
	@synthesize reqAccessorialRateOverrides = _reqAccessorialRateOverrides;
	@synthesize reqScacFilter = _reqScacFilter;
	@synthesize reqAuditAmount = _reqAuditAmount;
	@synthesize reqTemperatureCode = _reqTemperatureCode;
	@synthesize reqHours = _reqHours;
	@synthesize reqShipmentValue = _reqShipmentValue;
	@synthesize reqNmfcCodes = _reqNmfcCodes;
	@synthesize reqBOLNumber = _reqBOLNumber;
	@synthesize reqCommitRatingCostDetailsToBOL = _reqCommitRatingCostDetailsToBOL;
	@synthesize reqCommitRatingChargeDetailsToBOL = _reqCommitRatingChargeDetailsToBOL;
	@synthesize reqCommitRatingMiscDetailsToBOL = _reqCommitRatingMiscDetailsToBOL;
	@synthesize reqViewRatingCost = _reqViewRatingCost;
	@synthesize reqViewRate_counter = _reqViewRate_counter;
	@synthesize reqViewQuoteToBolRatio = _reqViewQuoteToBolRatio;
	@synthesize reqViewGeneralCostContracts = _reqViewGeneralCostContracts;
	@synthesize reqViewGeneralBillingContracts = _reqViewGeneralBillingContracts;
	@synthesize reqViewSpecificCostContracts = _reqViewSpecificCostContracts;
	@synthesize reqViewSpecificBillingContracts = _reqViewSpecificBillingContracts;
	@synthesize reqViewWebCostContracts = _reqViewWebCostContracts;
	@synthesize reqViewWebBillingContracts = _reqViewWebBillingContracts;

	- (id) init
	{
		if(self = [super init])
		{
			self.reqLoginName = nil;
			self.reqLoginPassword = nil;
			self.reqAccountId = nil;
			self.reqLoginToken = nil;
			self.reqReqReference = nil;
			self.reqReqMsg = nil;
			self.reqOriginName = nil;
			self.reqOriginAddr1 = nil;
			self.reqOriginAddr2 = nil;
			self.reqOriginCity = nil;
			self.reqOriginState = nil;
			self.reqOriginZip = nil;
			self.reqOriginCountry = nil;
			self.reqOriginWarehouseCode = nil;
			self.reqDestName = nil;
			self.reqDestAddr1 = nil;
			self.reqDestAddr2 = nil;
			self.reqDestCity = nil;
			self.reqDestState = nil;
			self.reqDestZip = nil;
			self.reqDestCountry = nil;
			self.reqDestWarehouseCode = nil;
			self.reqRoutingCustomerCode = nil;
			self.reqStopOffs = [[NSMutableArray alloc] init];
			self.reqParcelPackCode = nil;
			self.reqParcelAccountNumber = nil;
			self.reqFreight = [[NSMutableArray alloc] init];
			self.reqPalletPositions = [[NSMutableArray alloc] init];
			self.reqPickupDate = nil;
			self.reqDropDate = nil;
			self.reqAccessorials = [[NSMutableArray alloc] init];
			self.reqAccessorialRateOverrides = [[NSMutableArray alloc] init];
			self.reqScacFilter = nil; // [[RSPCarrierScacs alloc] init];
			self.reqAuditAmount = nil;
			self.reqHours = nil;
			self.reqShipmentValue = nil;
			self.reqNmfcCodes = nil;
			self.reqBOLNumber = nil;

		}
		return self;
	}

	+ (RSPRateRequestPrivileged*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return [[self alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.reqLoginName = [Soap getNodeValue: node withName: @"reqLoginName"];
			self.reqLoginPassword = [Soap getNodeValue: node withName: @"reqLoginPassword"];
			self.reqAccountId = [Soap getNodeValue: node withName: @"reqAccountId"];
			self.reqLoginToken = [Soap getNodeValue: node withName: @"reqLoginToken"];
			self.reqReqId = [[Soap getNodeValue: node withName: @"reqReqId"] intValue];
			self.reqReqReference = [Soap getNodeValue: node withName: @"reqReqReference"];
			self.reqReqMsg = [Soap getNodeValue: node withName: @"reqReqMsg"];
			self.reqReqFlag = [[Soap getNodeValue: node withName: @"reqReqFlag"] intValue];
			self.reqOriginName = [Soap getNodeValue: node withName: @"reqOriginName"];
			self.reqOriginAddr1 = [Soap getNodeValue: node withName: @"reqOriginAddr1"];
			self.reqOriginAddr2 = [Soap getNodeValue: node withName: @"reqOriginAddr2"];
			self.reqOriginCity = [Soap getNodeValue: node withName: @"reqOriginCity"];
			self.reqOriginState = [Soap getNodeValue: node withName: @"reqOriginState"];
			self.reqOriginZip = [Soap getNodeValue: node withName: @"reqOriginZip"];
			self.reqOriginCountry = [Soap getNodeValue: node withName: @"reqOriginCountry"];
			self.reqOriginWarehouseId = [[Soap getNodeValue: node withName: @"reqOriginWarehouseId"] intValue];
			self.reqOriginWarehouseCode = [Soap getNodeValue: node withName: @"reqOriginWarehouseCode"];
			self.reqDestName = [Soap getNodeValue: node withName: @"reqDestName"];
			self.reqDestAddr1 = [Soap getNodeValue: node withName: @"reqDestAddr1"];
			self.reqDestAddr2 = [Soap getNodeValue: node withName: @"reqDestAddr2"];
			self.reqDestCity = [Soap getNodeValue: node withName: @"reqDestCity"];
			self.reqDestState = [Soap getNodeValue: node withName: @"reqDestState"];
			self.reqDestZip = [Soap getNodeValue: node withName: @"reqDestZip"];
			self.reqDestCountry = [Soap getNodeValue: node withName: @"reqDestCountry"];
			self.reqDestWarehouseId = [[Soap getNodeValue: node withName: @"reqDestWarehouseId"] intValue];
			self.reqDestWarehouseCode = [Soap getNodeValue: node withName: @"reqDestWarehouseCode"];
			self.reqRoutingCustomerCode = [Soap getNodeValue: node withName: @"reqRoutingCustomerCode"];
			self.reqStopOffs = [[RSPArrayOfStopOff createWithNode: [Soap getNode: node withName: @"reqStopOffs"]] object];
			self.reqStopOffCount = [[Soap getNodeValue: node withName: @"reqStopOffCount"] intValue];
			self.reqNoLtl = [[Soap getNodeValue: node withName: @"reqNoLtl"] boolValue];
			self.reqNoTl = [[Soap getNodeValue: node withName: @"reqNoTl"] boolValue];
			self.reqNoParcel = [[Soap getNodeValue: node withName: @"reqNoParcel"] boolValue];
			self.reqNoRail = [[Soap getNodeValue: node withName: @"reqNoRail"] boolValue];
			self.reqNoInterModal = [[Soap getNodeValue: node withName: @"reqNoInterModal"] boolValue];
			self.reqNoAir = [[Soap getNodeValue: node withName: @"reqNoAir"] boolValue];
			self.reqNoUSPS = [[Soap getNodeValue: node withName: @"reqNoUSPS"] boolValue];
			self.reqNoTariff = [[Soap getNodeValue: node withName: @"reqNoTariff"] boolValue];
			self.reqNoFlat = [[Soap getNodeValue: node withName: @"reqNoFlat"] boolValue];
			self.reqNoMiles = [[Soap getNodeValue: node withName: @"reqNoMiles"] boolValue];
			self.reqNoPieces = [[Soap getNodeValue: node withName: @"reqNoPieces"] boolValue];
			self.reqNoPallets = [[Soap getNodeValue: node withName: @"reqNoPallets"] boolValue];
			self.reqNoCwt = [[Soap getNodeValue: node withName: @"reqNoCwt"] boolValue];
			self.reqNoCube = [[Soap getNodeValue: node withName: @"reqNoCube"] boolValue];
			self.reqNoLinearFeet = [[Soap getNodeValue: node withName: @"reqNoLinearFeet"] boolValue];
			self.reqNoArea = [[Soap getNodeValue: node withName: @"reqNoArea"] boolValue];
			self.reqNoDensity = [[Soap getNodeValue: node withName: @"reqNoDensity"] boolValue];
			self.reqNoMarkup = [[Soap getNodeValue: node withName: @"reqNoMarkup"] boolValue];
			self.reqNoWebServices = [[Soap getNodeValue: node withName: @"reqNoWebServices"] boolValue];
			self.reqParcelServiceType = [[Soap getNodeValue: node withName: @"reqParcelServiceType"] intValue];
			self.reqParcelResidential = [[Soap getNodeValue: node withName: @"reqParcelResidential"] boolValue];
			self.reqParcelPackCode = [Soap getNodeValue: node withName: @"reqParcelPackCode"];
			self.reqParcelAccountNumber = [Soap getNodeValue: node withName: @"reqParcelAccountNumber"];
			self.reqFreight = [[RSPArrayOfFreight createWithNode: [Soap getNode: node withName: @"reqFreight"]] object];
			self.reqFreightStackable = [[Soap getNodeValue: node withName: @"reqFreightStackable"] boolValue];
			self.reqPalletCount = [[Soap getNodeValue: node withName: @"reqPalletCount"] intValue];
			self.reqPalletPositions = [[RSPArrayOfPalletPositions createWithNode: [Soap getNode: node withName: @"reqPalletPositions"]] object];
			self.reqMiles = [[Soap getNodeValue: node withName: @"reqMiles"] intValue];
			self.reqLinearFeet = [[Soap getNodeValue: node withName: @"reqLinearFeet"] intValue];
			self.reqArea = [[Soap getNodeValue: node withName: @"reqArea"] intValue];
			self.reqIsSingleShipment = [[Soap getNodeValue: node withName: @"reqIsSingleShipment"] boolValue];
			self.reqIsMetric = [[Soap getNodeValue: node withName: @"reqIsMetric"] boolValue];
			self.reqMilesCityToCity = [[Soap getNodeValue: node withName: @"reqMilesCityToCity"] boolValue];
			self.reqRequestedAccessorialsOnly = [[Soap getNodeValue: node withName: @"reqRequestedAccessorialsOnly"] boolValue];
			self.reqSortBasedOnService = [[Soap getNodeValue: node withName: @"reqSortBasedOnService"] boolValue];
			self.reqOutboundPrepaid = [[Soap getNodeValue: node withName: @"reqOutboundPrepaid"] boolValue];
			self.reqInboundCollect = [[Soap getNodeValue: node withName: @"reqInboundCollect"] boolValue];
			self.reqThirdParty = [[Soap getNodeValue: node withName: @"reqThirdParty"] boolValue];
			self.reqInboundPrepaid = [[Soap getNodeValue: node withName: @"reqInboundPrepaid"] boolValue];
			self.reqOutboundCollect = [[Soap getNodeValue: node withName: @"reqOutboundCollect"] boolValue];
			self.reqIsHazmat = [[Soap getNodeValue: node withName: @"reqIsHazmat"] boolValue];
			self.reqDisallowDeficitWeightRating = [[Soap getNodeValue: node withName: @"reqDisallowDeficitWeightRating"] boolValue];
			self.reqShowZeroRates = [[Soap getNodeValue: node withName: @"reqShowZeroRates"] boolValue];
			self.reqEnforceShipmentValue = [[Soap getNodeValue: node withName: @"reqEnforceShipmentValue"] boolValue];
			self.reqForceCityStateValidation = [[Soap getNodeValue: node withName: @"reqForceCityStateValidation"] boolValue];
			self.reqDoNotApplyFAK = [[Soap getNodeValue: node withName: @"reqDoNotApplyFAK"] boolValue];
			self.reqPickupDate = [Soap dateFromString: [Soap getNodeValue: node withName: @"reqPickupDate"]];
			self.reqDropDate = [Soap dateFromString: [Soap getNodeValue: node withName: @"reqDropDate"]];
			self.reqAccessorials = [[RSPArrayOfAccessorial createWithNode: [Soap getNode: node withName: @"reqAccessorials"]] object];
			self.reqAccessorialRateOverrides = [[RSPArrayOfAccessorialRateOverride createWithNode: [Soap getNode: node withName: @"reqAccessorialRateOverrides"]] object];
			self.reqScacFilter = [[RSPCarrierScacs createWithNode: [Soap getNode: node withName: @"reqScacFilter"]] object];
			self.reqAuditAmount = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"reqAuditAmount"]];
			self.reqTemperatureCode = [[Soap getNodeValue: node withName: @"reqTemperatureCode"] intValue];
			self.reqHours = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"reqHours"]];
			self.reqShipmentValue = [NSDecimalNumber decimalNumberWithString: [Soap getNodeValue: node withName: @"reqShipmentValue"]];
			self.reqNmfcCodes = [Soap getNodeValue: node withName: @"reqNmfcCodes"];
			self.reqBOLNumber = [Soap getNodeValue: node withName: @"reqBOLNumber"];
			self.reqCommitRatingCostDetailsToBOL = [[Soap getNodeValue: node withName: @"reqCommitRatingCostDetailsToBOL"] boolValue];
			self.reqCommitRatingChargeDetailsToBOL = [[Soap getNodeValue: node withName: @"reqCommitRatingChargeDetailsToBOL"] boolValue];
			self.reqCommitRatingMiscDetailsToBOL = [[Soap getNodeValue: node withName: @"reqCommitRatingMiscDetailsToBOL"] boolValue];
			self.reqViewRatingCost = [[Soap getNodeValue: node withName: @"reqViewRatingCost"] boolValue];
			self.reqViewRate_counter = [[Soap getNodeValue: node withName: @"reqViewRate_counter"] boolValue];
			self.reqViewQuoteToBolRatio = [[Soap getNodeValue: node withName: @"reqViewQuoteToBolRatio"] boolValue];
			self.reqViewGeneralCostContracts = [[Soap getNodeValue: node withName: @"reqViewGeneralCostContracts"] boolValue];
			self.reqViewGeneralBillingContracts = [[Soap getNodeValue: node withName: @"reqViewGeneralBillingContracts"] boolValue];
			self.reqViewSpecificCostContracts = [[Soap getNodeValue: node withName: @"reqViewSpecificCostContracts"] boolValue];
			self.reqViewSpecificBillingContracts = [[Soap getNodeValue: node withName: @"reqViewSpecificBillingContracts"] boolValue];
			self.reqViewWebCostContracts = [[Soap getNodeValue: node withName: @"reqViewWebCostContracts"] boolValue];
			self.reqViewWebBillingContracts = [[Soap getNodeValue: node withName: @"reqViewWebBillingContracts"] boolValue];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"RateRequestPrivileged"];
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
		if (self.reqLoginName != nil) [s appendFormat: @"<reqLoginName>%@</reqLoginName>", [[self.reqLoginName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqLoginPassword != nil) [s appendFormat: @"<reqLoginPassword>%@</reqLoginPassword>", [[self.reqLoginPassword stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqAccountId != nil) [s appendFormat: @"<reqAccountId>%@</reqAccountId>", [[self.reqAccountId stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqLoginToken != nil) [s appendFormat: @"<reqLoginToken>%@</reqLoginToken>", [[self.reqLoginToken stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<reqReqId>%@</reqReqId>", [NSString stringWithFormat: @"%i", self.reqReqId]];
		if (self.reqReqReference != nil) [s appendFormat: @"<reqReqReference>%@</reqReqReference>", [[self.reqReqReference stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqReqMsg != nil) [s appendFormat: @"<reqReqMsg>%@</reqReqMsg>", [[self.reqReqMsg stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<reqReqFlag>%@</reqReqFlag>", [NSString stringWithFormat: @"%i", self.reqReqFlag]];
		if (self.reqOriginName != nil) [s appendFormat: @"<reqOriginName>%@</reqOriginName>", [[self.reqOriginName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqOriginAddr1 != nil) [s appendFormat: @"<reqOriginAddr1>%@</reqOriginAddr1>", [[self.reqOriginAddr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqOriginAddr2 != nil) [s appendFormat: @"<reqOriginAddr2>%@</reqOriginAddr2>", [[self.reqOriginAddr2 stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqOriginCity != nil) [s appendFormat: @"<reqOriginCity>%@</reqOriginCity>", [[self.reqOriginCity stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqOriginState != nil) [s appendFormat: @"<reqOriginState>%@</reqOriginState>", [[self.reqOriginState stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqOriginZip != nil) [s appendFormat: @"<reqOriginZip>%@</reqOriginZip>", [[self.reqOriginZip stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqOriginCountry != nil) [s appendFormat: @"<reqOriginCountry>%@</reqOriginCountry>", [[self.reqOriginCountry stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<reqOriginWarehouseId>%@</reqOriginWarehouseId>", [NSString stringWithFormat: @"%i", self.reqOriginWarehouseId]];
		if (self.reqOriginWarehouseCode != nil) [s appendFormat: @"<reqOriginWarehouseCode>%@</reqOriginWarehouseCode>", [[self.reqOriginWarehouseCode stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqDestName != nil) [s appendFormat: @"<reqDestName>%@</reqDestName>", [[self.reqDestName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqDestAddr1 != nil) [s appendFormat: @"<reqDestAddr1>%@</reqDestAddr1>", [[self.reqDestAddr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqDestAddr2 != nil) [s appendFormat: @"<reqDestAddr2>%@</reqDestAddr2>", [[self.reqDestAddr2 stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqDestCity != nil) [s appendFormat: @"<reqDestCity>%@</reqDestCity>", [[self.reqDestCity stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqDestState != nil) [s appendFormat: @"<reqDestState>%@</reqDestState>", [[self.reqDestState stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqDestZip != nil) [s appendFormat: @"<reqDestZip>%@</reqDestZip>", [[self.reqDestZip stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqDestCountry != nil) [s appendFormat: @"<reqDestCountry>%@</reqDestCountry>", [[self.reqDestCountry stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<reqDestWarehouseId>%@</reqDestWarehouseId>", [NSString stringWithFormat: @"%i", self.reqDestWarehouseId]];
		if (self.reqDestWarehouseCode != nil) [s appendFormat: @"<reqDestWarehouseCode>%@</reqDestWarehouseCode>", [[self.reqDestWarehouseCode stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqRoutingCustomerCode != nil) [s appendFormat: @"<reqRoutingCustomerCode>%@</reqRoutingCustomerCode>", [[self.reqRoutingCustomerCode stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqStopOffs != nil && self.reqStopOffs.count > 0) {
			[s appendFormat: @"<reqStopOffs>%@</reqStopOffs>", [RSPArrayOfStopOff serialize: self.reqStopOffs]];
		} else {
			[s appendString: @"<reqStopOffs/>"];
		}
		[s appendFormat: @"<reqStopOffCount>%@</reqStopOffCount>", [NSString stringWithFormat: @"%i", self.reqStopOffCount]];
		[s appendFormat: @"<reqNoLtl>%@</reqNoLtl>", (self.reqNoLtl)?@"true":@"false"];
		[s appendFormat: @"<reqNoTl>%@</reqNoTl>", (self.reqNoTl)?@"true":@"false"];
		[s appendFormat: @"<reqNoParcel>%@</reqNoParcel>", (self.reqNoParcel)?@"true":@"false"];
		[s appendFormat: @"<reqNoRail>%@</reqNoRail>", (self.reqNoRail)?@"true":@"false"];
		[s appendFormat: @"<reqNoInterModal>%@</reqNoInterModal>", (self.reqNoInterModal)?@"true":@"false"];
		[s appendFormat: @"<reqNoAir>%@</reqNoAir>", (self.reqNoAir)?@"true":@"false"];
		[s appendFormat: @"<reqNoUSPS>%@</reqNoUSPS>", (self.reqNoUSPS)?@"true":@"false"];
		[s appendFormat: @"<reqNoTariff>%@</reqNoTariff>", (self.reqNoTariff)?@"true":@"false"];
		[s appendFormat: @"<reqNoFlat>%@</reqNoFlat>", (self.reqNoFlat)?@"true":@"false"];
		[s appendFormat: @"<reqNoMiles>%@</reqNoMiles>", (self.reqNoMiles)?@"true":@"false"];
		[s appendFormat: @"<reqNoPieces>%@</reqNoPieces>", (self.reqNoPieces)?@"true":@"false"];
		[s appendFormat: @"<reqNoPallets>%@</reqNoPallets>", (self.reqNoPallets)?@"true":@"false"];
		[s appendFormat: @"<reqNoCwt>%@</reqNoCwt>", (self.reqNoCwt)?@"true":@"false"];
		[s appendFormat: @"<reqNoCube>%@</reqNoCube>", (self.reqNoCube)?@"true":@"false"];
		[s appendFormat: @"<reqNoLinearFeet>%@</reqNoLinearFeet>", (self.reqNoLinearFeet)?@"true":@"false"];
		[s appendFormat: @"<reqNoArea>%@</reqNoArea>", (self.reqNoArea)?@"true":@"false"];
		[s appendFormat: @"<reqNoDensity>%@</reqNoDensity>", (self.reqNoDensity)?@"true":@"false"];
		[s appendFormat: @"<reqNoMarkup>%@</reqNoMarkup>", (self.reqNoMarkup)?@"true":@"false"];
		[s appendFormat: @"<reqNoWebServices>%@</reqNoWebServices>", (self.reqNoWebServices)?@"true":@"false"];
		[s appendFormat: @"<reqParcelServiceType>%@</reqParcelServiceType>", [NSString stringWithFormat: @"%i", self.reqParcelServiceType]];
		[s appendFormat: @"<reqParcelResidential>%@</reqParcelResidential>", (self.reqParcelResidential)?@"true":@"false"];
		if (self.reqParcelPackCode != nil) [s appendFormat: @"<reqParcelPackCode>%@</reqParcelPackCode>", [[self.reqParcelPackCode stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqParcelAccountNumber != nil) [s appendFormat: @"<reqParcelAccountNumber>%@</reqParcelAccountNumber>", [[self.reqParcelAccountNumber stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqFreight != nil && self.reqFreight.count > 0) {
			[s appendFormat: @"<reqFreight>%@</reqFreight>", [RSPArrayOfFreight serialize: self.reqFreight]];
		} else {
			[s appendString: @"<reqFreight/>"];
		}
		[s appendFormat: @"<reqFreightStackable>%@</reqFreightStackable>", (self.reqFreightStackable)?@"true":@"false"];
		[s appendFormat: @"<reqPalletCount>%@</reqPalletCount>", [NSString stringWithFormat: @"%i", self.reqPalletCount]];
		if (self.reqPalletPositions != nil && self.reqPalletPositions.count > 0) {
			[s appendFormat: @"<reqPalletPositions>%@</reqPalletPositions>", [RSPArrayOfPalletPositions serialize: self.reqPalletPositions]];
		} else {
			[s appendString: @"<reqPalletPositions/>"];
		}
		[s appendFormat: @"<reqMiles>%@</reqMiles>", [NSString stringWithFormat: @"%i", self.reqMiles]];
		[s appendFormat: @"<reqLinearFeet>%@</reqLinearFeet>", [NSString stringWithFormat: @"%i", self.reqLinearFeet]];
		[s appendFormat: @"<reqArea>%@</reqArea>", [NSString stringWithFormat: @"%i", self.reqArea]];
		[s appendFormat: @"<reqIsSingleShipment>%@</reqIsSingleShipment>", (self.reqIsSingleShipment)?@"true":@"false"];
		[s appendFormat: @"<reqIsMetric>%@</reqIsMetric>", (self.reqIsMetric)?@"true":@"false"];
		[s appendFormat: @"<reqMilesCityToCity>%@</reqMilesCityToCity>", (self.reqMilesCityToCity)?@"true":@"false"];
		[s appendFormat: @"<reqRequestedAccessorialsOnly>%@</reqRequestedAccessorialsOnly>", (self.reqRequestedAccessorialsOnly)?@"true":@"false"];
		[s appendFormat: @"<reqSortBasedOnService>%@</reqSortBasedOnService>", (self.reqSortBasedOnService)?@"true":@"false"];
		[s appendFormat: @"<reqOutboundPrepaid>%@</reqOutboundPrepaid>", (self.reqOutboundPrepaid)?@"true":@"false"];
		[s appendFormat: @"<reqInboundCollect>%@</reqInboundCollect>", (self.reqInboundCollect)?@"true":@"false"];
		[s appendFormat: @"<reqThirdParty>%@</reqThirdParty>", (self.reqThirdParty)?@"true":@"false"];
		[s appendFormat: @"<reqInboundPrepaid>%@</reqInboundPrepaid>", (self.reqInboundPrepaid)?@"true":@"false"];
		[s appendFormat: @"<reqOutboundCollect>%@</reqOutboundCollect>", (self.reqOutboundCollect)?@"true":@"false"];
		[s appendFormat: @"<reqIsHazmat>%@</reqIsHazmat>", (self.reqIsHazmat)?@"true":@"false"];
		[s appendFormat: @"<reqDisallowDeficitWeightRating>%@</reqDisallowDeficitWeightRating>", (self.reqDisallowDeficitWeightRating)?@"true":@"false"];
		[s appendFormat: @"<reqShowZeroRates>%@</reqShowZeroRates>", (self.reqShowZeroRates)?@"true":@"false"];
		[s appendFormat: @"<reqEnforceShipmentValue>%@</reqEnforceShipmentValue>", (self.reqEnforceShipmentValue)?@"true":@"false"];
		[s appendFormat: @"<reqForceCityStateValidation>%@</reqForceCityStateValidation>", (self.reqForceCityStateValidation)?@"true":@"false"];
		[s appendFormat: @"<reqDoNotApplyFAK>%@</reqDoNotApplyFAK>", (self.reqDoNotApplyFAK)?@"true":@"false"];
		if (self.reqPickupDate != nil) [s appendFormat: @"<reqPickupDate>%@</reqPickupDate>", [Soap getDateString: self.reqPickupDate]];
		if (self.reqDropDate != nil) [s appendFormat: @"<reqDropDate>%@</reqDropDate>", [Soap getDateString: self.reqDropDate]];
		if (self.reqAccessorials != nil && self.reqAccessorials.count > 0) {
			[s appendFormat: @"<reqAccessorials>%@</reqAccessorials>", [RSPArrayOfAccessorial serialize: self.reqAccessorials]];
		} else {
			[s appendString: @"<reqAccessorials/>"];
		}
		if (self.reqAccessorialRateOverrides != nil && self.reqAccessorialRateOverrides.count > 0) {
			[s appendFormat: @"<reqAccessorialRateOverrides>%@</reqAccessorialRateOverrides>", [RSPArrayOfAccessorialRateOverride serialize: self.reqAccessorialRateOverrides]];
		} else {
			[s appendString: @"<reqAccessorialRateOverrides/>"];
		}
		if (self.reqScacFilter != nil) [s appendString: [self.reqScacFilter serialize: @"reqScacFilter"]];
		if (self.reqAuditAmount != nil) [s appendFormat: @"<reqAuditAmount>%@</reqAuditAmount>", [NSString stringWithFormat: @"%@", self.reqAuditAmount]];
		[s appendFormat: @"<reqTemperatureCode>%@</reqTemperatureCode>", [NSString stringWithFormat: @"%i", self.reqTemperatureCode]];
		if (self.reqHours != nil) [s appendFormat: @"<reqHours>%@</reqHours>", [NSString stringWithFormat: @"%@", self.reqHours]];
		if (self.reqShipmentValue != nil) [s appendFormat: @"<reqShipmentValue>%@</reqShipmentValue>", [NSString stringWithFormat: @"%@", self.reqShipmentValue]];
		if (self.reqNmfcCodes != nil) [s appendFormat: @"<reqNmfcCodes>%@</reqNmfcCodes>", [[self.reqNmfcCodes stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reqBOLNumber != nil) [s appendFormat: @"<reqBOLNumber>%@</reqBOLNumber>", [[self.reqBOLNumber stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<reqCommitRatingCostDetailsToBOL>%@</reqCommitRatingCostDetailsToBOL>", (self.reqCommitRatingCostDetailsToBOL)?@"true":@"false"];
		[s appendFormat: @"<reqCommitRatingChargeDetailsToBOL>%@</reqCommitRatingChargeDetailsToBOL>", (self.reqCommitRatingChargeDetailsToBOL)?@"true":@"false"];
		[s appendFormat: @"<reqCommitRatingMiscDetailsToBOL>%@</reqCommitRatingMiscDetailsToBOL>", (self.reqCommitRatingMiscDetailsToBOL)?@"true":@"false"];
		[s appendFormat: @"<reqViewRatingCost>%@</reqViewRatingCost>", (self.reqViewRatingCost)?@"true":@"false"];
		[s appendFormat: @"<reqViewRate_counter>%@</reqViewRate_counter>", (self.reqViewRate_counter)?@"true":@"false"];
		[s appendFormat: @"<reqViewQuoteToBolRatio>%@</reqViewQuoteToBolRatio>", (self.reqViewQuoteToBolRatio)?@"true":@"false"];
		[s appendFormat: @"<reqViewGeneralCostContracts>%@</reqViewGeneralCostContracts>", (self.reqViewGeneralCostContracts)?@"true":@"false"];
		[s appendFormat: @"<reqViewGeneralBillingContracts>%@</reqViewGeneralBillingContracts>", (self.reqViewGeneralBillingContracts)?@"true":@"false"];
		[s appendFormat: @"<reqViewSpecificCostContracts>%@</reqViewSpecificCostContracts>", (self.reqViewSpecificCostContracts)?@"true":@"false"];
		[s appendFormat: @"<reqViewSpecificBillingContracts>%@</reqViewSpecificBillingContracts>", (self.reqViewSpecificBillingContracts)?@"true":@"false"];
		[s appendFormat: @"<reqViewWebCostContracts>%@</reqViewWebCostContracts>", (self.reqViewWebCostContracts)?@"true":@"false"];
		[s appendFormat: @"<reqViewWebBillingContracts>%@</reqViewWebBillingContracts>", (self.reqViewWebBillingContracts)?@"true":@"false"];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[RSPRateRequestPrivileged class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end