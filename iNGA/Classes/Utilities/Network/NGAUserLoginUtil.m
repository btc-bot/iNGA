//
//  NGAUserLoginUtil.m
//  iNGA
//
//  Created by WildCat on 12/31/13.
//  Copyright (c) 2013 WildCat. All rights reserved.
//

#import "NGAUserLoginUtil.h"
#import "OCGumbo+Query.h"

@implementation NGAUserLoginUtil

- (id)init {
    return [self initWithDelegate:nil];
}

- (id)initWithDelegate:(id)delegate {
    
    if (delegate == nil) {
        NSException *exception = [[NSException alloc] initWithName:@"NGAUserLoginUtil has no delegate" reason:@"delegate = nil" userInfo:nil];
        @throw(exception);
    }
    
    if (self = [super init]) {
        _delegate = delegate;
        
        _ngaBaseHttpClient = [[NGABaseHttpClient alloc] initWithDelegate:self];
        [_ngaBaseHttpClient setHTTPMethodPost];
        _ngaJSONHttpCilent = [[NGAJSONHttpClient alloc] initWithDelegate:self];
        
        _step = 0;
    }
    
    return self;
}


- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password {
    _username = [username mutableCopy];
    _password = [password mutableCopy];
    
    NSString *post = [NSString stringWithFormat:@"email=%@&password=%@&_act=%@&noexpires=%@",
					  _username, _password,@"login",@"31536000"];
    [_ngaBaseHttpClient setPostData:post];
    [_ngaBaseHttpClient startRequest:NGA_USER_LOGIN_URL_STEP_0];
}


- (void)requestSucceed: (NSData *) data {
    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"login succeeded %@",html);
    if (_step == 0) {
        OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString:html];
        
        NSString *resultAreaText = document.Query(@"body").find(@"div.visit-content-main").find(@"div.result-area").find(@"h4").get(0).text();
        
        if([resultAreaText isEqualToString:@"登录成功"]) {
            _step = 1;
//            NSLog(@"login succeeded %@",html);
            
            NSString *inputValueUid = document.Query(@"body").find(@"form#ngaform").find(@"input").get(1).attr(@"value");
            NSString *inputValueCid = document.Query(@"body").find(@"form#ngaform").find(@"input").get(2).attr(@"value");
            NSString *inputValueExpires = document.Query(@"body").find(@"form#ngaform").find(@"input").get(3).attr(@"value");
            NSString *loginAdvancedPostString = [NSString stringWithFormat:@"func=login&uid=%@&cid=%@&expires=%@",inputValueUid, inputValueCid, inputValueExpires];
            [_ngaBaseHttpClient setPostData:loginAdvancedPostString];
            [_ngaBaseHttpClient startRequest:NGA_USER_LOGIN_URL_STEP_1];
            
        } else if([resultAreaText isEqualToString:@"登录失败"]) {
            [self callDelegateUserLoginErrorWithMessage:@"用户名或密码错误"];
        } else {
            [self callDelegateUserLoginErrorWithMessage:@"登录失败:无法检测是否登录成功"];
        }
    } else if (_step == 1) {
        _step = 2;
        
        [_ngaJSONHttpCilent startRequest:NGA_USER_LOGIN_URL_STEP_2];
    } else {
        [self callDelegateUserLoginErrorWithMessage:@"登录失败:流程控制错误"];
    }
}

- (void)requestFailed: (NSError *) error withCode: (int)responseStatusCode {
    _step = 0;
    
    NSString *errorMessage = [[NSString alloc] initWithFormat:@"登录失败：网络错误(%i)",responseStatusCode];
    [self callDelegateUserLoginErrorWithMessage:errorMessage];
//    NSLog(@"request failed");
}

- (void)jsonDataSucceed:(NSDictionary *)dict {
    _step = 0;
    int uid = (int) [[dict valueForKey:@"__CU"] valueForKey:@"uid"];
    if(uid > 0) {
        [self callDelegateUserLoginSuccess];
    } else {
        [self callDelegateUserLoginErrorWithMessage:@"登录失败:登录验证失败(0)"];
    }
}

- (void)jsonRequestFailed:(NSError *)error withCode:(int)responseStatusCode {
    NSLog(@"登录失败:登录验证失败(1)");
}

- (void)callDelegateUserLoginErrorWithMessage:(NSString *)message {
    _step = 0;
    [_delegate userLoginErrorWithMessage:message];
}

- (void)callDelegateUserLoginSuccess {
    _step = 0;
    [_delegate userLoginSuccess];
}

@end
