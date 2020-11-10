//
//  LoginRouting.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//


#import "LoginRouting.h"
#import "RWViewController.h"
#import "UIViewController+topmost.h"
@implementation LoginRouting

// 组装模块
XF_AutoAssemblyModule_Fast

//原生跳转到金和组件
-(void)transition2JHVC
{
//    RWViewController *racVC = [RWViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:racVC];
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = [main instantiateInitialViewController];
    [[UIViewController topMostController] presentViewController:nav animated:NO completion:nil];
}

///跳转到MVVM框架：注册账号
-(void)transition2registerWith:(NSString *)name
{
    //nav
    XF_Present_URLComponent_(@"rac://RACRegister?nav=UI", {
        NSLog(@"导航条：%@",nextInterface.navigationController);
        nextInterface.title = @"注册d d";
        nextInterface.modalPresentationStyle = UIModalPresentationFullScreen;
    })
    return;
    NSString *url = XF_URL_(@"rac://RACRegister", (@{@"nav":@"UI",
                                                  @"navTitle":@"注册",
                                                  @"userName":name
                                                }));
    [self.uiBus openURLForPresent:url customCode:^(__kindof UIViewController * _Nonnull nextInterface) {
        nextInterface.title = @"注册d d";
        nextInterface.modalPresentationStyle = UIModalPresentationFullScreen;
    }];
    return;
    
    
}

// 跳转组件
- (void)transition2homeWith:(NSString *)userId
{
//    XF_PUSH_URLComponent_Fast(@"xxx:index/user?id=151&name=yizzuide")
    //nav
    //navC=自定义的导航控制器类名
    //navTitle=导航名  @"rac://Home?nav=UI"
    //XF_URL_支持动态编码参数,
    NSString *url = XF_URL_(@"rac://Home", (@{
                              @"id":userId
                              }));
//    XF_Present_URLComponent_Fast(url)
    XF_PUSH_URLComponent_Fast(url)
    
    //自定义样式： 不需要动画时
//    [self.uiBus openURL:@"rac://xxx" withTransitionBlock:^(__kindof UIViewController * _Nonnull thisInterface, __kindof UIViewController * _Nullable nextInterface, TransitionCompletionBlock  _Nonnull completionBlock) {
//        //        [thisInterface.navigationController pushViewController:nextInterface animated:NO];
//        [thisInterface presentViewController:nextInterface animated:NO completion:nil];
//        // 不要在这里写退出操作，这里只封装进入下一个组件的方法。
////        [thisInterface.navigationController popViewControllerAnimated:NO];
////        [thisInterface dismissViewControllerAnimated:NO completion:nil];
//    } customCode:^(__kindof UIViewController * _Nonnull nextInterface) {
//        //自定义
//        UIViewController *viewC = nextInterface;
//    }];
}
@end
