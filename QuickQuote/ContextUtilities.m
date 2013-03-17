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
#import "User.h"
#import "Enterprise.h"
#import "Company.h"


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
    
    
    [self generateEnterpriseData:context];
    [self generateCompanyData:context];
    [self generateUserData:context];
    // need to associate company and enterprises with users now...
}

-(void)generateEnterpriseData:(NSManagedObjectContext*)context
{
    NSArray *enterpriseIds = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0],
                              [NSNumber numberWithInt:1], nil];
    NSArray *enterprises = [[NSArray alloc] initWithObjects:@"eShipping", @"Exchange", nil];
    for(int i=0; i <enterpriseIds.count; i++)
    {
        [self createPersistedEnterprise:[enterpriseIds objectAtIndex:i] :
         [enterprises objectAtIndex:i] : context];
    }
}

-(void)createPersistedEnterprise:(NSNumber*)enterpriseId : (NSString*)
                 enterpriseName :(NSManagedObjectContext*)context
{
    Enterprise *enterprise = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Enterprise"
                              inManagedObjectContext:context];
    
    enterprise.enterpriseId = enterpriseId;
    enterprise.enterpriseName = enterpriseName;
    enterprise.timeStamp = [NSDate date];
}

-(void)generateCompanyData:(NSManagedObjectContext*)context
{
    // these might need to change
    NSArray *companyIds = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0],
                           [NSNumber numberWithInt:1], [NSNumber numberWithInt:2],
                           [NSNumber numberWithInt:3], [NSNumber numberWithInt:4],
                           [NSNumber numberWithInt:5], nil];
    NSArray *companyNames = [[NSArray alloc] initWithObjects:@"Roberts Auto Plaza",
                             @"Above Par Mortgage", @"Premier Mortgage Funding",
                             @"Triumph", @"Wier", @"Big Alligators", nil];
    for(int i=0; i<companyIds.count; i++)
    {
        [self createPersistedCompany:[companyIds objectAtIndex:i] :
         [companyNames objectAtIndex:i] :context];
    }
    
}

-(void)createPersistedCompany:(NSNumber*)companyId : (NSString*) companyName :
(NSManagedObjectContext*)context
{
    Company *company = [NSEntityDescription
                           insertNewObjectForEntityForName:@"Company"
                           inManagedObjectContext:context];
    company.companyId = companyId;
    company.companyName = companyName;
    company.timeStamp = [NSDate date];
}

-(void)generateUserData:(NSManagedObjectContext*)context
{
    // these might need to be real numbers soon...
    NSArray *accountIds = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0],
                           [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], nil];
    NSArray *loginNames = [[NSArray alloc] initWithObjects:@"steven", @"darin", @"joy", nil];
    NSArray *passwords = [[NSArray alloc] initWithObjects:@"steven", @"darin", @"joy", nil];
    NSArray *emails = [[NSArray alloc] initWithObjects:@"steven.tuckness@engagedtechnologies.com",
                      @"darin.raffety@engagedtechnologies.com", @"joy.circo@engagedtechnologies.com", nil];
    
    for(int i=0; i < accountIds.count; i++)
    {
        [self createPersistedUser:[accountIds objectAtIndex:i]: [loginNames objectAtIndex:i] :
         [passwords objectAtIndex:i] : [emails objectAtIndex:i] : context];
    }
   
}

-(void)createPersistedUser:(NSNumber*)accountId : (NSString*)loginName :
    (NSString*)password : (NSString*)email : (NSManagedObjectContext*)context;
{
    User *user = [NSEntityDescription
                   insertNewObjectForEntityForName:@"User"
                   inManagedObjectContext:context];
    
    user.accountId = accountId;
    user.loginName = loginName;
    user.password = password;
    user.email = email;
    user.timestamp = [NSDate date];
    [self addEnterprisesToUser:user :context];
    [self addCompaniesToUserEnterprises:user :context];
}

-(void)addEnterprisesToUser:(User*)user : (NSManagedObjectContext*)context
{
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Could not save: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Enterprise"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Enterprise *enterprise in fetchedObjects)
    {
        if ([self shouldAddEnterpriseToUser:user :enterprise])
            [self addEnterpriseToUser:user :enterprise :context];
    }
}

