//
//  LoginRouting.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//


#import "LoginRouting.h"

@implementation LoginRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
- (void)transition2homeWith:(NSString *)userId
{
//    XF_PUSH_URLComponent_Fast(@"xxx:index/user?id=151&name=yizzuide")
    //nav
    //navC=自定义的导航控制器类名
    //navTitle=导航名  @"rac://Home?nav=UI"
    //XF_URL_支持动态编码参数,
    NSString *url = XF_URL_(@"rac://home", (@{
                              @"id":userId
                              }));
    XF_Present_URLComponent_Fast(url)
    
    //自定义样式： 不需要动画时
//    self.uiBus openURL:@"rac://xxx" onWindow:<#(nonnull UIWindow *)#> customCode:<#^(__kindof UIViewController * _Nonnull nextInterface)customCodeBlock#>
    [self.uiBus openURL:@"rac://xxx" withTransitionBlock:^(__kindof UIViewController * _Nonnull thisInterface, __kindof UIViewController * _Nullable nextInterface, TransitionCompletionBlock  _Nonnull completionBlock) {
        //        [thisInterface.navigationController pushViewController:nextInterface animated:NO];
        [thisInterface presentViewController:nextInterface animated:NO completion:nil];
        // 不要在这里写退出操作，这里只封装进入下一个组件的方法。
//        [thisInterface.navigationController popViewControllerAnimated:NO];
//        [thisInterface dismissViewControllerAnimated:NO completion:nil];
    } customCode:^(__kindof UIViewController * _Nonnull nextInterface) {
        //自定义
        UIViewController *viewC = nextInterface;
    }];
}
@end
