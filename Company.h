//
//  Company.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Credentials, Enterprise;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSNumber * companyId;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSSet *enterprise;
@property (nonatomic, retain) Credentials *credentials;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addEnterpriseObject:(Enterprise *)value;
- (void)removeEnterpriseObject:(Enterprise *)value;
- (void)addEnterprise:(NSSet *)values;
- (void)removeEnterprise:(NSSet *)values;

@end
