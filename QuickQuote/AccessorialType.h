//
//  AccessorialType.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/12/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AccessorialType : NSManagedObject

@property (nonatomic, retain) NSNumber * accessorialTypeID;
@property (nonatomic, retain) NSString * accessorialTypeName;

@end
