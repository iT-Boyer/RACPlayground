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
@property (strong, nonatomic) UITextField *userNameField;
@property (strong, nonatomic) UITextField *passwordField;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *mvcBtn;
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
    ///添加两种跳转方式
    //1. viper直接跳转原生mvc框架：不导出模块的情况下
    //2. 原生直接跳转到viper： 以展示层为入口进行跳转
    UIButton *mvcBtn = [UIButton new];
    self.mvcBtn = mvcBtn;
    [mvcBtn setTitle:@"跳转到mvc层框架" forState:UIControlStateNormal];
    //布局
    [self.view addSubview:mvcBtn];
    [mvcBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(self.view);
    }];
}

- (void)setUpViews {
    // username password
    
    UITextField *usernameField = [UITextField new];
    UITextField *passwordField = [UITextField new];
    UIButton *loginBtn = [UIButton new];
    self.loginBtn = loginBtn;
    self.userNameField = usernameField;
    self.passwordField = passwordField;
    
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
    XF_$_Input(self.userNameField, text, EventHandler, userName)
    /*等价于RAC方式
     RAC(EventHandler, userName) = [self.userNameField.rac_textSignal distinctUntilChanged];
     [RACObserve(EventHandler, userName) subscribe:RACChannelTo(self.userNameField, text)];
     */
//    RAC(EventHandler, userName)
    // 绑定事件层按钮命令:代替Action/target模式
    // 使用XF_C_宏封装RAC命令的方式：self.loginBtn.rac_command = [EventHandler loginCommand];
    XF_C_(self.loginBtn, EventHandler, loginCommand)
    XF_C_(self.mvcBtn, EventHandler, mvcCommand)
    
    [[EventHandler loginCommand].executionSignals subscribeNext:^(RACSignal *signal) {
        //信号不管是异步还是同步，会立即返回一个可取消的对象
        [signal subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
        //取消信号
        
    }];
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
