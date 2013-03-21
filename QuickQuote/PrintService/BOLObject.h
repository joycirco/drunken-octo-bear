//
//  BOLObject.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/21/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOLObject : NSObject

@property (nonatomic, retain) NSString* originZip;
@property (nonatomic, retain) NSString* destinationZip;
@property (nonatomic, retain) NSString* storeLocationCode;
@property (nonatomic, retain) NSString* pickupDate;  // format = MM/DD/YYYY

@end
