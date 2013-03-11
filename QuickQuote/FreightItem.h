//
//  FreightItem.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Accessorial, QuoteRequest;

@interface FreightItem : NSManagedObject

@property (nonatomic, retain) NSString * dimUOM;
@property (nonatomic, retain) NSDecimalNumber * freightClass;
@property (nonatomic, retain) NSString * freightDescription;
@property (nonatomic, retain) NSNumber * handlingUnits;
@property (nonatomic, retain) NSDecimalNumber * height;
@property (nonatomic, retain) NSNumber * isStackable;
@property (nonatomic, retain) NSDecimalNumber * length;
@property (nonatomic, retain) NSString * nmfc;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSDecimalNumber * weight;
@property (nonatomic, retain) NSString * weightUOM;
@property (nonatomic, retain) NSDecimalNumber * width;
@property (nonatomic, retain) NSNumber * handlingUnitTypeID;
@property (nonatomic, retain) NSSet *accessorials;
@property (nonatomic, retain) QuoteRequest *quoteRequest;
@end

@interface FreightItem (CoreDataGeneratedAccessors)

- (void)addAccessorialsObject:(Accessorial *)value;
- (void)removeAccessorialsObject:(Accessorial *)value;
- (void)addAccessorials:(NSSet *)values;
- (void)removeAccessorials:(NSSet *)values;

- (id) init;
- (id) initWithDefaults;

- (void)setDefaults;

@end
