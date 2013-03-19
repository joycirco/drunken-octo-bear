//
//  PickerHelper.m
//  QuickQuote
//
//  Created by Darin Raffety on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "PickerHelper.h"
#import "HandlingUnitType.h"
#import "PickerItem.h"

@interface PickerHelper ()
{
    
}

@end

@implementation PickerHelper

@synthesize freightClasses = _freightClasses;
@synthesize handlingUnitTypes = _handlingUnitTypes;
@synthesize managedObjectContext = _managedObjectContext;


-(id)initWithContext:(NSManagedObjectContext*)context
{
    if(self = [super init])
    {
        _managedObjectContext = context;
    }

    return self;
}

-(void)initPickerItems
{
    _handlingUnitTypes = [[NSMutableArray alloc]init];
    
    // get handling unit types from data store
    NSError* error;
    // Test listing all QuoteRequests from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HandlingUnitType"
                                              inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"handlingUnitTypeDescription" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (HandlingUnitType *h in fetchedObjects)
    {
        [_handlingUnitTypes addObject:[[PickerItem alloc] initWithTitleObject:h.handlingUnitTypeDescription : h]];
    }
    
    _freightClasses = [[NSMutableArray alloc] init];
    
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"50" :[NSDecimalNumber numberWithFloat:50.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"55" :[NSDecimalNumber numberWithFloat:55.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"60" :[NSDecimalNumber numberWithFloat:60.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"65" :[NSDecimalNumber numberWithFloat:65.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"70" :[NSDecimalNumber numberWithFloat:70.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"77.5" :[NSDecimalNumber numberWithFloat:77.5]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"85" :[NSDecimalNumber numberWithFloat:85.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"92.5" :[NSDecimalNumber numberWithFloat:92.5]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"100" :[NSDecimalNumber numberWithFloat:100.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"110" :[NSDecimalNumber numberWithFloat:110.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"125" :[NSDecimalNumber numberWithFloat:125.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"150" :[NSDecimalNumber numberWithFloat:150.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"175" :[NSDecimalNumber numberWithFloat:175.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"200" :[NSDecimalNumber numberWithFloat:200.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"250" :[NSDecimalNumber numberWithFloat:250.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"300" :[NSDecimalNumber numberWithFloat:300.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"400" :[NSDecimalNumber numberWithFloat:400.0]]];
    [_freightClasses addObject:[[PickerItem alloc] initWithTitleObject:@"500" :[NSDecimalNumber numberWithFloat:500.0]]];
}

- (NSString*)getHandlingUnitName:(NSNumber*)htID
{
    NSString* ret = nil;
    for(PickerItem* p in _handlingUnitTypes)
    {
        if ( [((HandlingUnitType*)p.itemObject).handlingUnitTypeID isEqualToNumber:htID])
        {
            ret = p.itemTitle;
            break;
        }
    }
    
    return ret;
}

- (NSNumber*)getHandlingUnitTypeID:(NSString*)htName
{
    NSNumber* ret = nil;
    for(PickerItem* p in _handlingUnitTypes)
    {
        if ( [p.itemTitle isEqualToString:htName])
        {
            ret = ((HandlingUnitType*)p.itemObject).handlingUnitTypeID;
            break;
        }
    }
    
    return ret;
}


@end
