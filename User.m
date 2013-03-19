//
//  User.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/17/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "User.h"
#import "Enterprise.h"
#import "QuoteRequest.h"
#import "UserSettings.h"


@implementation User

@dynamic accountId;
@dynamic email;
@dynamic loginName;
@dynamic password;
@dynamic selectedCompanyId;
@dynamic selectedEnterpriseId;
@dynamic timestamp;
@dynamic enterprises;
@dynamic userSettings;
@dynamic savedQuoteRequests;

@end
