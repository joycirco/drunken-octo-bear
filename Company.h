//
//  Company.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/17/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Enterprise;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSNumber * companyId;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSSet *enterprise;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addEnterpriseObject:(Enterprise *)value;
- (void)removeEnterpriseObject:(Enterprise *)value;
- (void)addEnterprise:(NSSet *)values;
- (void)removeEnterprise:(NSSet *)values;

@end
