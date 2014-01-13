//
//  NGAJSONHttpClient.m
//  iNGA
//
//  Created by WildCat on 12/31/13.
//  Copyright (c) 2013 WildCat. All rights reserved.
//

#import "NGAJSONHttpClient.h"

@implementation NGAJSONHttpClient

- (id)init {
    return [self initWithDelegate:nil];
}

- (id)initWithDelegate:(id<NGAJSONHttpClientDelegate>)delegate{
    if (delegate == nil) {
        NSException *exception = [[NSException alloc] initWithName:@"NGAJSONHttpClient has no delegate" reason:@"delegate = nil" userInfo:nil];
        @throw(exception);
    }
    
    if (self = [super init]) {
        _delegate = delegate;
        _ngaBaseHttpClient = [[NGABaseHttpClient alloc] initWithDelegate:self];
        [_ngaBaseHttpClient setHTTPMethodPost];
    }
    
    return self;
}

- (void)startRequest:(NSString *)urlString {
    [_ngaBaseHttpClient startRequest:urlString];
}

- (void)requestSucceed:(NSData *)data {
    NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *jsHtml = [[NSString alloc] initWithData:data encoding:encode];
    
    NSString *jsonStr = [jsHtml stringByReplacingOccurrencesOfString:@"window.script_muti_get_var_store=" withString:@""];
    
    NSError *jsonError;
	
	id jsonObj = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
	if(!jsonObj || jsonError){
//		NSLog(@"json解码失败");
        [_delegate jsonRequestFailed:jsonError withCode:1];
	} else {
//		NSLog(@"json解码成功");
		NSDictionary *deserializedDictionary = (NSDictionary *)jsonObj;
//		NSLog(@"Dersialized JSON Dictionary = %@", deserializedDictionary);
//		NSLog(@"%@", [[deserializedDictionary valueForKey:@"data"] valueForKey:@"__CU"]);

        [_delegate jsonDataSucceed:[deserializedDictionary valueForKey:@"data"]];
	}
    //json解析失败 -> NSError
};

- (void)requestFailed:(NSError *)error withCode:(int)responseStatusCode {
    [_delegate jsonRequestFailed:error withCode:0];
};
@end
