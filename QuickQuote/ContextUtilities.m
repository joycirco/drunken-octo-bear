//
//  ContextUtilities.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "ContextUtilities.h"
#import "AccessorialType.h"
#import "HandlingUnitType.h"
#import "Accessorial.h"

@interface ContextUtilities()
{
}

-(void) CreatePersistedAccessorial:(NSString*)accName :(NSString*)accCode :(NSNumber*)accTypeID :(NSManagedObjectContext*)context;
-(void) CreatePersistedHUType:(NSString*)hutDesc :(NSString*)hutCode :(NSNumber*)huType :(NSManagedObjectContext*)context;

@end

@implementation ContextUtilities

-(void) generateApplicationData:(NSManagedObjectContext*)context
{
    
    AccessorialType *acc1 = [NSEntityDescription
                         insertNewObjectForEntityForName:@"AccessorialType"
                         inManagedObjectContext:context];
    
    acc1.accessorialTypeID = [NSNumber numberWithInt:1];
    acc1.accessorialTypeName = @"Pickup";

    
    AccessorialType *acc2 = [NSEntityDescription
                             insertNewObjectForEntityForName:@"AccessorialType"
                             inManagedObjectContext:context];
    
    acc2.accessorialTypeID = [NSNumber numberWithInt:2];
    acc2.accessorialTypeName = @"Delivery";


    AccessorialType *acc3 = [NSEntityDescription
                             insertNewObjectForEntityForName:@"AccessorialType"
                             inManagedObjectContext:context];
    
    acc3.accessorialTypeID = [NSNumber numberWithInt:3];
    acc3.accessorialTypeName = @"Shipment";
    
    
    
    
    //    1	Pallets (48 x 40)	1	PLT	Pallets (48 x 40)
    [self CreatePersistedHUType:@"Pallets (48 x 40)" :@"PLT" :[NSNumber numberWithInt:1] :context];

    //    2	Pallets (48 x 48)	1	PLT	Pallets (48 x 48)
    [self CreatePersistedHUType:@"Pallets (48 x 48)" :@"PLT" :[NSNumber numberWithInt:2] :context];

    //    4	Pallets (Enter Dimensions)	1	PLT	Pallets (Enter Dimensions)
    [self CreatePersistedHUType:@"Pallets (Enter Dimensions)" :@"PLT" :[NSNumber numberWithInt:4] :context];

    //    5	Bags	0	BAG	Bags
    [self CreatePersistedHUType:@"Bags" :@"BAG" :[NSNumber numberWithInt:5] :context];

    //    7	Boxes	0	BOX	Boxes
    //    8	Bunch/Bundle	0	BDL	Bundles
    //    9	Blister Pack	0	BME	Blister Pack
    //    10	Coils	0	COL	Coils
    //    11	Crates	0	CRT	Crates
    //    12	Cylinders	0	CYL	Cylinders
    //    13	Drums	0	DRM	Drums
    //    14	Pails	0	PAL	Pails
    //    15	Reels	0	REL	Reels
    //    16	Rolls	0	ROL	Rolls
    //    17	Pipes/Tubes	0	TBE	Pipes/Tubes
    //    18	Cartons	0	CTN	Cartons
    //    19	Cases	0	CAS	Cases
    //    20	Pieces	0	PCS	Pieces
    //    21	Totes	0	TOT	Totes
    //    23	Barrel	0	BBL	Barrel
    //    24	Bale	0	BAL	Bale
    //    27	Cabinet	0	CAB	Cabinet
    //    28	Can	0	CAN	Can
    //    29	Bottle	0	BOT	Bottle
    //    30	Carboy	0	CBY	Carboy
    //    32	Cask	0	CSK	Cask
    //    33	Loose	0	LSE	Loose
    //    34	Other	0	NULL Other
    [self CreatePersistedHUType:@"Other" :@"OTH" :[NSNumber numberWithInt:34] :context];
    //    35	Package	0	PKG	Package
    //    36	Pipe Line	0	NULL	Pipe Line
    //    37	Rack	0	RCK	Rack
    //    38	Skid	1	SKD	Skid
    //    39	Spool	0	SPL	Spool
    //    40	Tube	0	TBE	Tube
    //    41	Tank	0	TNK	Tank
    //    42	Unit	0	UNT	Unit
    //    43	Van Pack	0	VPK	Van Pack
    //    44	Wrapped	0	WRP	Wrapped
    //    46	Container	0	CNT	Container
    //    158	Slip Sheet	0	SLP	Slip Sheet
    //    174	Trailer	0	TRU	Truck Trailer

    
    NSArray* accDesc = [[NSArray alloc] initWithObjects:@"COD Fee", @"Construction Site", @"Convention/Tradeshow", @"Inside Delivery",
                 
                 @"Inside Pickup", @"Excessive Length", @"Liftgate Delivery", @"Limited Access", @"Notify for PU or Delivery",
                 
                          @"Protect from Freezing", @"Residential Delivery", @"Residential Pickup", @"Sort Segregate", @"Single Shipment",nil];
    
    
    //Accessorial Codes
    NSArray* accCode = [[NSArray alloc]initWithObjects:@"COD", @"CONST", @"CONV", @"ISDEL", @"ISPU", @"LENGTH", @"LGDel", @"LIMACCESS", @"NOTIFY",
                
                        @"PROTECTFRE", @"ResDel", @"ResPick", @"SORTSEG", @"SS", nil];

    NSArray* accTypes = [[NSArray alloc]initWithObjects: [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2],
                                          [NSNumber numberWithInt:1], [NSNumber numberWithInt:3],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],
                                          [NSNumber numberWithInt:3],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],nil];

    for(int i=0; i < accDesc.count; i++)
    {
        [self CreatePersistedAccessorial: [accDesc objectAtIndex:i ] : [accCode objectAtIndex:i] : [accTypes objectAtIndex:i] : context];
    }
}

-(void) CreatePersistedAccessorial:(NSString*)accName :(NSString*)accCode :(NSNumber*)accTypeID :(NSManagedObjectContext*)context
{
    Accessorial *acc = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Accessorial"
                        inManagedObjectContext:context];
    
    acc.accessorialName = accName;
    acc.accessorialCode = accCode;
    acc.accessorialTypeID = accTypeID;
    acc.timeStamp = [NSDate date];
  
}

-(void) CreatePersistedHUType:(NSString*)hutDesc :(NSString*)hutCode :(NSNumber*)huType :(NSManagedObjectContext*)context
{
    HandlingUnitType *h = [NSEntityDescription
                             insertNewObjectForEntityForName:@"HandlingUnitType"
                             inManagedObjectContext:context];
    
    h.handlingUnitTypeID = huType;
    h.handlingUnitTypeCode = hutCode;
    h.handlingUnitTypeDescription = hutDesc;
}

@end
