//
//  HomeActivity.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//

#import "HomeActivity.h"
#import "HomeEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<HomeEventHandlerPort>)

@interface HomeActivity ()
@property (strong, nonatomic) UIButton *xf_backBtn;
@property (strong, nonatomic) UIButton *setBtn;
@end

@implementation HomeActivity

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
    UIButton *set = [[UIButton alloc]init];
    [set setTitle:@"设置" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:set];
}

- (void)setUpViews {
    //导航条
    self.navigationItem.title = @"主页";
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchDown];
    
    //返回按钮
    self.xf_backBtn = [UIButton new];
    [self.xf_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.xf_backBtn setTitle:@"XF返回方式" forState:UIControlStateNormal];
    [self.view addSubview:self.xf_backBtn];
    [self.xf_backBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(@0);
    }];
    
    

}

-(void)backAction:(UIButton *)sender
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    //
    
}

-(UIModalPresentationStyle)modalPresentationStyle
{
    return UIModalPresentationFullScreen;
}
- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    XF_C_(self.xf_backBtn, EventHandler, backCommand)
    XF_C_(self.setBtn, EventHandler, setCommand)
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
