//
//  LoginActivity.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//

#import "LoginActivity.h"
#import "LoginEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<LoginEventHandlerPort>)

@interface LoginActivity ()

@end

@implementation LoginActivity

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
    // username password
    
    UITextField *usernameField = [UITextField new];
    UITextField *passwordField = [UITextField new];
    
    //layout
    [self.view addSubview:usernameField];
    [self.view addSubview:passwordField];
    
//    [usernameField mas_ma];
    
    
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, EventHandler, Command)
    
    // load or reset expressPack
    /*XF_Define_Weak
     [RACObserve(self.eventHandler, expressPack) subscribeNext:^(id x) {
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
