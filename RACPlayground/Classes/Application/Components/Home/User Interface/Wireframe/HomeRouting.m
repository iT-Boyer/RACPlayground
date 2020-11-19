//
//  HomeRouting.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//


#import "HomeRouting.h"

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
    XF_PUSH_Component_Fast(@"rac://Home/RACDetail")
    return;
    XF_PUSH_Component_Fast(XF_URL_(@"rac://Home/RACDetail", (@{
                                                                @"imgUrl":imgUrl
                                                             })
                                   )
                           )
}
@end
