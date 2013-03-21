//
//  PersistedContext.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/19/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PersistedContext : NSObject

@property (nonatomic, retain) NSArray *accessorials;
@property (nonatomic, retain) NSArray *accessorialTypes;
@property (nonatomic, retain) NSArray *handlingUnitTypes;
@property (nonatomic, retain) NSArray *carrierImages;

-(id) init;

-(BOOL)loadDataFromPersistedStore;


@end
