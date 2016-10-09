//
//  AccountCenterVC.m
//  wujieNew
//
//  Created by rongfeng on 15/12/23.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "AccountCenterVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import "TDViewsCell.h"
#import "TDAccountCell.h"
#import "AccountMsg.h"
#import "LoginViewController.h"
#import "WalletVC.h"
#import "SettingVC.h"
#import "WalletViewController.h"
#import "JXSettingViewController.h"
#import "macro.h"
#import "JXWalletViewController.h"
#import "JXAccountMsgViewController.h"
#import "KTBWalletViewController.h"
#import "SJAvatarBrowser.h"
@implementation AccountCenterVC {
    
    UIImageView *_TXImgView;
    UIImageView *LineOne;
    UIImageView *LineTwo;
    UIImageView *LineThird;
    UIImageView *LineFour;
    
}

- (void)viewWillAppear:(BOOL)animated {
    //去掉导航栏
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"TXImage"];
    if (data) {
        _TXImgView.image = [UIImage imageWithData:data];
    }else {
        _TXImgView.image = [UIImage imageNamed:@"椭圆-8@2x.png"];
    }
    //self.view.backgroundColor = RedColor;
    //_TXImgView.image = [UIImage imageNamed:@"椭圆-8@2x.png"];
    self.navigationController.navigationBar.barTintColor = NavBack;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"我的";
    self.navigationItem.backBarButtonItem = right;
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight+22) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.showsVerticalScrollIndicator = NO;
    table.backgroundColor = LightGrayColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TXClickAction)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    //头视图创建
    UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 160)];
    ImgView.backgroundColor = NavBack;
    ImgView.userInteractionEnabled = YES;
    [ImgView addGestureRecognizer:tap];
    _TXImgView = [[UIImageView alloc] initWithFrame:CGRectMake(112, 40, 94, 94)];
    _TXImgView = [[UIImageView alloc] init];
    _TXImgView.layer.cornerRadius = 40;
    _TXImgView.layer.masksToBounds = YES;
    _TXImgView.userInteractionEnabled = YES;
    [_TXImgView addGestureRecognizer:tap];
    //账户名
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [BusiIntf getUserInfo].UserName;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    //最后登陆
    UILabel *DataTimeLab = [[UILabel alloc] init];
    DataTimeLab.textAlignment = NSTextAlignmentLeft;
    DataTimeLab.text = [NSString stringWithFormat:@"上次登录时间: %@",[BusiIntf getUserInfo].StartDate];
    DataTimeLab.font = [UIFont systemFontOfSize:10];
    DataTimeLab.textColor = [UIColor whiteColor];
    
    [ImgView addSubview:_TXImgView];
    [ImgView addSubview:label];
    [ImgView addSubview:DataTimeLab];
    label.sd_layout.centerXEqualToView(ImgView).topSpaceToView(_TXImgView,8).widthIs(100).heightIs(20);
    DataTimeLab.sd_layout.centerXEqualToView(ImgView).topSpaceToView(_TXImgView,33).widthIs(300).heightIs(10.5);
    
    
    _TXImgView.sd_layout.leftSpaceToView(ImgView,16).centerYEqualToView(ImgView).widthIs(80).heightIs(80);
    label.sd_layout.leftSpaceToView(_TXImgView,10).topSpaceToView(ImgView,55).widthIs(100).heightIs(20);
    DataTimeLab.sd_layout.leftSpaceToView(_TXImgView,10).topSpaceToView(label,12).widthIs(300).heightIs(10.5);
    table.tableHeaderView = ImgView;
    
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 85+22)];
    footView.backgroundColor = LightGrayColor;
    footView.userInteractionEnabled = YES;
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, KscreenWidth - 30, 40+22)];
    BackImg.layer.cornerRadius = 4;
    BackImg.layer.masksToBounds = YES;
    BackImg.backgroundColor = LightBlue;
    
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, KscreenWidth - 30, 40)];
    backLabel.text = @"退 出";
    backLabel.textColor = [UIColor whiteColor];
    backLabel.textAlignment = NSTextAlignmentCenter;
    backLabel.layer.cornerRadius = 4;
    backLabel.layer.masksToBounds = YES;
    backLabel.backgroundColor = RedColor;
    backLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClearButton)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;
    
    [backLabel addGestureRecognizer:singleTap];
    //[footView addSubview:backLabel];
    table.tableFooterView = footView;
    [self.view addSubview:table];
    
    LineOne = [[UIImageView alloc] init];
    LineOne.backgroundColor = Color(213, 215, 220);
    LineTwo = [[UIImageView alloc] init];
    LineTwo.backgroundColor = Color(213, 215, 220);
    LineThird = [[UIImageView alloc] init];
    LineThird.backgroundColor = Color(213, 215, 220);
    LineFour = [[UIImageView alloc] init];
    LineFour.backgroundColor = Color(213, 215, 220);

}
//退出登录实现方法
-(void)clickClearButton{
    
    LoginViewController* controller = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:controller] ;
    navController.navigationBarHidden = YES;
    navController.toolbarHidden = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController = navController;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)TXClickAction {
    
//    TDTXViewController *TXVC = [[TDTXViewController alloc] init];
//    [self.navigationController pushViewController:TXVC animated:YES];
    NSLog(@"@@@@@@@@@@@@");
    
    [SJAvatarBrowser showImage:_TXImgView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([BusiIntf curPayOrder].IsAPPStore) {
        return 7;
    }else {
        return 8;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 16;
    }if (indexPath.row == 3) {
        return 31.5;
    }
    
    if ([BusiIntf curPayOrder].IsAPPStore) {
        if (indexPath.row == 6) {
            return 0;
        }else {
            return 40;
        }
    }else {
        if (indexPath.row == 7) {
            return 0;
        }else {
            return 40;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            TDViewsCell *TDCell = [[TDViewsCell alloc] init];
            LineOne.frame = CGRectMake(0, 15.5, KscreenWidth, 1);
            //[TDCell.contentView addSubview:LineOne];
            cell = TDCell;
        }
        if (indexPath.row == 1) {
            TDAccountCell *TDCell = [[TDAccountCell alloc] init];
            TDCell.ImageView.image = [UIImage imageNamed:@"个人信息.png"];
            TDCell.label.text = @"个人信息";
            cell = TDCell;
        }
        if (indexPath.row == 2) {
            TDAccountCell *TDCell = [[TDAccountCell alloc] init];
            TDCell.ImageView.image = [UIImage imageNamed:@"钱包.png"];
            TDCell.label.text = @"钱包";
            cell = TDCell;
        }
//        if (indexPath.row == 4) {
//            TDAccountCell *TDCell = [[TDAccountCell alloc] init];
//            TDCell.ImageView.image = [UIImage imageNamed:@"商户管理.png"];
//            TDCell.label.text = @"商户管理";
//            LineTwo.frame = CGRectMake(0, 39.5, KscreenWidth, 1);
//            [TDCell.contentView addSubview:LineTwo];
//            cell = TDCell;
//        }
        if (indexPath.row == 3) {
            TDViewsCell *TDCell = [[TDViewsCell alloc] init];
            LineThird.frame = CGRectMake(0, 31, KscreenWidth, 1);
            //[TDCell.contentView addSubview:LineThird];
            cell = TDCell;
        }
        if (indexPath.row == 4) {
            TDAccountCell *TDCell = [[TDAccountCell alloc] init];
            TDCell.ImageView.image = [UIImage imageNamed:@"客服电话.png"];
            TDCell.label.text = @"客服电话 (400-6007-909)";
            cell = TDCell;
        }
        if ([BusiIntf curPayOrder].IsAPPStore) { //APPStore布局
            if (indexPath.row == 5) {
                
                TDAccountCell *TDCell = [[TDAccountCell alloc] init];
                TDCell.ImageView.image = [UIImage imageNamed:@"设置.png"];
                TDCell.label.text = @"设置";
                LineFour.frame = CGRectMake(0, 39.5, KscreenWidth, 1);
                //[TDCell.contentView addSubview:LineFour];
                cell = TDCell;

            }
        }else {
            if (indexPath.row == 5) {
                
                TDAccountCell *TDCell = [[TDAccountCell alloc] init];
                TDCell.ImageView.image = [UIImage imageNamed:@"帮助.png"];
                TDCell.label.text = @"帮助";
                cell = TDCell;
                
            }
            if (indexPath.row == 6) {
                TDAccountCell *TDCell = [[TDAccountCell alloc] init];
                TDCell.ImageView.image = [UIImage imageNamed:@"设置.png"];
                TDCell.label.text = @"设置";
                LineFour.frame = CGRectMake(0, 39.5, KscreenWidth, 1);
                //[TDCell.contentView addSubview:LineFour];
                cell = TDCell;
            }

        }
        
    }
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        //个人信息
//        AccountMsg *Account = [[AccountMsg alloc] init];
//        [self.navigationController pushViewController:Account animated:YES];
        
        JXAccountMsgViewController *jxAccount = [[JXAccountMsgViewController alloc] init];
        [self.navigationController pushViewController:jxAccount animated:YES];
        
    }
    if (indexPath.row == 2) {
        //钱包
//        WalletViewController *wallet = [[WalletViewController alloc] init];
//        [self.navigationController pushViewController:wallet animated:YES];
        
        KTBWalletViewController *Wallet = [[KTBWalletViewController alloc] init];
        [self.navigationController pushViewController:Wallet animated:YES];
        
    }
    if (indexPath.row == 4) {
        //拨打客服
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"400-6007-909" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        alert.tag = 1009;
        [alert show];
    }
    
    if ([BusiIntf curPayOrder].IsAPPStore) {
        if (indexPath.row == 5) {
            //        SettingVC *SetVC = [[SettingVC alloc] init];
            //        [self.navigationController pushViewController:SetVC animated:YES];
            
            JXSettingViewController *SetVc = [[JXSettingViewController alloc] init];
            [self.navigationController pushViewController:SetVc animated:YES];
            
        }
    }else {
        
        if (indexPath.row == 6) {
            //        SettingVC *SetVC = [[SettingVC alloc] init];
            //        [self.navigationController pushViewController:SetVC animated:YES];
            
            JXSettingViewController *SetVc = [[JXSettingViewController alloc] init];
            [self.navigationController pushViewController:SetVc animated:YES];
            
        }
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 1009) {
        if (buttonIndex == 0) {
            NSLog(@"取消拨打客服");
        }else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006007909"]];
        }
    }
    
}
@end
