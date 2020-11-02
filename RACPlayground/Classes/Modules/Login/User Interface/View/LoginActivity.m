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
@property (strong, nonatomic) UIButton *loginBtn;
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"hahh";
//    self.navigationController.navigationBar.hidden = true;
}
#pragma mark - 初始化
- (void)config {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpViews {
    // username password
    
    UITextField *usernameField = [UITextField new];
    UITextField *passwordField = [UITextField new];
    UIButton *loginBtn = [UIButton new];
    self.loginBtn = loginBtn;
    
    passwordField.secureTextEntry = true;
    usernameField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.cornerRadius = 6;
    loginBtn.layer.masksToBounds = true;
    [loginBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchDown];
    
    //layout
    [self.view addSubview:usernameField];
    [self.view addSubview:passwordField];
    [self.view addSubview:loginBtn];
    
    [usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(20);
        make.left.equalTo(@40);
        make.centerX.equalTo(@0);
        make.height.equalTo(@40);
    }];
    
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(usernameField.mas_bottom).offset(20);
        make.left.equalTo(@40);
        make.centerX.equalTo(@0);
        make.height.equalTo(@40);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordField.mas_bottom).offset(20);
        make.trailing.equalTo(passwordField.mas_trailing);
        make.width.equalTo(@80);
    }];
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令:代替Action/target模式
    XF_C_(self.loginBtn, EventHandler, loginCommand)
    
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

#pragma mark - UIAction
//-(void)loginAction
//{
//    [EventHandler loginAction];
//}

#pragma mark - Change UI State


#pragma mark - UIControlDelegate


#pragma mark - Getter



@end
