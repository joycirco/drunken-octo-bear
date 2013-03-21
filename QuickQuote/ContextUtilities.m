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
#import "Credentials.h"
#import "PersistedAccessorial.h"
#import "PersistedContext.h"
#import "AccessorialTypeQQ.h"
#import "AccessorialQQ.h"
#import "HandlingUnitTypeQQ.h"
#import "UserSettings.h"

@interface ContextUtilities()
{
}

-(void) CreatePersistedAccessorial:(NSString*)accName :(NSString*)accCode :(NSNumber*)accTypeID :(NSManagedObjectContext*)context;
-(void) CreatePersistedHUType:(NSString*)hutDesc :(NSString*)hutCode :(NSNumber*)huType :(NSManagedObjectContext*)context;

@end

@implementation ContextUtilities

-(void) generateApplicationData:(NSManagedObjectContext*)context :(PersistedContext*)persistedContext
{
    [self generateAccessorialTypes:context:persistedContext];
    [self generateAccessorials:context: persistedContext];
    [self generateCredentials:context];
    [self generateHUTypes:context:persistedContext];
    
    // THE FOLLOWING CALLS MUST EXECUTE IN THIS ORDER!!
    [self generateEnterpriseData:context];   // 1
    [self generateCompanyData:context];      // 2
    [self generateUserData:context];         // 3
    [self addAnonymousUser:context];         // 4
    
    
    // delete all existing quote requests
    [self deleteAllObjects:@"QuoteRequest" :context];
}

-(void)generateAccessorialTypes : (NSManagedObjectContext*)context :(PersistedContext*)persistedContext
{
    // get accessorial type from data store
    // if count of items is not equal to persistedStore, then re-add them
    NSString* entityName = @"AccessorialType";
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray* arr = [context executeFetchRequest:fetchRequest error:&error];
    
    if (arr == nil || arr.count == 0 || arr.count != persistedContext.accessorialTypes.count)
    {
        if (arr != nil)
        {
            [self deleteAllObjects:entityName :context];
        }
            
        for(AccessorialTypeQQ* atq in persistedContext.accessorialTypes)
        {
            AccessorialType *act = [NSEntityDescription
                                     insertNewObjectForEntityForName:entityName
                                     inManagedObjectContext:context];
            
            act.accessorialTypeID = atq.accessorialTypeID;
            act.accessorialTypeName = atq.accessorialTypeName;
            
        }
    }
}

-(void)generateAccessorials : (NSManagedObjectContext*)context :(PersistedContext*)persistedContext
{
    // get Persisted Accessorials from data store
    // if count of items is not equal to persistedStore, then re-add them
    NSString* entityName = @"PersistedAccessorial";
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray* arr = [context executeFetchRequest:fetchRequest error:&error];
    
    if (arr == nil || arr.count == 0 || arr.count != persistedContext.accessorials.count)
    {
        if (arr != nil)
        {
            [self deleteAllObjects:entityName :context];
        }
    
        for(AccessorialQQ* acc in persistedContext.accessorials)
        {
            [self CreatePersistedAccessorial: acc.accessorialName : acc.accessorialCode: acc.accessorialTypeID : context];
        }
    }
}

