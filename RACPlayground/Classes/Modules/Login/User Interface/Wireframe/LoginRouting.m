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
- (void)transition2home
{
//    XF_PUSH_URLComponent_Fast(@"xxx:index/user?id=151&name=yizzuide")
    XF_Present_URLComponent_Fast(@"rac://Home?nav=UI")
}
@end
