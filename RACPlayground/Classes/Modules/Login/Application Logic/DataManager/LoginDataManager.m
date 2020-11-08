//
//  LoginDataManager.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//


#import "LoginDataManager.h"
#import "RWDummySignInService.h"
@interface LoginDataManager ()
@property (strong, nonatomic) RWDummySignInService *signInService;
@end

@implementation LoginDataManager

-(RACSignal *)signInAction:(NSString *)name pwd:(NSString *)pwd
{
    return [self.signInService signInWithUserName:name password:pwd];
    
    return nil;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //异步访问网络，请求服务器数据
        [self.signInService signInWithUsername:name password:pwd complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            if (success) {
                //登录成功进入home
//                [Routing transition2homeWith:@"useriiii"];
            }
            [subscriber sendCompleted];
        }];
        
        //            [subscriber sendNext:@"完成"];
        //            [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"当前信号已中止！");
        }];
    }];
}

#pragma mark - getter
-(RWDummySignInService *)signInService
{
    if (!_signInService) {
        _signInService = [RWDummySignInService new];
    }
    return _signInService;
}
@end
