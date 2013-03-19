//
//  Enterprise.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/19/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company, User;

@interface Enterprise : NSManagedObject

@property (nonatomic, retain) NSNumber * enterpriseId;
@property (nonatomic, retain) NSString * enterpriseName;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSSet *companies;
@property (nonatomic, retain) NSSet *user;

- (Company*)getCurrentCompany;

@end

@interface Enterprise (CoreDataGeneratedAccessors)

- (void)addCompaniesObject:(Company *)value;
- (void)removeCompaniesObject:(Company *)value;
- (void)addCompanies:(NSSet *)values;
- (void)removeCompanies:(NSSet *)values;

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet *)values;
- (void)removeUser:(NSSet *)values;

@end
