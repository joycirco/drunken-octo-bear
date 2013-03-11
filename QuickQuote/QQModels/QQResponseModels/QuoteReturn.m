//
//  QuoteReturn.m
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import "QuoteReturn.h"

#import "RSPRateReturn.h"
#import "RSPRateResponsePrivileged.h"
#import "RateResponse.h"
#import "RateError.h"
#import "RSPRateError.h"

@implementation QuoteReturn

@synthesize rateErrors = _rateErrors;
@synthesize rateResponses = _rateResponses;

- (id) init
{
    if(self = [super init])
    {
        self.rateResponses = [[NSMutableArray alloc] init];
        self.rateErrors = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id) createWithRSPRateReturn: (RSPRateReturn*) rspRR
{
    return [[self alloc] initWithRSPRateReturn: rspRR];
}

- (id) initWithRSPRateReturn: (RSPRateReturn*) rspRR
{
    if(self = [self init])
    {
        for(RSPRateResponsePrivileged* rsp in rspRR.rrp)
        {
            RateResponse* value = [RateResponse createWithRSPRateResponse:rsp];
                                   
            if(value != nil) {
                [self.rateResponses addObject: value];
            }
        }
        
        if (rspRR.re != nil)
        {
            
            RateError *err = [[RateError alloc] init];
            err.errorId = rspRR.re.errorId;
            err.errorMessage = rspRR.re.errorMessage;
            [self.rateErrors addObject:err];
        }
    }
    return self;
}

@end
