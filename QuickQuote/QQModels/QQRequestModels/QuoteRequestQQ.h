//
//  QuoteRequestQQ.h
//  ModelClasses
//
//  Created by Darin Raffety on 1/19/13.
//
//

#import <Foundation/Foundation.h>

#import "FreightItemQQ.h"
#import "AccessorialQQ.h"
#import "CredentialsQQ.h"

@interface QuoteRequestQQ : NSObject
{
    NSString* _originPostalCode;
    NSString* _destinationPostalCode;
    NSDate* _pickupDateTime;
    NSString* _storeLocationCode;
    CredentialsQQ* _credentials;
    
    NSMutableArray* _freightItems;
    NSMutableArray* _pickupAccessorials;
    NSMutableArray* _deliveryAccessorials;
    NSMutableArray* _shipmentAccessorials;
}

@property (nonatomic,retain) NSString *originPostalCode;
@property (nonatomic,retain) NSString *destinationPostalCode;
@property (nonatomic,retain) NSDate *pickupDateTime;
@property (nonatomic,retain) NSString *storeLocationCode;
@property (nonatomic,retain) CredentialsQQ *credentials;

@property (nonatomic,retain) NSMutableArray *freightItems;
@property (nonatomic,retain) NSMutableArray *pickupAccessorials;
@property (nonatomic,retain) NSMutableArray *deliveryAccessorials;
@property (nonatomic,retain) NSMutableArray *shipmentAccessorials;

- (id) init;
- (id) initWithDefaults;

-(void)submitRequest;

-(void)addFreightItem:(FreightItemQQ *)objFreight;
-(void)addFreightItems:(NSMutableArray *)objFreightItems;
-(void)removeFreightItem:(FreightItemQQ *)objFreight;
-(void)clearFreightItems;

-(void)addPickupAccessorial:(AccessorialQQ *)objAcc;
-(void)addPickupAccessorials:(NSMutableArray *)objAccs;
-(void)removePickupAccessorial:(Accessorial *)objAcc;
-(void)clearPickupAccessorials;

-(void)addDeliveryAccessorial:(AccessorialQQ *)objAcc;
-(void)addDeliveryAccessorials:(NSMutableArray *)objAccs;
-(void)removeDeliveryAccessorial:(Accessorial *)objAcc;
-(void)clearDeliveryAccessorials;

-(void)addShipmentAccessorial:(AccessorialQQ *)objAcc;
-(void)addShipmentAccessorials:(NSMutableArray *)objAccs;
-(void)removeShipmentAccessorial:(AccessorialQQ *)objAcc;
-(void)clearShipmentAccessorials;

@end
