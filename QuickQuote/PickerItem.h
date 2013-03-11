//
//  PickerItem.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/10/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickerItem : NSObject

@property (nonatomic,strong) NSString* itemTitle;
@property (nonatomic, strong) id itemObject;

- (id) initWithTitleObject:(NSString*)title :(id)object;

@end
