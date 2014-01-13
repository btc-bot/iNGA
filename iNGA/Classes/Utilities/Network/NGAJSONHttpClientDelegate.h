//
//  NGAJSONHttpClientDelegate.h
//  iNGA
//
//  Created by WildCat on 12/31/13.
//  Copyright (c) 2013 WildCat. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NGAJSONHttpClientDelegate
@required

- (void)jsonDataSucceed:(NSDictionary *)dict;
- (void)jsonRequestFailed:(NSError *)error withCode:(int)responseStatusCode;

@end
