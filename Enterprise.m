//
//  Enterprise.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/18/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "Enterprise.h"
#import "Company.h"
#import "User.h"


@implementation Enterprise

@dynamic enterpriseId;
@dynamic enterpriseName;
@dynamic timeStamp;
@dynamic companies;
@dynamic user;

- (Company*)getCurrentCompany
{
    User *currentUser = [DataModel sharedInstance].currentUser;
    
    Enterprise *currentEnterprise = currentUser.getCurrentEnterprise;
    
    for (Company *company in currentEnterprise.companies.allObjects)
    {
        if (company.companyId == currentUser.selectedCompanyId)
        {
            return company;
        }
    }
    return nil;
}

@end
