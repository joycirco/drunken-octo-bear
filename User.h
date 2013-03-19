//
//  User.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Enterprise;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * accountId;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * loginName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * selectedCompanyId;
@property (nonatomic, retain) NSNumber * selectedEnterpriseId;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSSet *enterprises;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addEnterprisesObject:(Enterprise *)value;
- (void)removeEnterprisesObject:(Enterprise *)value;
- (void)addEnterprises:(NSSet *)values;
- (void)removeEnterprises:(NSSet *)values;

- (Enterprise*)getCurrentEnterprise;

@end
