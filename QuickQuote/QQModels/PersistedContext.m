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


@implementation PersistedContext

@synthesize accessorials = _accessorials;
@synthesize accessorialTypes = _accessorialTypes;
@synthesize handlingUnitTypes = _handlingUnitTypes;

-(id) init
{
    if (self = [super init])
    {
        _accessorialTypes = [[NSArray alloc] init];
        _accessorials = [[NSArray alloc] init];
        _handlingUnitTypes = [[NSArray alloc] init];
        
        [self loadDataFromPersistedStore];
    }
    return self;
}

-(BOOL)loadDataFromPersistedStore
{
    
    NSMutableArray* accTypesArray;
    NSMutableArray* accArray;
    NSMutableArray* huTypesArray;

    accTypesArray = [[NSMutableArray alloc] init];
    accArray = [[NSMutableArray alloc] init];
    huTypesArray = [[NSMutableArray alloc] init];
    
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
    
    return TRUE;
}

@end
