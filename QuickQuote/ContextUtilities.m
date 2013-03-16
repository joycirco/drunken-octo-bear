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
#import "PersistedAccessorial.h"

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
    
    AccessorialType *acc4 = [NSEntityDescription
                             insertNewObjectForEntityForName:@"AccessorialType"
                             inManagedObjectContext:context];
    
    acc4.accessorialTypeID = [NSNumber numberWithInt:4];
    acc4.accessorialTypeName = @"Freight";
    
    
    //    1	Pallets (48 x 40)	1	PLT	Pallets (48 x 40)
    [self CreatePersistedHUType:@"Pallets (48 x 40)" :@"PLT" :[NSNumber numberWithInt:1] :context];

    //    2	Pallets (48 x 48)	1	PLT	Pallets (48 x 48)
    [self CreatePersistedHUType:@"Pallets (48 x 48)" :@"PLT" :[NSNumber numberWithInt:2] :context];

    //    4	Pallets (Enter Dimensions)	1	PLT	Pallets (Enter Dimensions)
    [self CreatePersistedHUType:@"Pallets (Enter Dimensions)" :@"PLT" :[NSNumber numberWithInt:4] :context];

    //    5	Bags	0	BAG	Bags
    [self CreatePersistedHUType:@"Bags" :@"BAG" :[NSNumber numberWithInt:5] :context];

    //    7	Boxes	0	BOX	Boxes
    [self CreatePersistedHUType:@"Boxes" :@"BOX" :[NSNumber numberWithInt:7] :context];

    //    8	Bunch/Bundle	0	BDL	Bundles
    [self CreatePersistedHUType:@"Bunch/Bundle" :@"BDL" :[NSNumber numberWithInt:8] :context];

    //    9	Blister Pack	0	BME	Blister Pack
    [self CreatePersistedHUType:@"Blister Pack" :@"BME" :[NSNumber numberWithInt:9] :context];

    //    10	Coils	0	COL	Coils
    [self CreatePersistedHUType:@"Coils" :@"COL" :[NSNumber numberWithInt:10] :context];

    //    11	Crates	0	CRT	Crates
    [self CreatePersistedHUType:@"Crates" :@"CRT" :[NSNumber numberWithInt:11] :context];
    
    //    12	Cylinders	0	CYL	Cylinders
    [self CreatePersistedHUType:@"Cylinders" :@"CYL" :[NSNumber numberWithInt:12] :context];
    
    //    13	Drums	0	DRM	Drums
    [self CreatePersistedHUType:@"Drums" :@"DRM" :[NSNumber numberWithInt:13] :context];

    //    14	Pails	0	PAL	Pails
    [self CreatePersistedHUType:@"Pails" :@"PAL" :[NSNumber numberWithInt:14] :context];

    //    15	Reels	0	REL	Reels
    [self CreatePersistedHUType:@"Reels" :@"REL" :[NSNumber numberWithInt:15] :context];

    //    16	Rolls	0	ROL	Rolls
    [self CreatePersistedHUType:@"Rolls" :@"ROL" :[NSNumber numberWithInt:16] :context];

    //    17	Pipes/Tubes	0	TBE	Pipes/Tubes
    [self CreatePersistedHUType:@"Pipes/Tubes" :@"TBE" :[NSNumber numberWithInt:17] :context];

    //    18	Cartons	0	CTN	Cartons
    [self CreatePersistedHUType:@"Cartons" :@"CTN" :[NSNumber numberWithInt:18] :context];

    //    19	Cases	0	CAS	Cases
    [self CreatePersistedHUType:@"Cases" :@"CAS" :[NSNumber numberWithInt:19] :context];
    
    //    20	Pieces	0	PCS	Pieces
    [self CreatePersistedHUType:@"Pieces" :@"PCS" :[NSNumber numberWithInt:20] :context];

    //    21	Totes	0	TOT	Totes
    [self CreatePersistedHUType:@"Totes" :@"TOT" :[NSNumber numberWithInt:21] :context];
    
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
    [self CreatePersistedHUType:@"Rack" :@"RCK" :[NSNumber numberWithInt:37] :context];
    
    //    38	Skid	1	SKD	Skid
    [self CreatePersistedHUType:@"Skid" :@"SKD" :[NSNumber numberWithInt:38] :context];
    
    //    39	Spool	0	SPL	Spool
    //    40	Tube	0	TBE	Tube
    //    41	Tank	0	TNK	Tank
    //    42	Unit	0	UNT	Unit
    //    43	Van Pack	0	VPK	Van Pack
    //    44	Wrapped	0	WRP	Wrapped
    //    46	Container	0	CNT	Container

    //    158	Slip Sheet	0	SLP	Slip Sheet
    [self CreatePersistedHUType:@"Slip Sheet" :@"SLP" :[NSNumber numberWithInt:158] :context];
    
    //    174	Trailer	0	TRU	Truck Trailer

    
    NSArray* accDesc = [[NSArray alloc] initWithObjects:@"COD Fee", @"Construction Site", @"Convention/Tradeshow", @"Inside Delivery",
                 
                 @"Inside Pickup", @"Excessive Length", @"Liftgate Delivery", @"Limited Access", @"Notify for PU or Delivery",
                 
                          @"Protect from Freezing", @"Residential Delivery", @"Residential Pickup", @"Sort Segregate", @"Single Shipment",nil];
    
    
    //Accessorial Codes
    NSArray* accCode = [[NSArray alloc]initWithObjects:@"COD", @"CONST", @"CONV", @"ISDEL", @"ISPU", @"LENGTH", @"LGDel", @"LIMACCESS", @"NOTIFY",
                
                        @"PROTECTFRE", @"ResDel", @"ResPick", @"SORTSEG", @"SS", nil];

    NSArray* accTypes = [[NSArray alloc]initWithObjects: [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2],[NSNumber numberWithInt:1], [NSNumber numberWithInt:3],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:4],[NSNumber numberWithInt:3],nil];

    for(int i=0; i < accDesc.count; i++)
    {
        [self CreatePersistedAccessorial: [accDesc objectAtIndex:i ] : [accCode objectAtIndex:i] : [accTypes objectAtIndex:i] : context];
    }
}

-(void) CreatePersistedAccessorial:(NSString*)accName :(NSString*)accCode :(NSNumber*)accTypeID :(NSManagedObjectContext*)context
{
    PersistedAccessorial *acc = [NSEntityDescription
                        insertNewObjectForEntityForName:@"PersistedAccessorial"
                        inManagedObjectContext:context];
    
    acc.accessorialName = accName;
    acc.accessorialCode = accCode;
    acc.accessorialTypeID = accTypeID;  
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
