//
//  ArrayOfTerminalInfo.h
//  QuickQuote
//
//  Created by Darin Raffety on 2/23/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayOfTerminalInfo : NSMutableArray

- (NSUInteger)count;

+ (id) createWithRSPArrayOfTerminal: (NSMutableArray*) arr;
- (id) initWithRSPArrayOfTerminal: (NSMutableArray*) arr;

@end