-(BOOL)shouldAddEnterpriseToUser:(User*)user : (Enterprise*)enterprise
{
    if ([user.loginName isEqualToString:@"steven"] &&
        [enterprise.enterpriseName isEqualToString:@"eShipping"])
    {
        return TRUE;
    }
    else if ([user.loginName isEqualToString:@"darin"] &&
        [enterprise.enterpriseName isEqualToString:@"Exchange"])
    {
        return TRUE;
    }
    else if ([user.loginName isEqualToString:@"joy"] &&
        ([enterprise.enterpriseName isEqualToString:@"eShipping"] ||
        [enterprise.enterpriseName isEqualToString:@"Exchange"]))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

-(void)addEnterpriseToUser:(User*)user : (Enterprise*)enterprise :
    (NSManagedObjectContext*)context
{
    [user addEnterprisesObject:enterprise];
}


-(void)addCompaniesToUserEnterprises:(User*)user :(NSManagedObjectContext*)context
{
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Could not save: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Company"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (Company *company in fetchedObjects)
    {
        for (Enterprise *enterprise in user.enterprises.allObjects)
        {
            if ([self shouldAddCompanyToEnterprise:user : enterprise : company :context])
            {
                [enterprise addCompaniesObject:company];
            }
        }
    }
}

-(BOOL)shouldAddCompanyToEnterprise:(User*)user : (Enterprise*)enterprise :
    (Company*)company : (NSManagedObjectContext*)context
{
    if ([user.loginName isEqualToString:@"steven"])
    {
        if ([self shouldAddCompanyIfStevenAndMatches:enterprise :company :context])
            [enterprise addCompaniesObject:company];
    }
    else if([user.loginName isEqualToString:@"darin"])
    {
        if ([self shouldAddCompanyIfDarinAndMatches:enterprise :company :context])
            [enterprise addCompaniesObject:company];
    }
    else if([user.loginName isEqualToString:@"joy"])
    {
        if ([self shouldAddCompanyIfJoyAndMatches:enterprise :company :context])
            [enterprise addCompaniesObject:company];
    }
    return FALSE;
}

-(BOOL)shouldAddCompanyIfStevenAndMatches : (Enterprise*)enterprise :
    (Company*)company : (NSManagedObjectContext*)context
{
    if ([enterprise.enterpriseName isEqualToString:@"eShipping"] &&
        [company.companyName isEqualToString:@"Roberts Auto Plaza"])
    {
        return TRUE;
    }
    if ([enterprise.enterpriseName isEqualToString:@"eShipping"] &&
        [company.companyName isEqualToString:@"Above Par Mortgage"])
    {
        return TRUE;
    }
    if ([enterprise.enterpriseName isEqualToString:@"eShipping"] &&
        [company.companyName isEqualToString:@"Premier Mortgage Funding"])
    {
        return TRUE;
    }
    return FALSE;  
}

-(BOOL)shouldAddCompanyIfDarinAndMatches : (Enterprise*)enterprise :
(Company*)company : (NSManagedObjectContext*)contex
{
    if ([enterprise.enterpriseName isEqualToString:@"eShipping"] &&
        [company.companyName isEqualToString:@"Premier Mortgage Funding"])
    {
        return TRUE;
    }
    if ([enterprise.enterpriseName isEqualToString:@"eShipping"] &&
        [company.companyName isEqualToString:@"Above Par Mortgage"])
    {
        return TRUE;
    }
    if ([enterprise.enterpriseName isEqualToString:@"eShipping"] &&
        [company.companyName isEqualToString:@"Roberts Auto Plaze"])
    {
        return TRUE;
    }
    return FALSE;
}

-(BOOL)shouldAddCompanyIfJoyAndMatches : (Enterprise*)enterprise :
(Company*)company : (NSManagedObjectContext*)contex
{
    if ([enterprise.enterpriseName isEqualToString:@"eShipping"] &&
        [company.companyName isEqualToString:@"Above Par Mortgage"])
    {
        return TRUE;
    }
    if ([enterprise.enterpriseName isEqualToString:@"eShipping"] &&
        [company.companyName isEqualToString:@"Roberts Auto Plaze"])
    {
        return TRUE;
    }
    if ([enterprise.enterpriseName isEqualToString:@"eShipping"] &&
        [company.companyName isEqualToString:@"Premier Mortgage Funding"])
    {
        return TRUE;
    }
    if ([enterprise.enterpriseName isEqualToString:@"Exchange"] &&
        [company.companyName isEqualToString:@"Triumph"])
    {
        return TRUE;
    }
    if ([enterprise.enterpriseName isEqualToString:@"Exchange"] &&
        [company.companyName isEqualToString:@"Wier"])
    {
        return TRUE;
    }
    if ([enterprise.enterpriseName isEqualToString:@"Exchange"] &&
        [company.companyName isEqualToString:@"Big Alligators"])
    {
        return TRUE;
    }
    return FALSE;
}


@end
