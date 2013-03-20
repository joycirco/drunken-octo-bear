//
//  ContextUtilities.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersistedContext;

@interface ContextUtilities : NSObject

-(void) generateApplicationData:(NSManagedObjectContext*)context : (PersistedContext*)persistedContext;

@end
