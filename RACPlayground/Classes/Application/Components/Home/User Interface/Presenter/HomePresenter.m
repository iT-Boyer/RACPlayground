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
    
    XFRenderData *data = [XFRenderData new];
    data.list = [NSMutableArray new];
    XF_SetExpressPack_(XFExpressPack, data);
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
//    XF_CEXE_(self.backCommand, {
        // TODO
        //返回方式一
//        [self popViewAction];
//        [self dismissViewAction];
        //返回方式二
//        [self.routing popComponent];
//        [self.routing dismissComponent];
//    })
    XF_CEXE_(self.setCommand, {
        //进入设置页面
        NSLog(@"进入设置页面");
        [Routing transition2Setting];
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
-(RACSignal *)fetchDogs:(NSInteger)random
{
    
    return [[Interactor fetchDogs:4] map:^id(XFRenderData *data) {
        return XF_CreateIndexPaths_Last_Fast(data);
    }];
}

-(void)transition2Detail:(NSString *)imgUrl
{
    self.intentData = imgUrl;
    [Routing transition2Detail:imgUrl];
}


#pragma mark - ValidData


@end
