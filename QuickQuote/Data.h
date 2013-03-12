//
//  Data.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/8/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//
// In kind of a rush...don't judge
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Company.h"

@interface Data : NSObject
{
    // Instance variables
    // -Declare as usual. The alloc/shared instance
    //User *user;
    
    //NSArray *companies;
    //NSArray *enterprises;
}

// properties


// Hard coded Data
@property (nonatomic, retain) NSMutableArray *companies;
@property (nonatomic, retain) NSMutableArray *enterprises;

@property (nonatomic, retain) NSMutableArray *availableUsers;
@property (nonatomic, retain) NSMutableArray *selectedAccessorials;

@property (nonatomic, retain) User *user;
//@property (nonatomic, retain) Company *company;

// Required: A method to retrieve the shared instance
+ (Data *)sharedInstance;

// Shared Public methods
+(User *) getUser;
+(void) clearUser;

+(NSArray *) getCompanies;
+(NSArray *) getEnterprises;

// instance methods

@end
