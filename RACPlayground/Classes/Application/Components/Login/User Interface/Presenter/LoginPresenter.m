//
//  LoginPresenter.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//

#import "LoginPresenter.h"
#import "LoginWireframePort.h"
#import "LoginUserInterfacePort.h"
#import "LoginInteractorPort.h"


#import "RWDummySignInService.h"

#define Interactor XFConvertInteractorToType(id<LoginInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<LoginUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<LoginWireFramePort>)

@interface LoginPresenter ()
@property (strong, nonatomic) RWDummySignInService *signInService;
@end

@implementation LoginPresenter

#pragma mark - lifeCycle
// 绑定视图层后调用
- (void)viewDidLoad
{
    // 解构URL参数
//    NSInteger userID = self.URLParams[@"id"];
}

// 初始化视图数据
- (void)initRenderView
{
    // 填充绑定的ViewData
    //self.viewData = [Interactor fetchData];
}

// 初始化命令
- (void)initCommand
{
    XF_CEXE_Begin
    //跳转MVC
    XF_CEXE_(self.mvcCommand, {
        [Routing transition2JHVC];
    })
    
    self.signInService = [RWDummySignInService new];
    // 当命令触发时执行代码
    XF_CEXE_(self.loginCommand, {
        // TODO
        //隐藏键盘
//        [self dismissKeyboard];
        //意图数据，可以传递任何对象
        self.intentData = self.userName;
        // 返回信号 ：从展示层返回给视图层，视图层监听信号返回的数据。
        RACSignal *result = [Interactor signInAction:self.userName pwd:self.password];
        [result subscribeNext:^(NSNumber *result) {
            if (result.boolValue) {
                [Routing transition2homeWith:@""];
            }
        }];
        return result;
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //异步访问网络，请求服务器数据
            [self.signInService signInWithUsername:self.userName password:self.password complete:^(BOOL success) {
                [subscriber sendNext:@(success)];
                if (success) {
                    //登录成功进入home
                    [Routing transition2homeWith:@"useriiii"];
                }
                [subscriber sendCompleted];
            }];
            
//            [subscriber sendNext:@"完成"];
//            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"当前信号已中止！");
            }];
        }];
    })
    /* 上述代码 等价于
    XF_Define_Weak
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        XF_Define_Strong
        NSLog(@"登录");
        return [RACSignal empty];
    }];
     */
}

// 接收到组件返回数据
- (void)onNewIntent:(id)intentData
{
    
}

// 注册MVx通知
- (void)registerMVxNotifactions
{
    // 注册MVx构架通知
//    XF_RegisterMVxNotis_(XFUserDidLoginNotifaction)
}


// 接受到MVx构架通知或XFLegoVIPER模块的事件
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(XFUserDidLoginNotifaction, {
        // TODO
    })*/
}

#pragma mark - DoAction
-(void)loginAction
{
    NSLog(@"点击了登录按钮，开始登录...");
    
}


#pragma mark - ValidData


@end
