//
//  Credentials.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company, QuoteRequest;

@interface Credentials : NSManagedObject

@property (nonatomic, retain) NSString * accountId;
@property (nonatomic, retain) NSString * loginName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) QuoteRequest *quoteRequest;
@property (nonatomic, retain) Company *company;

@end
