//
//  Accessorial.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/12/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FreightItem, QuoteRequest;

@interface Accessorial : NSManagedObject

@property (nonatomic, retain) NSString * accessorialCode;
@property (nonatomic, retain) NSString * accessorialName;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSNumber * accessorialTypeID;
@property (nonatomic, retain) FreightItem *freightItem;
@property (nonatomic, retain) QuoteRequest *quoteRequest;

@end
