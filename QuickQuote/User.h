//
//  user.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/8/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSString *loginName;
    NSString *password;
    NSString *email;
    NSString *selectedCompany;
    NSString *selectedEnterprise;
    
    NSMutableArray *companies;
    NSMutableArray *enterprises;
}

@property (nonatomic, retain) NSString *loginName;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *selectedCompany;
@property (nonatomic, retain) NSString *selectedEnterprise;

@property (nonatomic, retain) NSMutableArray *companies;
@property (nonatomic, retain) NSMutableArray *enterprises;

//-(id)initWithData: (NSString)loginName andpassword: (NSString)password andemail:
//(NSString)email andselectedCompany:(NSString)selectedCompany andselectedEnterprise: (NSString)selectedEnterprise

+(NSMutableArray*)getCompanies;
+(NSMutableArray*)getEnterprises;

@end