-(void) generateHUTypes : (NSManagedObjectContext*)context :(PersistedContext*)persistedContext
{
    // get Persisted Accessorials from data store
    // if count of items is not equal to persistedStore, then re-add them
    NSString* entityName = @"HandlingUnitType";
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray* arr = [context executeFetchRequest:fetchRequest error:&error];
    
    if (arr == nil || arr.count == 0 || arr.count != persistedContext.handlingUnitTypes.count)
    {
        if (arr != nil)
        {
            [self deleteAllObjects:entityName :context];
        }
        
    
        for (HandlingUnitTypeQQ* hq in persistedContext.handlingUnitTypes)
        {
            [self CreatePersistedHUType:hq.handlingUnitTypeDescription : hq.handlingUnitTypeCode : hq.handlingUnitTypeID :context];
        }
    }
    /*
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
    
    //    174	Trailer	0	TRU	Truck Trailer*/
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

-(void)generateCredentials:(NSManagedObjectContext*)context
{
    // we need some credentials to assign to companies
    //testbot/anonymous, @"Roberts Auto Plaza",
    //@"Above Par Mortgage", @"Premier Mortgage Funding",
    //@"Triumph", @"Wier", @"Faultless Starch;
    
    // get Persisted Credential from data store
    // if count of items is not equal to persistedStore, then re-add them
    NSString* entityName = @"Credentials";
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray* arr = [context executeFetchRequest:fetchRequest error:&error];
    
    if (arr == nil || arr.count == 0 || arr.count != 7)
    {
        if (arr != nil)
        {
            [self deleteAllObjects:entityName :context];
        }

        
        Credentials *cred = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Credentials"
                             inManagedObjectContext:context];
        
        cred.loginName = @"testbot";
        cred.password = @"supersecret468";
        cred.accountId = @"32700120";
        cred.token = @"268E46CD13B3A0B7CCC6D02CEF8DC92215C4F459";
        
        
        NSArray *accountIds = [[NSArray alloc] initWithObjects:@"10100107", @"10100110", @"12500124",
                               @"10100457", @"10800410", @"32700120", nil];
        NSArray *loginNames = [[NSArray alloc] initWithObjects:@"10100107", @"10100110", @"12500124",
                               @"10100457", @"10800410", @"32700120", nil];
        NSArray *passwords = [[NSArray alloc] initWithObjects:@"10100107_103", @"10100110_106", @"12500124_2869",
                              @"10100457_444", @"10800410_6141", @"32700120_5471", nil];
        NSArray *tokens = [[NSArray alloc] initWithObjects:@"39A2C6262E6EB265C029A48D1936E9540CC5095A", @"9311FFDCD20E6FD70F2CC7C652C99FAF04EBFF4E",
                           @"D8EF5D005310039ED949705502FC5E5AF8493B74", @"40807DBD302CF187046C9166584366188BF2C031", @"0B676787B8CFDB9A8C52D409F54EC3D29DC2A772",
                           @"797C6E94F2B5CE4CB0988F46BE3F415C835676FB", nil];
        
        for (int i=0; i<accountIds.count; i++)
        {
            [self createPersistedCredentials:[accountIds objectAtIndex:i] :[loginNames objectAtIndex:i] :
             [passwords objectAtIndex:i] :[tokens objectAtIndex:i] : context];
        }
    }
}

-(void)createPersistedCredentials:(NSString*)accountId : (NSString*)loginName :
(NSString*)password : (NSString*)token :(NSManagedObjectContext*)context
{
    Credentials *credentials = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Credentials"
                                inManagedObjectContext:context];
    
    credentials.accountId = accountId;
    credentials.loginName = loginName;
    credentials.password = password;
    credentials.token = token;
}

-(void)generateEnterpriseData:(NSManagedObjectContext*)context
{
    // get Enterprises from data store
    // if count of items is not equal to 2, then re-add them
    NSString* entityName = @"Enterprise";
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray* arr = [context executeFetchRequest:fetchRequest error:&error];
    
    if (arr == nil || arr.count == 0 || arr.count != 2)
    {
        if (arr != nil)
        {
            [self deleteAllObjects:entityName :context];
        }

        NSArray *enterpriseIds = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0],
                                  [NSNumber numberWithInt:1], nil];
        NSArray *enterprises = [[NSArray alloc] initWithObjects:@"eShipping", @"Exchange", nil];
        for(int i=0; i <enterpriseIds.count; i++)
        {
            [self createPersistedEnterprise:[enterpriseIds objectAtIndex:i] :
             [enterprises objectAtIndex:i] : context];
        }
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
    // get Companies from data store
    // if count of items is not equal to 6, then re-add them
    NSString* entityName = @"Company";
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray* arr = [context executeFetchRequest:fetchRequest error:&error];
    
    if (arr == nil || arr.count == 0 || arr.count != 6)
    {
        if (arr != nil)
        {
            [self deleteAllObjects:entityName :context];
        }

        // these might need to change
        NSArray *companyIds = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0],
                               [NSNumber numberWithInt:1], [NSNumber numberWithInt:2],
                               [NSNumber numberWithInt:3], [NSNumber numberWithInt:4],
                               [NSNumber numberWithInt:5], nil];
        NSArray *companyNames = [[NSArray alloc] initWithObjects:@"Roberts Auto Plaza",
                                 @"Above Par Mortgage", @"Premier Mortgage Funding",
                                 @"Triumph", @"Wier", @"Faultless Starch", nil];
        
        // locate proper credentials

        for(int i=0; i<companyIds.count; i++)
        {
            [self createPersistedCompany:[companyIds objectAtIndex:i] :
             [companyNames objectAtIndex:i] : [self getCredentials:[NSNumber numberWithInt:i] : context] : context];
        }

    }
}

