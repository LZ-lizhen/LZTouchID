//
//  ViewController.m
//  LZTouchIDDome
//
//  Created by lizhen on 16/9/20.
//  Copyright © 2016年 lizhen. All rights reserved.

#import "ViewController.h"
#import "LZTouchID.h"

@interface ViewController ()<LZTouchIDDelegate>
@property (weak, nonatomic) IBOutlet UILabel *notice;

@end

@implementation ViewController

- (IBAction)btnClick:(id)sender {
    
        [[LZTouchID shareTouchID] startLZTouchIDWithMessage:LZNotice(@"通过Home键验证已有手机指纹", @"The Custom Message") fallbackTitle:@"" delegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
            [[LZTouchID shareTouchID] startLZTouchIDWithMessage:LZNotice(@"通过Home键验证已有手机指纹", @"The Custom Message") fallbackTitle:@"" delegate:self];
    //LZNotice(@"按钮标题", @"Fallback Title")
    
    [self.notice sizeToFit];

}

/**
 *  TouchID验证成功
 *
 *  Authentication Successul  Authorize Success
 */
- (void) LZTouchIDAuthorizeSuccess {
    _notice.text = LZNotice(@"TouchID验证成功", @"Authorize Success");
}

/**
 *  TouchID验证失败
 *
 *  Authentication Failure
 */
- (void) LZTouchIDAuthorizeFailure {
    _notice.text = LZNotice(@"TouchID验证失败", @"Authorize Failure");
}

/**
 *  取消TouchID验证 (用户点击了取消)
 *
 *  Authentication was canceled by user (e.g. tapped Cancel button).
 */
- (void) LZTouchIDAuthorizeErrorUserCancel {
    
    _notice.text = LZNotice(@"取消TouchID验证 (用户点击了取消)", @"Authorize Error User Cancel");
}

/**
 *  在TouchID对话框中点击输入密码按钮
 *
 *  User tapped the fallback button
 */
- (void) LZTouchIDAuthorizeErrorUserFallback {
    _notice.text = LZNotice(@"在TouchID对话框中点击输入密码按钮", @"Authorize Error User Fallback ");
}

/**
 *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 *
 *  Authentication was canceled by system (e.g. another application went to foreground).
 */
- (void) LZTouchIDAuthorizeErrorSystemCancel {
    
    _notice.text = LZNotice(@"在验证的TouchID的过程中被系统取消 ", @"Authorize Error System Cancel");
}

/**
 *  无法启用TouchID,设备没有设置密码
 *
 *  Authentication could not start, because passcode is not set on the device.
 */
- (void) LZTouchIDAuthorizeErrorPasscodeNotSet {
    _notice.text = LZNotice(@"无法启用TouchID,设备没有设置密码", @"Authorize Error Passcode Not Set");
}

/**
 *  设备没有录入TouchID,无法启用TouchID
 *
 *  Authentication could not start, because Touch ID has no enrolled fingers
 */
- (void) LZTouchIDAuthorizeErrorTouchIDNotEnrolled {
    
    _notice.text = LZNotice(@"设备没有录入TouchID,无法启用TouchID", @"Authorize Error TouchID Not Enrolled");
}

/**
 *  该设备的TouchID无效
 *
 *  Authentication could not start, because Touch ID is not available on the device.
 */
- (void) LZTouchIDAuthorizeErrorTouchIDNotAvailable {
    _notice.text = LZNotice(@"该设备的TouchID无效", @"Authorize Error TouchID Not Available");
}

/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 *
 *  Authentication was not successful, because there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
 *
 */
- (void) LZTouchIDAuthorizeLAErrorTouchIDLockout {
    _notice.text = LZNotice(@"多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁", @"Authorize LAError TouchID Lockout");
}

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 *
 *  Authentication was canceled by application (e.g. invalidate was called while authentication was inprogress).
 *
 */
- (void) LZTouchIDAuthorizeLAErrorAppCancel {
    _notice.text = LZNotice(@"当前软件被挂起取消了授权", @"Authorize LAError AppCancel");
}

/**
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 *
 *  LAContext passed to this call has been previously invalidated.
 */
- (void) LZTouchIDAuthorizeLAErrorInvalidContext {
    _notice.text = LZNotice(@"当前软件被挂起取消了授权", @"Authorize LAError Invalid Context");
}
/**
 *  当前设备不支持指纹识别
 *
 *  The current device does not support fingerprint identification
 */
-(void)LZTouchIDIsNotSupport {
    _notice.text = LZNotice(@"当前设备不支持指纹识别", @"The Current Device Does Not Support");
}

@end
