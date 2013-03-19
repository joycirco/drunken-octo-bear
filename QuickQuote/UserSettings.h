//
//  UserSettings.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@class PersistedAccessorial, User;

@interface UserSettings : User

@property (nonatomic, retain) NSString * defaultDestinationPostalCode;
@property (nonatomic, retain) NSDecimalNumber * defaultFreightClass;
@property (nonatomic, retain) NSNumber * defaultHandlingUnitTypeID;
@property (nonatomic, retain) NSString * defaultOriginPostalCode;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *defaultAccessorials;
@end

@interface UserSettings (CoreDataGeneratedAccessors)

- (void)addDefaultAccessorialsObject:(PersistedAccessorial *)value;
- (void)removeDefaultAccessorialsObject:(PersistedAccessorial *)value;
- (void)addDefaultAccessorials:(NSSet *)values;
- (void)removeDefaultAccessorials:(NSSet *)values;

@end
