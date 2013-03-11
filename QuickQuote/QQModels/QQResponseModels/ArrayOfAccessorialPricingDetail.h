//
//  ArrayOfAccessorialPricingDetail.h
//  QuickQuote
//
//  Created by Darin Raffety on 2/23/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayOfAccessorialPricingDetail : NSMutableArray

- (NSUInteger)count;

+ (id) createWithRSPArrayOfAccessorial: (NSMutableArray*) arr;
- (id) initWithRSPArrayOfAccessorial: (NSMutableArray*) arr;

@end
