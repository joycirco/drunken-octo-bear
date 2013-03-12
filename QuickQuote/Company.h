//
//  Company.h
//  QuickQuote
//
//  Created by Steven Tuckness on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (assign, nonatomic) NSInteger *company_pk;
@property (nonatomic, retain) NSString *company_display;

@end
