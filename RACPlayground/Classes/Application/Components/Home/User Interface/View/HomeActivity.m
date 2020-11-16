//
//  HomeActivity.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//

#import "HomeActivity.h"
#import "HomeEventHandlerPort.h"
#import <MJRefresh/MJRefresh.h>
#import "RACDogItem.h"
#define EventHandler  XFConvertPresenterToType(id<HomeEventHandlerPort>)

@interface HomeActivity ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIButton *setBtn;
@property (strong, nonatomic) UITableView *tableView;
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
    self.setBtn = set;
    [set setTitle:@"设置" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:set];
}

- (void)setUpViews {
    //导航条
    self.navigationItem.title = @"主页";
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(@0);
        make.left.bottom.equalTo(@0);
    }];

    XF_Define_Weak
    MJRefreshAutoNormalFooter * _Nonnull extractedExpr = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if(_tableView.mj_header.isRefreshing) {
            [_tableView.mj_header endRefreshing];
        }
        XF_Define_Strong
        [[EventHandler fetchDogs:4] subscribeNext:^(NSArray<NSIndexPath *> *indexPaths) {
            [_tableView.mj_footer endRefreshing];
            if (!indexPaths) {
                return;
            }
            // 局部插入行
            [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        }];
    }];
            _tableView.mj_footer = extractedExpr;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventHandler.expressPack.expressPieces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TODOCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    RACDogItem *item = self.eventHandler.expressPack.expressPieces[indexPath.row];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.url]];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = [UIColor redColor];//Color_EEEEEE;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 140.f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TODOCellId"];
    }
    return _tableView;
}


@end