-(Credentials*)getCredentials : (NSNumber*) companyRow : (NSManagedObjectContext*)context
{
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Could not save: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Credentials"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    Credentials *creds = [fetchedObjects objectAtIndex:[companyRow intValue] + 1]; // +1 because the default credentials are already there
    return creds;
}

-(void)createPersistedCompany:(NSNumber*)companyId : (NSString*) companyName : (Credentials*)credentials :
(NSManagedObjectContext*)context
{
    Company *company = [NSEntityDescription
                           insertNewObjectForEntityForName:@"Company"
                           inManagedObjectContext:context];
    company.companyId = companyId;
    company.companyName = companyName;
    company.timeStamp = [NSDate date];
    company.credentials = credentials;
}

-(void)generateUserData:(NSManagedObjectContext*)context
{
    // get User from data store
    // if count of items is not equal to 3, then re-add them
    NSString* entityName = @"User";
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray* arr = [context executeFetchRequest:fetchRequest error:&error];
    
    if (arr == nil || arr.count == 0 || arr.count != 3)
    {
        if (arr != nil)
        {
            [self deleteAllObjects:entityName :context];
        }

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
    [self createDefaultUserSettingsForUser:user :context];
    [self addEnterprisesToUser:user :context];
    [self addCompaniesToUserEnterprises:user :context];
}

-(void)createDefaultUserSettingsForUser:(User*) user :(NSManagedObjectContext*) context
{
    UserSettings* userSettings = [NSEntityDescription
                              insertNewObjectForEntityForName:@"UserSettings"
                              inManagedObjectContext:context];

    userSettings.defaultOriginPostalCode = @"50801";
    userSettings.defaultDestinationPostalCode = @"66048";
    userSettings.defaultFreightClass = [NSDecimalNumber decimalNumberWithString:@"50.0"];
    userSettings.defaultHandlingUnitTypeID = [NSNumber numberWithInt:1];
    
    // add all of the accessorials to the defaults
    
    NSError* error;
    // Test listing all QuoteRequests from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PersistedAccessorial"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [userSettings addDefaultAccessorials:[NSSet setWithArray:fetchedObjects]];
    
    user.userSettings = userSettings;
}


-(void)addAnonymousUser:context
{
    // get User from data store
    // if count of items is not equal to 3, then re-add them
    NSString* entityName = @"User";
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set predicate to only accessorials for this _quoteRequest
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"accountId=%@", [NSNumber numberWithInt:3]];
    [fetchRequest setPredicate:predicate];
    
    NSArray* arr = [context executeFetchRequest:fetchRequest error:&error];
    
    if (arr == nil || arr.count == 0)
    {
        
        User *user = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        
        user.accountId = [NSNumber numberWithInt:3];
        user.loginName = @"anonymous";
        user.password = @"anonymous";
        user.email = @"anonymous@email.com";
        user.timestamp = [NSDate date];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Could not save: %@", [error localizedDescription]);
        }
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Enterprise"
                                                  inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        Enterprise *e = fetchedObjects[1];
        [user addEnterprisesObject:e]; // add eShipping
        user.selectedEnterpriseId = e.enterpriseId;

        NSArray *companies = e.companies.allObjects;
        Company *c = companies[0];
        user.selectedCompanyId = c.companyId;
    }
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
        [company.companyName isEqualToString:@"Faultless Starch"])
    {
        return TRUE;
    }
    return FALSE;
}

- (void) deleteAllObjects: (NSString *) entityDescription :(NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items)
    {
    	[context deleteObject:managedObject];
    	NSLog(@"%@ object deleted",entityDescription);
    }
    
    if (![context save:&error]) {
    	NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
    
}

@end
