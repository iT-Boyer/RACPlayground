//
//  RACSetViewController.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/14.
//  
//

#import "RACSetViewController.h"
#import "RACSetDataDriverProtocol.h"

#define DataDriver  LEGORealPort(id<RACSetDataDriverProtocol>, self.dataDriver)

@interface RACSetViewController ()

@end

@implementation RACSetViewController

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
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpViews {
    UILabel *msg = [UILabel new];
    msg.text = @"设置页面显示";
    [self.view addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(@0);
    }];

}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, DataDriver, text)
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


#pragma mark - UIControlDelegate


#pragma mark - Getter

@end
