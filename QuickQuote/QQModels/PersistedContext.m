//
//  PersistedContext.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/19/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "PersistedContext.h"
#import "AccessorialTypeQQ.h"
#import "AccessorialQQ.h"
#import "HandlingUnitTypeQQ.h"
#import "CarrierImage.h"


@implementation PersistedContext

@synthesize accessorials = _accessorials;
@synthesize accessorialTypes = _accessorialTypes;
@synthesize handlingUnitTypes = _handlingUnitTypes;
@synthesize carrierImages = _carrierImages;

-(id) init
{
    if (self = [super init])
    {
        _accessorialTypes = [[NSArray alloc] init];
        _accessorials = [[NSArray alloc] init];
        _handlingUnitTypes = [[NSArray alloc] init];
        _carrierImages = [[NSArray alloc] init];
        
        [self loadDataFromPersistedStore];
    }
    return self;
}

-(BOOL)loadDataFromPersistedStore
{
    
    NSMutableArray* accTypesArray;
    NSMutableArray* accArray;
    NSMutableArray* huTypesArray;
    NSMutableArray* ciArray;

    accTypesArray = [[NSMutableArray alloc] init];
    accArray = [[NSMutableArray alloc] init];
    huTypesArray = [[NSMutableArray alloc] init];
    ciArray = [[NSMutableArray alloc] init];
    
    /*********** AccessorialTypes ***************/
    NSString* plistPath1 = [[NSBundle mainBundle] pathForResource:@"AccessorialTypes" ofType:@"plist"];
    NSArray* objArray1 = [NSArray arrayWithContentsOfFile:plistPath1];
    
    for(id obj in objArray1)
    {
        NSDictionary* dict = [NSDictionary dictionaryWithDictionary:obj];
        
        AccessorialTypeQQ *acc = [[AccessorialTypeQQ alloc] init];
        acc.accessorialTypeID = [dict valueForKey:@"accessorialTypeID"];
        acc.accessorialTypeName = [dict valueForKey:@"accessorialTypeName"];
        
        [accTypesArray addObject:acc];
    }
    
    _accessorialTypes = [NSArray arrayWithArray:accTypesArray];
    
    
    /*********** Accessorials ***************/
    NSString* plistPath2 = [[NSBundle mainBundle] pathForResource:@"Accessorials" ofType:@"plist"];
    NSArray* objArray2 = [NSArray arrayWithContentsOfFile:plistPath2];
    
    for(id obj in objArray2)
    {
        NSDictionary* dict = [NSDictionary dictionaryWithDictionary:obj];
        
        AccessorialQQ *acc = [[AccessorialQQ alloc] init];
        acc.accessorialTypeID = [dict valueForKey:@"accessorialTypeID"];
        acc.accessorialName = [dict valueForKey:@"accessorialName"];
        acc.accessorialCode = [dict valueForKey:@"accessorialCode"];
        
        [accArray addObject:acc];
    }
    
    _accessorials = [NSArray arrayWithArray:accArray];

    
    /*********** HandlingUnitTypes ***************/
    NSString* plistPath3 = [[NSBundle mainBundle] pathForResource:@"HandlingUnitTypes" ofType:@"plist"];
    NSArray* objArray3 = [NSArray arrayWithContentsOfFile:plistPath3];
    
    for(id obj in objArray3)
    {
        NSDictionary* dict = [NSDictionary dictionaryWithDictionary:obj];
        
        HandlingUnitTypeQQ *hu = [[HandlingUnitTypeQQ alloc] init];
        hu.handlingUnitTypeCode = [dict valueForKey:@"handlingUnitTypeCode"];
        hu.handlingUnitTypeDescription = [dict valueForKey:@"handlingUnitTypeDescription"];
        hu.handlingUnitTypeID = [dict valueForKey:@"handlingUnitTypeID"];
        
        [huTypesArray addObject:hu];
    }
    
    _handlingUnitTypes = [NSArray arrayWithArray:huTypesArray];

    
    /*********** Accessorials ***************/
    NSString* plistPath4 = [[NSBundle mainBundle] pathForResource:@"CarrierImages" ofType:@"plist"];
    NSArray* objArray4 = [NSArray arrayWithContentsOfFile:plistPath4];
    
    for(id obj in objArray4)
    {
        NSDictionary* dict = [NSDictionary dictionaryWithDictionary:obj];

        CarrierImage* ci = [[CarrierImage alloc] init];
        ci.scac = [dict valueForKey:@"scac"];
        ci.imageName = [dict valueForKey:@"imageName"];
        //ci.carrierImage = [UIImage new];
        ci.carrierImage = [UIImage imageNamed: ci.imageName];
        
        [ciArray addObject:ci];
    }
    
    _carrierImages = [NSArray arrayWithArray:ciArray];
    return TRUE;
}

@end
