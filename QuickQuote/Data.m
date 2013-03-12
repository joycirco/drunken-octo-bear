//
//  Data.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/8/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "Data.h"

@implementation Data

//@synthesize user;

//@synthesize selectedCompany;
//@synthesize selectedEnterprise;

// hard coded
@synthesize companies;
@synthesize enterprises;

@synthesize user;
@synthesize availableUsers;

static Data *sharedObject = nil;

#pragma mark Singleton Implementation
+ (Data*)sharedInstance
{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        
        sharedObject = [[super allocWithZone:NULL] init];
        sharedObject.user = [User alloc];
        
        sharedObject.availableUsers = [self getUsers];

        //sharedObject.companies = [[NSArray alloc] initWithObjects:@"Roberts Auto Plaza",
        //                          @"Above Par Mortgage", @"Premier Mortgage Funding", @"Triumph", @"Weir", nil];
        //sharedObject.enterprises = [[NSArray alloc] initWithObjects:@"eShipping", @"Exchange", nil];
    });
    return sharedObject;
}

+(NSMutableArray*) getUsers
{
    NSMutableArray *users = [[NSMutableArray alloc] init];

    User *user1 = [[User alloc] init];
    user1.loginName = @"steven";
    user1.password = @"steven";
    user1.email = @"steven.tuckness@engagedtechnologies.com";
    user1.selectedCompany = @"";
    user1.selectedEnterprise = @"";
    user1.companies = [self getUser1Companies];
    user1.enterprises = [self getUser1Enterprises];
    [users addObject:user1];
    
    User *user2 = [[User alloc] init];
    user2.loginName = @"darin";
    user2.password = @"darin";
    user2.email = @"darin.raffety@engagedtechnologies.com";
    user2.selectedCompany = @"";
    user2.selectedEnterprise = @"";
    user2.companies = [self getUser2Companies];
    user2.enterprises = [self getUser2Enterprises];
    [users addObject:user2];
    
    User *user3 = [[User alloc] init];
    user3.loginName = @"joy";
    user3.password = @"joy";
    user3.email = @"joy.circo@engagedtechnologies.com";
    user3.selectedCompany = @"";
    user3.selectedEnterprise = @"";
    user3.companies = [self getUser3Companies];
    user3.enterprises = [self getUser3Enterprises];
    [users addObject:user3];
    return users;
    // I should add constructors, but I think we are about to ditch this for core data anyway...
} // end getUsers

+(NSMutableArray*) getUser1Companies
{
    NSMutableArray *companies = [[NSMutableArray alloc] init];
    
    Company *aCompany1 = [[Company alloc] init];
    aCompany1.company_display = @"Roberts Auto Plaza";
    aCompany1.company_pk = 0;
    [companies addObject:aCompany1];
    
    Company *aCompany2 = [[Company alloc] init];
    aCompany2.company_display = @"Above Par Mortgage";
    aCompany2.company_pk = 1;
    [companies addObject:aCompany2];
    
    Company *aCompany3 = [[Company alloc] init];
    aCompany3.company_display = @"Premier Mortgage Funding";
    aCompany3.company_pk = 2;
    [companies addObject:aCompany3];
    
    Company *aCompany4 = [[Company alloc] init];
    aCompany4.company_display = @"Triumph";
    aCompany4.company_pk = 3;
    [companies addObject:aCompany4];
    
    Company *aCompany5 = [[Company alloc] init];
    aCompany5.company_display = @"Wier";
    aCompany5.company_pk = 4;
    [companies addObject:aCompany5];
    return companies;
}

+(NSMutableArray*) getUser1Enterprises
{
    NSMutableArray *userEnterprises = [[NSMutableArray alloc] init];
    [userEnterprises addObject:@"eShipping"];
    return userEnterprises;
}

// might want to update these to use real companies & fix the pk's
+(NSMutableArray*) getUser2Companies
{
    NSMutableArray *companies = [[NSMutableArray alloc] init];
   
    Company *aCompany1 = [[Company alloc] init];
    aCompany1.company_display = @"Toys R' US";
    aCompany1.company_pk = 5;
    [companies addObject:aCompany1];
    
    Company *aCompany2 = [[Company alloc] init];
    aCompany2.company_display = @"Best Buy";
    aCompany2.company_pk = 6;
    [companies addObject:aCompany2];
    
    Company *aCompany3 = [[Company alloc] init];
    aCompany3.company_display = @"Premier Mortgage Funding";
    aCompany3.company_pk = 7;
    [companies addObject:aCompany3];
    
    Company *aCompany4 = [[Company alloc] init];
    aCompany4.company_display = @"Above Par Mortgage";
    aCompany4.company_pk = 1;
    [companies addObject:aCompany4];
    
    Company *aCompany5 = [[Company alloc] init];
    aCompany5.company_display = @"Roberts Auto Plaza";
    aCompany5.company_pk = 0;
    [companies addObject:aCompany5];
    return companies;
}

+(NSMutableArray*) getUser2Enterprises
{
    NSMutableArray *userEnterprises = [[NSMutableArray alloc] init];
    [userEnterprises addObject:@"exchange"];
    return userEnterprises;
}

// udpate these to use real companies...?
+(NSMutableArray*) getUser3Companies
{
    NSMutableArray *companies = [[NSMutableArray alloc] init];

    
    Company *aCompany1 = [[Company alloc] init];
    aCompany1.company_display = @"Premier Mortgage Funding";
    aCompany1.company_pk = 2;
    [companies addObject:aCompany1];
    
    Company *aCompany2 = [[Company alloc] init];
    aCompany2.company_display = @"Roberts Auto Plaza";
    aCompany2.company_pk = 0;
    [companies addObject:aCompany2];
    
    Company *aCompany3 = [[Company alloc] init];
    aCompany3.company_display = @"Wier";
    aCompany3.company_pk = 4;
    [companies addObject:aCompany3];
    
    Company *aCompany4 = [[Company alloc] init];
    aCompany4.company_display = @"Triumph";
    aCompany4.company_pk = 3;
    [companies addObject:aCompany4];
    
    Company *aCompany5 = [[Company alloc] init];
    aCompany5.company_display = @"Above Par Mortgage";
    aCompany5.company_pk = 1;
    [companies addObject:aCompany5];
    
    return companies;
}

+(NSMutableArray*) getUser3Enterprises
{
    NSMutableArray *userEnterprises = [[NSMutableArray alloc] init];
    [userEnterprises addObject:@"eShipping"];
    [userEnterprises addObject:@"exchange"];
    return userEnterprises;
}
/*
#pragma mark Shared Public Methods
+(User *) getUser
{
    Data *shared = [Data sharedInstance];
    return shared.user;
}
 */

/*
+(void) clearUser
{
    Data *shared = [Data sharedInstance];
    shared.user.name = @"";
    shared.user.email = @"";
    shared.user.company = @"Select Company";
    shared.user.enterprise = @"Select Enterprise";
}
 */

+(NSArray *) getCompanies
{
    Data *shared = [Data sharedInstance];
    return shared.companies;
}

+(NSArray *) getEnterprises
{
    Data *shared = [Data sharedInstance];
    return shared.enterprises;
}


@end
