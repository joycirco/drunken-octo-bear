//
//  user.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/8/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize loginName;
@synthesize password;
@synthesize email;
@synthesize selectedCompany;
@synthesize selectedEnterprise;

@synthesize companies;
@synthesize enterprises;

//(id) initWithData:(NSString)theloginName Andpassword

+(NSMutableArray*)getCompanies
{
    return NULL;
}

+(NSMutableArray*)getEnterprises
{
    return NULL;
}

@end
