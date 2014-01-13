//
//  NGAUserLoginUtil.h
//  iNGA
//
//  Created by WildCat on 12/31/13.
//  Copyright (c) 2013 WildCat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGABaseHttpClient.h"
#import "NGABaseHttpClientDelegate.h"
#import "NGAUserLoginUtilDelegate.h"
#import "NGAJSONHttpClient.h"
#import "NGAJSONHttpClientDelegate.h"

#define NGA_USER_LOGIN_URL_STEP_0 @"http://account.178.com/q_account.php"
#define NGA_USER_LOGIN_URL_STEP_1 @"http://bbs.ngacn.cc/nuke.php"
#define NGA_USER_LOGIN_URL_STEP_2 @"http://bbs.ngacn.cc/thread.php?fid=-7&lite=js"

@interface NGAUserLoginUtil : NSObject<NGABaseHttpClientDelegate, NGAJSONHttpClientDelegate>
{
    id  <NGAUserLoginUtilDelegate> _delegate;
    int _step;
    NSMutableString *_username;
    NSMutableString *_password;
    NGABaseHttpClient *_ngaBaseHttpClient;
    NGAJSONHttpClient *_ngaJSONHttpCilent;
}
- (id)initWithDelegate:(id)delegate;
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
