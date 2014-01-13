//
//  NGAJSONHttpClient.h
//  iNGA
//
//  Created by WildCat on 12/31/13.
//  Copyright (c) 2013 WildCat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGABaseHttpClient.h"
#import "NGAJSONHttpClientDelegate.h"

@interface NGAJSONHttpClient : NSObject<NGABaseHttpClientDelegate>
{
    id <NGAJSONHttpClientDelegate> _delegate;
    NGABaseHttpClient *_ngaBaseHttpClient;
}
- (id)initWithDelegate:(id<NGAJSONHttpClientDelegate>)delegate;
- (void)startRequest:(NSString *)urlString;
@end
