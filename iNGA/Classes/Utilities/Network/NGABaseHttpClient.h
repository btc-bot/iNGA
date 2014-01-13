//
//  NGABaseHttpClient.h
//  iNGA
//  基础HTTP类，业务逻辑需要封装在NGAHttpClient类中
//
//  Created by WildCat on 13-12-2.
//  Copyright (c) 2013 WildCat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGABaseHttpClientDelegate.h"

#define NGA_USER_AGENT @"iNGA/1.0 (iPhone)";

@interface NGABaseHttpClient : NSObject <NSURLConnectionDelegate>
{
    id <NGABaseHttpClientDelegate> _delegate;
    
	NSMutableURLRequest *_request;    //Request
	NSMutableData *_postData;                //POST Data
	
	NSMutableData *_receivedData;
//	NSError *_error;
	
	BOOL _isMethodPost;               //if use HTTP POST
    int _responseStatusCode;
}

//@property (nonatomic, retain) NSMutableData *receivedData;
- (id)initWithDelegate: (id)delegate;
- (void)setHTTPMethodPost;
- (void)startRequest: (NSString *)urlString;
- (void)setPostData: (NSString *)postDataString;


@end
