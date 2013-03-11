//
//  RateError.h
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import <Foundation/Foundation.h>

@interface RateError : NSObject
{
    int _errorId;
    NSString* _errorMessage;
}

@property (nonatomic,assign) int errorId;
@property (nonatomic,retain) NSString * errorMessage;

@end
