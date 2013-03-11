//
//  RateError.m
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import "RateError.h"

@implementation RateError

@synthesize errorId = _errorId;
@synthesize errorMessage = _errorMessage;

- (id) init
{
    if(self = [super init])
    {
        self.errorMessage = nil;
    }
    return self;
}


@end
