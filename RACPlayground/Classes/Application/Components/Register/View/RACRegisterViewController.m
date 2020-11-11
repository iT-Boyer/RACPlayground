//
//  RACRegisterViewController.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/10.
//  
//

#import "RACRegisterViewController.h"
#import "RACRegisterDataDriverProtocol.h"

#define DataDriver  LEGORealPort(id<RACRegisterDataDriverProtocol>, self.dataDriver)

@interface RACRegisterViewController ()
@property (strong, nonatomic) UILabel *userNameLabel;
@end

@implementation RACRegisterViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpViews {
    UILabel *userName = [UILabel new];
    userName.text = @"注册人名称";
    self.userNameLabel = userName;
    [self.view addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(@0);
    }];
}

- (void)bindViewData {
    // 双向数据绑定
    
    XF_$_(self.userNameLabel, text, DataDriver, userName)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, DataDriver, Command)
    
    // load or reset expressPack
    /*XF_Define_Weak
     [RACObserve(self.dataDriver, expressData) subscribeNext:^(id x) {
     XF_Define_Strong
     // 如果有显示数据加载完成
     if (x) {
     [self.tableView reloadData];
     }
     }];*/
}


#pragma mark - Change UI State
-(UIModalPresentationStyle)modalPresentationStyle
{
    return UIModalPresentationFullScreen;
}

#pragma mark - UIControlDelegate


#pragma mark - Getter

@end
