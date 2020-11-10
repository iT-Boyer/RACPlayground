//
//  HomePresenter.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//

#import "HomePresenter.h"
#import "HomeWireframePort.h"
#import "HomeUserInterfacePort.h"
#import "HomeInteractorPort.h"
//#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<HomeInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<HomeUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<HomeWireFramePort>)

@interface HomePresenter ()

@end

@implementation HomePresenter

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
    XF_CEXE_(self.backCommand, {
        // TODO
        //返回方式一
        [self popViewAction];
//        [self dismissViewAction];
        //返回方式二
//        [self.routing popComponent];
//        [self.routing dismissComponent];
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



#pragma mark - ValidData


@end
