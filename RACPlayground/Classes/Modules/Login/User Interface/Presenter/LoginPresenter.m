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
//#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<LoginInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<LoginUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<LoginWireFramePort>)

@interface LoginPresenter ()

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
    // 当命令触发时执行代码
    XF_CEXE_(self.loginCommand, {
        // TODO
        [self loginAction];
    })
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
