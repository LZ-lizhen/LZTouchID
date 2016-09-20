//
//  LZTouchID.m
//  LZTouchIDDome
//
//  Created by lizhen on 16/9/20.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "LZTouchID.h"
#import <LocalAuthentication/LocalAuthentication.h>


@implementation LZTouchID

static LZTouchID *touchID;

+ (instancetype)shareTouchID {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        touchID = [[self alloc]init];
    });
    return touchID;
}

- (void)startLZTouchIDWithMessage:(NSString *)message
                    fallbackTitle:(NSString *)fallbackTitle
                         delegate:(id<LZTouchIDDelegate>)delegate {
    
    LAContext *context = [[LAContext alloc]init];
    context.localizedFallbackTitle = fallbackTitle == nil ? LZNotice(@"按钮标题", @"Fallback Title") : fallbackTitle;
    
    NSError *error = nil;
    
    self.delegate = delegate;
    NSAssert(self.delegate != nil, LZNotice(@"LZTouchIDDelegate 不能为空", @"LZTouchIDDelegate must be non-nil"));
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message == nil ? LZNotice(@"自定义信息", @"The Custom Message") : message reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                
                //验证成功
                if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeSuccess)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.delegate LZTouchIDAuthorizeSuccess];
                    }];
                }
            } else if (error) {
                
                switch (error.code) {
                        
                    case LAErrorAuthenticationFailed: {
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeFailure)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeFailure];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorUserCancel: {
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeErrorUserCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeErrorUserCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorUserFallback: {
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeErrorUserFallback)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeErrorUserFallback];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorSystemCancel:{
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeErrorSystemCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeErrorSystemCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDNotEnrolled: {
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeErrorTouchIDNotEnrolled)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeErrorTouchIDNotEnrolled];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorPasscodeNotSet: {
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeErrorPasscodeNotSet)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeErrorPasscodeNotSet];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDNotAvailable: {
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeErrorTouchIDNotAvailable)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeErrorTouchIDNotAvailable];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDLockout: {
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeErrorTouchIDLockout)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeErrorTouchIDLockout];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorAppCancel:  {
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeErrorAppCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeErrorAppCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorInvalidContext: {
                        
                        if ([self.delegate respondsToSelector:@selector(LZTouchIDAuthorizeErrorInvalidContext)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LZTouchIDAuthorizeErrorInvalidContext];
                            }];
                        }
                    }
                        break;
                }
            }
        }];
        
    } else {
        if ([self.delegate respondsToSelector:@selector(LZTouchIDIsNotSupport)]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.delegate LZTouchIDIsNotSupport];
            }];
        }
    }
}


@end
