//
//  QuoteRequestQQ.m
//  ModelClasses
//
//  Created by Darin Raffety on 1/19/13.
//
//

#import "QuoteRequestQQ.h"
#import "RSPRateServicePrivileged.h"
#import "RSPRateReturn.h"
#import "RSPRateRequestPrivileged.h"

@implementation QuoteRequestQQ

@synthesize originPostalCode = _originPostalCode;
@synthesize destinationPostalCode = _destinationPostalCode;
@synthesize storeLocationCode = _storeLocationCode;
@synthesize credentials = _credentials;

@synthesize pickupDateTime = _pickupDateTime;
@synthesize freightItems = _freightItems;
@synthesize pickupAccessorials = _pickupAccessorials;
@synthesize deliveryAccessorials = _deliveryAccessorials;
@synthesize shipmentAccessorials = _shipmentAccessorials;


- (id) init
{
    if(self = [super init])
    {
        self.originPostalCode = nil;
        self.destinationPostalCode = nil;
        self.storeLocationCode = nil;
        self.credentials = nil;
        self.pickupDateTime = nil;
        self.freightItems = nil;
        self.pickupAccessorials = nil;
        self.deliveryAccessorials = nil;
        self.shipmentAccessorials = nil;
        self.storeLocationCode = nil;
    }
    return self;
}

- (id) initWithDefaults
{
    if(self = [super init])
    {
        self.originPostalCode = @"50801";
        self.destinationPostalCode = @"66048";
        self.storeLocationCode = nil;
        self.credentials = [[CredentialsQQ alloc]init];
        self.credentials.loginName = @"testbot";
        self.credentials.password = @"supersecret486";
        self.credentials.accountId = @"32700120";
        self.credentials.token = @"268E46CD13B3A0B7CCC6D02CEF8DC92215C4F459";
        self.storeLocationCode =  @"13310001";
        self.pickupDateTime = [NSDate date];
        self.freightItems = nil;
        self.pickupAccessorials = nil;
        self.deliveryAccessorials = nil;
        self.shipmentAccessorials = nil;
    }
    return self;
}

-(void)submitRequest
{
	// Create the service
	RSPRateServicePrivileged* service = [[RSPRateServicePrivileged alloc] initWithUsername:@"testbot" andPassword:@"supersecret486"];
	service.logging = YES;
    
    service.username = @"testbot";
	service.password = @"supersecret486";
    
    RSPRateRequestPrivileged* reqRRP = [[RSPRateRequestPrivileged alloc] init];

    // credentials
    reqRRP.reqLoginName =  self.credentials.loginName;
    reqRRP.reqLoginPassword = self.credentials.password;
    reqRRP.reqAccountId = self.credentials.accountId;
    reqRRP.reqLoginToken = self.credentials.token;
    
    reqRRP.reqOriginZip = self.originPostalCode;
    reqRRP.reqDestZip = self.destinationPostalCode;
    
    reqRRP.reqPickupDate = self.pickupDateTime;

    int daysToAdd = 3;
    NSDate *newDate1 = [self.pickupDateTime dateByAddingTimeInterval:60*60*24*daysToAdd];
    reqRRP.reqDropDate = newDate1;
    
    // iterate through the freight items
    for(FreightItemQQ* fqr in _freightItems)
    {
        //[fqr performSelector];
        RSPFreight* f = [[RSPFreight alloc] init];
        f.freightClass = fqr.freightClass;
        f.weight = fqr.weight;
        f.units = fqr.handlingUnits;
        f.length = fqr.length;
        f.width = fqr.width;
        f.height = fqr.height;
        
        [reqRRP.reqFreight addObject: f];
    }
    
    // add pallet position
    reqRRP.reqPalletCount = 2;
    RSPPalletPositions* pp = [[RSPPalletPositions alloc] init];
    pp.length = 10;
    pp.height = 10;
    pp.width = 10;
    pp.weight = 3600;
    pp.positionCount = 2;
    [reqRRP.reqPalletPositions addObject: pp];
    
    reqRRP.reqViewSpecificCostContracts = true;
    reqRRP.reqViewGeneralCostContracts = true;
    reqRRP.reqViewGeneralBillingContracts = true;
    reqRRP.reqViewSpecificBillingContracts = true;
    reqRRP.reqViewWebCostContracts = true;
    reqRRP.reqViewWebBillingContracts = true;
    reqRRP.reqViewRatingCost = 1;
    
	// Returns RSPRateReturn*
	/*  */
	//[service RateShipment:self action:@selector(RateShipmentHandler:) rrp: [[RSPRateRequestPrivileged alloc] init]];
	[service RateShipment:self action:@selector(RateShipmentHandler:) rrp: reqRRP];
    
}


