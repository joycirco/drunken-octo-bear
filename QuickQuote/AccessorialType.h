//
//  AccessorialType.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Accessorial;

@interface AccessorialType : NSManagedObject

@property (nonatomic, retain) NSNumber * accessorialTypeID;
@property (nonatomic, retain) NSString * accessorialTypeName;
@property (nonatomic, retain) Accessorial *accessorial;

@end
