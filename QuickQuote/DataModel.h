//
//  DataModel.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/16/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface DataModel : NSObject

@property (nonatomic, retain) User *currentUser;
@property (nonatomic, assign) BOOL isLoaded;

+ (DataModel*)sharedInstance;
+ (void)reset;

@end
