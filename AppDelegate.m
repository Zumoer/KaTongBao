//
//  AppDelegate.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/15.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "JXLoginViewController.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
#import <GFDPlugin/GFDPlugin.h>
#define APPID  @"8266152b039dd499a70faac5899e2584"
#import "LoginViewController.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "Common.h"
#import "GuidViewController.h"

@interface AppDelegate ()


@end
//@implementation NSURLRequest(DataController)
@implementation AppDelegate {
    NSString *Anotherurl;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    //设置状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    //设置返回按钮字体颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    GuidViewController *GuidVc = [[GuidViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:GuidVc] ;
//    nav.navigationBarHidden = YES;
//    nav.toolbarHidden = YES;
//    self.window.rootViewController = nav;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            NSLog(@"第一次启动!");
    
        GuidViewController *GuidVc = [[GuidViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:GuidVc] ;
        nav.navigationBarHidden = YES;
        nav.toolbarHidden = YES;
        self.window.rootViewController = nav;
            
    
    }else{
    
            NSLog(@"不是第一次启动了！");
    
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC] ;
        nav.navigationBarHidden = YES;
        nav.toolbarHidden = YES;
        self.window.rootViewController = nav;
    }
    
    [self.window makeKeyAndVisible];
    

    
    //集成蒲公英
    
    //启动基本SDK
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    
    [[PgyManager sharedPgyManager] startManagerWithAppId:APPID];
    
    //启动更新检查SDK
    //[[PgyUpdateManager sharedPgyManager] startManagerWithAppId:APPID];
    //[[PgyUpdateManager sharedPgyManager] checkUpdate];
    //[[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(UpDateMethod:)];
    //功夫贷
    
//    [[GFDPlugin sharedInstance] setAppID:@"katongbao"];
//    [[GFDPlugin sharedInstance] setAppKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCYA1gYvLkQTZfsEAoWRFCbF6uOIHwjEjX82MJ JTp2FUJq0DfJ4pmyAY7PvZ0iI/KzSzzfW07dFL9kjYJwX9rn1sMEa3POxtznJcmJI1qoW8PPeUyY2BWgHhTgFwBl+leSc+4MWua7ljNjr6Mndot8EWEqdrN0L2zQvTzMa3IfQQIDAQAB"];
    
    [[GFDPlugin sharedInstance] setupAPPID:@"katongbao" appKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCYA1gYv/LkQTZfsEAoWRFCbF6uOIHwjEjX82MJJTp2FUJq0DfJ4pmyAY7PvZ0iI/KzSzzfW07dFL9kjYJwX9rn1sMEa3POxtznJcmJI1qoW8PPeUyY2BWgHhTgFwBl+leSc+4MWua7ljNjr6Mndot8EWEqdrN0L2zQvTzMa3IfQQIDAQAB"];
    
    
    //检测更新
    [self RequestForVersionUpdate];
    
    //设置启动动画
    UIImage *splashImg;
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        splashImg = [UIImage imageNamed:@"launch.jpg"];
    }
    else {
        splashImg = [UIImage imageNamed:@"launch.jpg"];
    }
    UIImageView *launchView = [[UIImageView alloc] initWithImage:splashImg];
    launchView.backgroundColor = [UIColor yellowColor];
    launchView.image = splashImg;
    launchView.contentMode = UIViewContentModeScaleToFill;
    
    NSLog(@"%@", NSStringFromCGSize(splashImg.size));
    [self.window addSubview:launchView];
    
    launchView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[launchView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(launchView)]];
    
    NSLayoutConstraint *cons = [NSLayoutConstraint constraintWithItem:launchView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:launchView.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    [self.window addConstraint:cons];
    
    NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:launchView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:launchView attribute:NSLayoutAttributeWidth multiplier:splashImg.size.height/splashImg.size.width constant:0];
    [launchView addConstraint:con2];
    
    NSLog(@"%@", NSStringFromCGRect(launchView.frame));
    [self.window layoutIfNeeded];
    NSLog(@"%@", NSStringFromCGRect(launchView.frame));
    
    CGFloat offset = launchView.frame.size.width - [[UIScreen mainScreen] bounds].size.width;//图片有一个像素空白
    //    return YES;
    
    UIImageView *imgLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"进入页-"]];
    imgLogo.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //    imgLogo.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 4);
    [self.window addSubview:imgLogo];
    //imgLogo.sd_layout.centerXEqualToView(self.window).leftSpaceToView(self.window,0).rightSpaceToView(self.window,0);
    
    
    UILabel *labTips = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 80, [UIScreen mainScreen].bounds.size.width, 80)];
    labTips.text = [[NSString alloc]initWithFormat:@"当前版本 v%@\n浙江融丰信息技术服务有限公司", @"1.0"];
    labTips.textColor = [UIColor whiteColor];
    labTips.textAlignment = NSTextAlignmentCenter;
    labTips.numberOfLines = 0;
    labTips.font = [UIFont boldSystemFontOfSize:12];
    //[self.window addSubview:labTips];
    
    [self.window bringSubviewToFront:launchView];
    [self.window bringSubviewToFront:imgLogo];
    [self.window bringSubviewToFront:labTips];
    
    [UIView animateWithDuration:2.5 animations:^{
        cons.constant = offset;
        [self.window layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSLog(@"%@", NSStringFromCGRect(launchView.frame));
        [UIView animateWithDuration:0.5 animations:^{
            
            launchView.alpha = 0;
            labTips.alpha = 0;
            imgLogo.alpha = 0;
        } completion:^(BOOL finished) {
            [launchView removeFromSuperview];
            [labTips removeFromSuperview];
            [imgLogo removeFromSuperview];
        }];
    }];

    return YES;
}

//检测是不是最新版本并记录
- (void)UpDateMethod:(NSDictionary *)response {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if (response != nil) {
        [user setObject:@"0" forKey:@"IsViewNew"];
        
    } else {
        [user setObject:@"1" forKey:@"IsViewNew"];
        
    }
    
    NSLog(@"是否是最新版本:%@",[user objectForKey:@"IsViewNew"]);
}

//检测版本更新
- (void)RequestForVersionUpdate {
    
    NSString *url = JXUrl;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *identify = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleInfoDictionaryVersionKey];
    NSString *Ver = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前版本:%@,%@,%@",version,identify,Ver);
    NSDictionary *dic1 = @{
                           @"os":@"IOS",
                           @"version":version
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopSdkVersionState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        //NSString *isUpd = dic[@"isUpd"];
        //NSString *patchVersion = dic[@"patchVersion"];
        NSString *updateMsg = dic[@"updateMsg"];
        NSString *versionCode = dic[@"versionCode"];
        NSString *downloadUrl = dic[@"downloadUrl"];
        //NSString *updateFlg = dic[@"updateFlg"];
        NSString *forturl = @"itms-services:///?action=download-manifest&url=";
        Anotherurl = [NSString stringWithFormat:@"%@%@",forturl,downloadUrl];
        if (downloadUrl != nil) {
            NSString  *Title = [NSString stringWithFormat:@"最新版本为:%@,是否更新?",versionCode];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Title message:updateMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];
}
//
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        
    }else if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Anotherurl]];
    }
    
}

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
