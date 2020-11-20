//
//  RACDetailViewController.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/19.
//  
//

#import "RACDetailViewController.h"
#import "RACDetailDataDriverProtocol.h"
#import "UIImage+Util.h"
#define DataDriver  LEGORealPort(id<RACDetailDataDriverProtocol>, self.dataDriver)

@interface RACDetailViewController ()
@property (strong, nonatomic) UIImageView *imgView;
@end

@implementation RACDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 配置当前视图
    [self config];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
- (void)config {
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpViews {
    //
    UIImageView *imgview = [UIImageView new];
    self.imgView = imgview;
    [self.view addSubview:imgview];
    [imgview mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(400, 400));
    }];
    NSString *imgUrl = @"https://fileserver.iuoooo.com/Jinher.JAP.BaseApp.FileServer.UI/FileManage/GetFile?fileURL=29e54e46-3e17-4ca4-8f03-db71fb8f967d/TempDirectory/42034a45-037d-444e-b375-32d5679c3799_05949A4A-71D4-40F8-ABAC-1568E363EA84.png";
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSString *userAccount = [self protectAccount:@"13522834108"];
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:userAccount attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:54.0f],NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.2]}];
        UIImage *water = [image addWaterByPattern:attr];
        self.imgView.image = water;
    }];
}
- (NSString *)protectAccount:(NSString *)userAccount {
    NSString *phoneNumRegex1 = @"^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneNum1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex1];
    BOOL isPhone = [phoneNum1 evaluateWithObject:userAccount];
    if (isPhone) {
        userAccount = [userAccount stringByReplacingCharactersInRange:NSMakeRange(3, 7) withString:@"*******"];
    }
    return userAccount;
}


- (void)bindViewData {
    // 双向数据绑定
//    XF_$_(self.textField, text, DataDriver, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, DataDriver, Command)
    
    // load or reset expressPack
//    XF_Define_Weak
//    [RACObserve(self.dataDriver, expressData) subscribeNext:^(NSString *imgUrl) {
//        XF_Define_Strong
//        // 如果有显示数据加载完成
//        if (imgUrl) {
//            [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                UIImage *water = [image addWaterByPattern:@"192333****4"];
//                self.imgView.image = water;
//            }];
//        }
//    }];
}


#pragma mark - Change UI State


#pragma mark - UIControlDelegate


#pragma mark - Getter

@end
