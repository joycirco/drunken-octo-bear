//
//  ArrayOfFreightPricingDetail.h
//  QuickQuote
//
//  Created by Darin Raffety on 2/23/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayOfFreightPricingDetail : NSMutableArray

- (NSUInteger)count;

+ (id) createWithRSPArrayOfFreight: (NSMutableArray*) arr;
- (id) initWithRSPArrayOfFreight: (NSMutableArray*) arr;

@end
