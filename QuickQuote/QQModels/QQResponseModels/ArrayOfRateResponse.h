//
//  ArrayOfRateResponse.h
//  QuickQuote
//
//  Created by Darin Raffety on 2/23/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayOfRateResponse : NSMutableArray

- (NSUInteger)count;

+ (id) createWithRSPArrayOfRateResponse: (NSMutableArray*) arr;
- (id) initWithRSPArrayOfRateResponse: (NSMutableArray*) arr;

@end
