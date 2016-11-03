//
//  LoansSDK.h
//  LoansSDK
//
//  Created by qingfengwolf on 16/3/28.
//  Copyright © 2016年 ppdai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PPDRsa.h"

@interface LoansSDK : NSObject

@property (nonatomic, assign)float loanAutoSizeScaleX;
@property (nonatomic, assign)float loanAutoSizeScaleY;
@property (strong, nonatomic) UIWindow *loanWindow;
@property (nonatomic, strong) UINavigationController *loanNav;
@property (nonatomic, strong) UITabBarController *sdkTabbarcontroller;
@property (nonatomic, strong) NSString *userState;//sdk用户登录状态
@property (nonatomic, strong) NSString *comingAppID;
@property (nonatomic, strong) NSString *comingKey;
@property (nonatomic, assign) BOOL inSDK;

+ (LoansSDK *)instance;

//初始化sdk
+ (void)loadPPDLoanSDKInit:(NSString *)appid publicKey:(NSString *)pubkey privateKey:(NSString *)prikey;

/**进入loan  sdk
 * 调用此方法可以进入sdk
 *
 * phoneNum为带进来的手机号，可以为nil, thisC为当前页面UIViewController
 */
+(void)showLoanSdkView:(NSString *)phoneNum withController:(UIViewController *)thisC;

//清除账户信息
+(void)logoutAndCleanLoanSDK;




//
////退出loan sdk
+(void)logoutLoanSdkView;
//成功登录
+(void)successLogin;
//登录问题
+(void)showLoginView;

@end
