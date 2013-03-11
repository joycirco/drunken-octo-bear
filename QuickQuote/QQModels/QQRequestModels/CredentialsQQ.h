//
//  CredentialsQQ.h
//  ModelClasses
//
//  Created by Darin Raffety on 1/20/13.
//
//

#import <Foundation/Foundation.h>

@interface CredentialsQQ : NSObject
{
    NSString* _loginName;
    NSString* _password;
    NSString* _accountId;
    NSString* _token;
}

@property (nonatomic,retain) NSString* loginName;
@property (nonatomic,retain) NSString* password;
@property (nonatomic,retain) NSString* accountId;
@property (nonatomic,retain) NSString* token;

@end
