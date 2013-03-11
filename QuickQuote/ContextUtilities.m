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
    
    
    
    HandlingUnitType *pallet40 = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"HandlingUnitType"
                                   inManagedObjectContext:context];
    
    pallet40.handlingUnitTypeID = [NSNumber numberWithInt:1];
    pallet40.handlingUnitTypeCode = @"PLT";
    pallet40.handlingUnitTypeDescription = @"Pallets (48 x 40)";

    
    HandlingUnitType *pallet48 = [NSEntityDescription
                                insertNewObjectForEntityForName:@"HandlingUnitType"
                                inManagedObjectContext:context];
    
    pallet48.handlingUnitTypeID = [NSNumber numberWithInt:2];
    pallet48.handlingUnitTypeCode = @"PLT";
    pallet48.handlingUnitTypeDescription = @"Pallets (48 x 48)";

    
    HandlingUnitType *pallet = [NSEntityDescription
                                insertNewObjectForEntityForName:@"HandlingUnitType"
                                inManagedObjectContext:context];
    
    pallet.handlingUnitTypeID = [NSNumber numberWithInt:4];
    pallet.handlingUnitTypeCode = @"PLT";
    pallet.handlingUnitTypeDescription = @"Pallets (Enter Dimensions)";

    
    HandlingUnitType *bags = [NSEntityDescription
                                insertNewObjectForEntityForName:@"HandlingUnitType"
                                inManagedObjectContext:context];
    
    bags.handlingUnitTypeID = [NSNumber numberWithInt:5];
    bags.handlingUnitTypeCode = @"BAG";
    bags.handlingUnitTypeDescription = @"Bags";

    HandlingUnitType *box = [NSEntityDescription
                              insertNewObjectForEntityForName:@"HandlingUnitType"
                              inManagedObjectContext:context];
    
    box.handlingUnitTypeID = [NSNumber numberWithInt:7];
    box.handlingUnitTypeCode = @"BOX";
    box.handlingUnitTypeDescription = @"Boxes";

    HandlingUnitType *oth = [NSEntityDescription
                             insertNewObjectForEntityForName:@"HandlingUnitType"
                             inManagedObjectContext:context];
    
    oth.handlingUnitTypeID = [NSNumber numberWithInt:34];
    oth.handlingUnitTypeCode = @"OTH";
    oth.handlingUnitTypeDescription = @"Other";
    
    /*
    1	Pallets (48 x 40)	1	PLT	Pallets (48 x 40)
    2	Pallets (48 x 48)	1	PLT	Pallets (48 x 48)
    4	Pallets (Enter Dimensions)	1	PLT	Pallets (Enter Dimensions)    
    5	Bags	0	BAG	Bags
    7	Boxes	0	BOX	Boxes
    8	Bunch/Bundle	0	BDL	Bundles
    9	Blister Pack	0	BME	Blister Pack
    10	Coils	0	COL	Coils
    11	Crates	0	CRT	Crates
    12	Cylinders	0	CYL	Cylinders
    13	Drums	0	DRM	Drums
    14	Pails	0	PAL	Pails
    15	Reels	0	REL	Reels
    16	Rolls	0	ROL	Rolls
    17	Pipes/Tubes	0	TBE	Pipes/Tubes
    18	Cartons	0	CTN	Cartons
    19	Cases	0	CAS	Cases
    20	Pieces	0	PCS	Pieces
    21	Totes	0	TOT	Totes
    23	Barrel	0	BBL	Barrel
    24	Bale	0	BAL	Bale
    27	Cabinet	0	CAB	Cabinet
    28	Can	0	CAN	Can
    29	Bottle	0	BOT	Bottle
    30	Carboy	0	CBY	Carboy
    32	Cask	0	CSK	Cask
    33	Loose	0	LSE	Loose
    34	Other	0	NULL	Other
    35	Package	0	PKG	Package
    36	Pipe Line	0	NULL	Pipe Line
    37	Rack	0	RCK	Rack
    38	Skid	1	SKD	Skid
    39	Spool	0	SPL	Spool
    40	Tube	0	TBE	Tube
    41	Tank	0	TNK	Tank
    42	Unit	0	UNT	Unit
    43	Van Pack	0	VPK	Van Pack
    44	Wrapped	0	WRP	Wrapped
    46	Container	0	CNT	Container
    158	Slip Sheet	0	SLP	Slip Sheet,  Shipping containers utilizing slip sheets, which are cardboard platforms used to hold product for storage or transportation
        174	Trailer	0	TRU	Truck Trailer*/
    
}

@end
