//
//  DataModel.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/16/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

@synthesize currentUser = _currentUser;
@synthesize isLoaded = _isLoaded;

static DataModel *sharedObject = nil;

#pragma mark Singleton Implementation
+(DataModel*)sharedInstance
{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^ {
        
        sharedObject = [[super allocWithZone:NULL] init];
    });
    return sharedObject;
}

+(void)reset
{
    sharedObject = [[super allocWithZone:NULL] init];
}

@end
