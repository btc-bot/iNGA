//
//  NGAUserLoginUtilDelegate.h
//  iNGA
//
//  Created by WildCat on 1/5/14.
//  Copyright (c) 2014 WildCat. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NGAUserLoginUtilDelegate
@required
- (void) userLoginErrorWithMessage:(NSString *) message;
- (void) userLoginSuccess;
@end
