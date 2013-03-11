//
//  TerminalInfo.h
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import <Foundation/Foundation.h>

@class RSPTerminalInfo;

@interface TerminalInfo : NSObject
{
    NSString* _termCity;
    NSString* _termCode;
    NSString* _termContact;
    NSString* _termContactTitle;
    NSString* _termEmail;
	NSString* _termFax;
    NSString* _termName;
    NSString* _termState;
    NSString* _termStreet1;
    NSString* _termStreet2;
    NSString* _termTel;
    NSString* _termTollFree;
    NSString* _termZip;
}

@property (nonatomic,retain) NSString *termCity;
@property (nonatomic,retain) NSString *termCode;
@property (nonatomic,retain) NSString *termContact;
@property (nonatomic,retain) NSString *termContactTitle;
@property (nonatomic,retain) NSString *termEmail;
@property (nonatomic,retain) NSString* termFax;
@property (nonatomic,retain) NSString *termName;
@property (nonatomic,retain) NSString *termState;
@property (nonatomic,retain) NSString *termStreet1;
@property (nonatomic,retain) NSString *termStreet2;
@property (nonatomic,retain) NSString *termTel;
@property (nonatomic,retain) NSString *termTollFree;
@property (nonatomic,retain) NSString *termZip;

+ (TerminalInfo*) createWithRSPTerminal: (RSPTerminalInfo*) term;
- (id) initWithRSPTerminal: (RSPTerminalInfo*) term;


@end
