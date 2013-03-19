//
//  QuoteRequest.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/19/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Accessorial, Credentials, FreightItem, User;

@interface QuoteRequest : NSManagedObject

@property (nonatomic, retain) NSString * destinationPostalCode;
@property (nonatomic, retain) NSString * originPostalCode;
@property (nonatomic, retain) NSDate * pickupDateTime;
@property (nonatomic, retain) NSString * storeLocationCode;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSDate * deliveryDateTime;
@property (nonatomic, retain) NSSet *accessorials;
@property (nonatomic, retain) Credentials *credentials;
@property (nonatomic, retain) NSSet *freightItems;
@property (nonatomic, retain) User *user;

- (id) init;
- (id) initWithDefaults;
- (void) setDefaults;

@end

@interface QuoteRequest (CoreDataGeneratedAccessors)

- (void)addAccessorialsObject:(Accessorial *)value;
- (void)removeAccessorialsObject:(Accessorial *)value;
- (void)addAccessorials:(NSSet *)values;
- (void)removeAccessorials:(NSSet *)values;

- (void)addFreightItemsObject:(FreightItem *)value;
- (void)removeFreightItemsObject:(FreightItem *)value;
- (void)addFreightItems:(NSSet *)values;
- (void)removeFreightItems:(NSSet *)values;

@end
