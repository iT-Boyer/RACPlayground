//
//  RACDetailViewModel.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/19.
//  
//

#import "RACDetailViewModel.h"
#import "RACDetailViewProtocol.h"

#define View LEGORealPort(id<RACDetailViewProtocol>, self.view)

@interface RACDetailViewModel ()

@end

@implementation RACDetailViewModel

#pragma mark - lifeCycle
// 绑定视图层后调用
- (void)viewDidLoad
{
    // 解构URL参数
    
    self.expressData = self.componentData;
}

// 初始化视图数据
- (void)initRenderView
{
    
}

// 初始化命令
- (void)initCommand
{
    /*XF_CEXE_Begin
     // 当命令触发时执行代码
     XF_CEXE_(self.command, {
     // TODO
     })*/
}

// 接收到组件返回数据
- (void)onNewIntent:(id)intentData
{
    NSLog(@"接收到的数据：%@",intentData);
}

// 注册MVx通知
- (void)registerMVxNotifactions
{
    // 注册MVx构架通知
    //    XF_RegisterMVxNotis_(XFUserDidLoginNotifaction)
}


// 接受到MVx构架通知或组件的事件
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(XFUserDidLoginNotifaction, {
     // TODO
     })*/
}

#pragma mark - DoAction



#pragma mark - ValidData



#pragma mark - FetchData
@end
