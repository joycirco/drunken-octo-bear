//
//  PickerHelper.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PickerHelper : NSObject

@property (retain, nonatomic) NSMutableArray* freightClasses;
@property (retain, nonatomic) NSMutableArray* handlingUnitTypes;
@property (retain, nonatomic) NSMutableArray* sortByOptions;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (NSString*)getHandlingUnitName:(NSNumber*)htID;
- (NSNumber*)getHandlingUnitTypeID:(NSString*)htName;

-(void)initPickerItems;

-(id)initWithContext:(NSManagedObjectContext*)context;

@end
