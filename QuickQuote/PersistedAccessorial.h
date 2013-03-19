//
//  PersistedAccessorial.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserSettings;

@interface PersistedAccessorial : NSManagedObject

@property (nonatomic, retain) NSString * accessorialCode;
@property (nonatomic, retain) NSString * accessorialName;
@property (nonatomic, retain) NSNumber * accessorialTypeID;
@property (nonatomic, retain) NSSet *userSettings;
@end

@interface PersistedAccessorial (CoreDataGeneratedAccessors)

- (void)addUserSettingsObject:(UserSettings *)value;
- (void)removeUserSettingsObject:(UserSettings *)value;
- (void)addUserSettings:(NSSet *)values;
- (void)removeUserSettings:(NSSet *)values;

@end
