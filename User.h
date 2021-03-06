//
//  User.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/19/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Enterprise, QuoteRequest, UserSettings;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * accountId;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * loginName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * selectedCompanyId;
@property (nonatomic, retain) NSNumber * selectedEnterpriseId;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSSet *enterprises;
@property (nonatomic, retain) NSSet *savedQuoteRequests;
@property (nonatomic, retain) UserSettings *userSettings;

- (Enterprise*)getCurrentEnterprise;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addEnterprisesObject:(Enterprise *)value;
- (void)removeEnterprisesObject:(Enterprise *)value;
- (void)addEnterprises:(NSSet *)values;
- (void)removeEnterprises:(NSSet *)values;

- (void)addSavedQuoteRequestsObject:(QuoteRequest *)value;
- (void)removeSavedQuoteRequestsObject:(QuoteRequest *)value;
- (void)addSavedQuoteRequests:(NSSet *)values;
- (void)removeSavedQuoteRequests:(NSSet *)values;

@end
