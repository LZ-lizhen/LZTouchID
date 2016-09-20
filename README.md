# LZTouchID
快速集成TouchID

1.导入LZTouchID文件

2.初始化[[LZTouchID shareTouchID] startLZTouchIDWithMessage:LZNotice(@"通过Home键验证已有手机指纹", @"The Custom Message") fallbackTitle:@"" delegate:self];

3.代理方法
TouchID验证成功
- (void)LZTouchIDAuthorizeSuccess;

 TouchID验证失败
- (void)LZTouchIDAuthorizeFailure;



