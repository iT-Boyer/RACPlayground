//
//  HomeRouting.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//


#import "HomeRouting.h"
#import "RACDetailViewController.h"

@implementation HomeRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
/*- (void)transition2XXX
{
    XF_PUSH_URLComponent_Fast(@"xxx://index/user?id=151&name=yizzuide")
}*/

-(void)transition2Setting
{
    XF_PUSH_Component_Fast(@"rac://Home/RACSet")
}

- (void)transition2Detail:(NSString *)imgUrl
{
    //
//    RACDetailViewController *detail = [RACDetailViewController new];
//    [LEMVVMConnector makeComponentFromUInterface:detail forName:@"detail" intentData:@{@"imgUrl":imgUrl}];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detail];
//    [self.realUInterface presentViewController:nav animated:YES completion:nil];
//    return;
    //出现bug：https://github.com/yizzuide/XFLegoVIPER/issues/12
//    XF_PUSH_Component_Fast(@"rac://Home/detail")
    XF_Present_URLComponent_Fast(@"rac://Home/detail")
    return;
    XF_PUSH_Component_Fast(XF_URL_(@"rac://Home/RACDetail", (@{
                                                                @"imgUrl":imgUrl
                                                             })
                                   )
                           )
}
@end
