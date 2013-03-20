//
//  User.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "User.h"
#import "Enterprise.h"
#import "DataModel.h"
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


- (Enterprise*)getCurrentEnterprise
{
    User *currentUser = [DataModel sharedInstance].currentUser;
    
    for (Enterprise *enterprise in currentUser.enterprises)
    {
        if (enterprise.enterpriseId == currentUser.selectedEnterpriseId)
        {
            return enterprise;
        }
    }
    return nil; 
}

@end
