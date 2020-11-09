//
//  LoginInteractorPort.h
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"

@protocol LoginInteractorPort <XFInteractorPort>
//登录
-(RACSignal *)signInAction:(NSString *)name pwd:(NSString *)pwd;
@end
