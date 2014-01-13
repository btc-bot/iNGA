//
//  NGABaseHttpClientDelegate.h
//  iNGA
//
//  Created by WildCat on 13-12-2.
//  Copyright (c) 2013 WildCat. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class NGABaseHttpClient

@protocol NGABaseHttpClientDelegate

@required
/**
 *  Request succeed.
 *
 *  @param data Date requested.
 */
- (void)requestSucceed:(NSData *)data;
- (void)requestFailed:(NSError *)error withCode:(int)responseStatusCode;
//- (void) requestStarted:(NSURL *) url;

@end
