//
//  PersistedAccessorial.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/13/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PersistedAccessorial : NSManagedObject

@property (nonatomic, retain) NSString * accessorialCode;
@property (nonatomic, retain) NSString * accessorialName;
@property (nonatomic, retain) NSNumber * accessorialTypeID;

@end
