//
//  HandlingUnitType.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HandlingUnitType : NSManagedObject

@property (nonatomic, retain) NSString * handlingUnitTypeCode;
@property (nonatomic, retain) NSString * handlingUnitTypeDescription;
@property (nonatomic, retain) NSNumber * handlingUnitTypeID;

@end
