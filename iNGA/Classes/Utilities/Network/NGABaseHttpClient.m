//
//  NGAUtilsBaseHttpClient.m
//  iNGA
//
//  Created by WildCat on 13-12-2.
//  Copyright (c) 2013 WildCat. All rights reserved.
//

#import "NGABaseHttpClient.h"

@implementation NGABaseHttpClient

#pragma mark - initiate object
- (id)init {
    return [self initWithDelegate:nil];
}
- (id)initWithDelegate: (id<NGABaseHttpClientDelegate>)delegate
{
    if (delegate == nil) {
        NSException *exception = [[NSException alloc] initWithName:@"NGABaseHttpClient has no delegate" reason:@"delegate = nil" userInfo:nil];
        @throw(exception);
    }
    
    _receivedData = [[NSMutableData alloc] init];

    if (self = [super init]) {
		_request = [[NSMutableURLRequest alloc] initWithURL:nil cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
		
		_isMethodPost = NO;
//      _isHTTPResponseOK = YES;

        
		_delegate = delegate;
        
        
    }
	return self;
}

#pragma mark - Public Methods

/**
 *  Set HTTP POST method.
 */
- (void)setHTTPMethodPost {
	_isMethodPost = YES;
}

/**
 *  Set Post Data.
 *
 *  @param postData The data posted.
 */
- (void)setPostData:(NSString *)postDataString {
	_postData = [[postDataString dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
}

/**
 *  Start the request.
 *
 *  @param url the URL
 */
- (void)startRequest: (NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
	
	if(_isMethodPost == YES) {
		[_request setHTTPMethod: @"POST"];
		[_request setHTTPBody: _postData];
	} else {
		[_request setHTTPMethod: @"GET"];
		[_request setHTTPBody: nil];
	}
	
	[_request setURL:url];
    NSString *userAgent = NGA_USER_AGENT;
    [_request addValue:userAgent forHTTPHeaderField:@"User-Agent"];
	__unused NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
//	  NSLog(@"start request");
//	if(connection) {
//		_receivedData = [NSMutableData new];
//	}
}



#pragma mark - NSURLConnectionDelegate Procotol
/**
 *  If connection failed.
 *
 *  @param connection connection description
 *  @param error      error description
 */
- (void)connection: (NSURLConnection *)connection didFailWithError:(NSError *)error {
    [_delegate requestFailed:error withCode:0];
//    NSLog(@"error");
}

/**
 *  The other way to close the http request. If the status code is 200, call  - (void)requestSucceed:(NSData *)data of the delegate. If not, call - (void)requestFailed:(NSError *)error withCode: (int)responseStatusCode of the deledate.
 *
 *  @param connection Connection.
 */
- (void)connectionDidFinishLoading: (NSURLConnection *) connection {
    
	if((_responseStatusCode/200) == 1){
		[_delegate requestSucceed:_receivedData];
	}else{
        [_delegate requestFailed:nil withCode:_responseStatusCode];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_receivedData setLength:0];
    
    //convert to HTTP response
    NSHTTPURLResponse * responseHTTP = (NSHTTPURLResponse *)response;
    _responseStatusCode = [responseHTTP statusCode];
}

///**
// *  Charset Conversion
// *
// *  @param string UTF8 string.
// *
// *  @return GBK string.
// */
//- (NSString *)utf2gbk:(NSString *)string
//{
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
//    return retStr;
//}
@end
