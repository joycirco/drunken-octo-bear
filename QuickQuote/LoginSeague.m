//
//  LoginSeague.m
//  QuickQuote
//
//  Created by Steven Tuckness on 1/24/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "LoginSeague.h"

@implementation LoginSeague

- (void) perform {
    UIViewController *src = self.sourceViewController;
    UIWindow *window = src.view.window;
    [window addSubview:[self.destinationViewController view]];
    window.rootViewController = self.destinationViewController;
}


@end
