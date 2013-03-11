//
//  QuoteReturn.h
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import <Foundation/Foundation.h>

@class RSPRateReturn;

@interface QuoteReturn : NSObject
{
    NSMutableArray* _rateErrors;
    NSMutableArray* _rateResponse;
}

@property (retain, nonatomic) NSMutableArray* rateErrors;
@property (retain, nonatomic) NSMutableArray* rateResponses;

+ (id) createWithRSPRateReturn: (RSPRateReturn*) rspRR;
- (id) initWithRSPRateReturn: (RSPRateReturn*) rspRR;

@end