// Handle the response from RateShipment.
- (void) RateShipmentHandler: (id) value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}
    
	// Do something with the RSPRateReturn* result
    RSPRateReturn* result = (RSPRateReturn*)value;
	NSLog(@"RateShipment returned the value: %@", result);
    
}



-(void)addFreightItem:(FreightItemQQ *)objFreight
{
    if(_freightItems == nil)
        _freightItems = [[NSMutableArray alloc] init];
    
    if(objFreight !=nil)
        [_freightItems addObject:objFreight];
}

-(void)addFreightItems:(NSMutableArray *)objFreightItems
{
    if(_freightItems == nil)
        _freightItems = [[NSMutableArray alloc] init];

    if(objFreightItems != nil)
        [_freightItems addObjectsFromArray:objFreightItems];
}

-(void)removeFreightItem:(FreightItemQQ *)objFreight
{
    if((objFreight != nil)&&(_freightItems !=nil))
        [_freightItems removeObject:objFreight];
}

-(void)clearFreightItems
{
    if (_freightItems != nil)
        [_freightItems removeAllObjects];
}

-(void)addPickupAccessorial:(AccessorialQQ *)objAcc
{
    if(_pickupAccessorials == nil)
        _pickupAccessorials = [[NSMutableArray alloc] init];
    
    if(objAcc !=nil)
        [_pickupAccessorials addObject:objAcc];
}

-(void)addPickupAccessorials:(NSMutableArray *)objAccs
{
    if(_pickupAccessorials == nil)
        _pickupAccessorials = [[NSMutableArray alloc] init];
    
    if(objAccs != nil)
        [_pickupAccessorials addObjectsFromArray:objAccs];
}

-(void)removePickupAccessorial:(AccessorialQQ *)objAcc
{
    if((objAcc != nil)&&(_pickupAccessorials !=nil))
        [_pickupAccessorials removeObject:objAcc];
}

-(void)clearPickupAccessorials
{
    if (_pickupAccessorials != nil)
        [_pickupAccessorials removeAllObjects];
}

-(void)addDeliveryAccessorial:(AccessorialQQ *)objAcc
{
    if(_deliveryAccessorials == nil)
        _deliveryAccessorials = [[NSMutableArray alloc] init];
    
    if(objAcc !=nil)
        [_deliveryAccessorials addObject:objAcc];
}

-(void)addDeliveryAccessorials:(NSMutableArray *)objAccs
{
    if(_deliveryAccessorials == nil)
        _deliveryAccessorials = [[NSMutableArray alloc] init];
    
    if(objAccs != nil)
        [_deliveryAccessorials addObjectsFromArray:objAccs];
}

-(void)removeDeliveryAccessorial:(AccessorialQQ *)objAcc
{
    if((objAcc != nil)&&(_deliveryAccessorials !=nil))
        [_deliveryAccessorials removeObject:objAcc];
}

-(void)clearDeliveryAccessorials
{
    if(_deliveryAccessorials!=nil)
        [_deliveryAccessorials removeAllObjects];
}

-(void)addShipmentAccessorial:(AccessorialQQ *)objAcc
{
    if(_shipmentAccessorials == nil)
        _shipmentAccessorials = [[NSMutableArray alloc] init];
    
    if(objAcc !=nil)
        [_shipmentAccessorials addObject:objAcc];
}

-(void)addShipmentAccessorials:(NSMutableArray *)objAccs
{
    if (_shipmentAccessorials != nil)
        _shipmentAccessorials = [[NSMutableArray alloc] init];
    if (objAccs != nil)
        [_shipmentAccessorials addObjectsFromArray:objAccs];
}

-(void)removeShipmentAccessorial:(AccessorialQQ *)objAcc
{
    if((objAcc != nil)&&(_shipmentAccessorials !=nil))
        [_shipmentAccessorials removeObject:objAcc];
}

-(void)clearShipmentAccessorials
{
    if (_shipmentAccessorials != nil)
        [_shipmentAccessorials removeAllObjects];
}

@end
