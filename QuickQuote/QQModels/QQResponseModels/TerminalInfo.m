//
//  TerminalInfo.m
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import "TerminalInfo.h"

#import "RSPTerminalInfo.h"

@implementation TerminalInfo

@synthesize termCity = _termCity;
@synthesize termCode = _termCode;
@synthesize termContact = _termContact;
@synthesize termContactTitle = _termContactTitle;
@synthesize termEmail = _termEmail;
@synthesize termName = _termName;
@synthesize termState = _termState;
@synthesize termStreet1 = _termStreet1;
@synthesize termStreet2 = _termStreet2;
@synthesize termTel = _termTel;
@synthesize termTollFree = _termTollFree;
@synthesize termZip = _termZip;


- (id) init
{
    if(self = [super init])
    {
        self.termCity = nil;
        self.termCode = nil;
        self.termContact = nil;
        self.termContactTitle = nil;
        self.termEmail = nil;
        self.termFax = nil;
        self.termName = nil;
        self.termState = nil;
        self.termStreet1 = nil;
        self.termStreet2 = nil;
        self.termTel = nil;
        self.termTollFree = nil;
        self.termZip = nil;
        
    }
    return self;
}

+ (TerminalInfo*) createWithRSPTerminal: (RSPTerminalInfo*) term
{
    if(term == nil) { return nil; }
    return [[self alloc] initWithRSPTerminal: term];

}

- (id) initWithRSPTerminal: (RSPTerminalInfo*) term
{
    if ([self init])
    {
        self.termCity = term.termCity;
        self.termCode = term.termCode;
        self.termContact = term.termContact;
        self.termContactTitle = term.termContactTitle;
        self.termEmail = term.termEmail;
        self.termFax = term.termFax;
        self.termName = term.termName;
        self.termState = term.termState;
        self.termStreet1 = term.termStreet1;
        self.termStreet2 = term.termStreet2;
        self.termTel = term.termTel;
        self.termTollFree = term.termTollFree;
        self.termZip = term.termZip;
    }
    return self;
}

@end
