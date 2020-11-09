//
//  RWDummySignInService.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWDummySignInService.h"
#import "RACHttpRequest.h"

#define Login @"https://jinher.com/Login"

@implementation RWDummySignInService


- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock {

    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        BOOL success = [username isEqualToString:@"user"] && [password isEqualToString:@"123456"];
        completeBlock(success);
    });
}

//- (RACSignal *)pullRecommendCategory {
//    return [[BDJHttpRequest getWithURL:API_Main
//                                params:@{
//                                         @"a":@"category",
//                                         @"c":@"subscribe"
//                                         }]
//            map:^id(RACTuple *tuple) {
//                return [BDJRecommendCategoryModel mj_objectArrayWithKeyValuesArray:tuple.first[@"list"]];
//            }];
//}

-(RACSignal *)signInWithUserName:(NSString *)name password:(NSString *)pwd
{
    RACSignal *signIn = [RACHttpRequest postWithURL:Login params:@{
                                                                       @"user":name,
                                                                       @"name":pwd
                                                                       }];
    RACSignal *result = [signIn map:^id(NSNumber *value) {
        NSLog(@"Login接口放回数据：%@",value);
        return [NSNumber numberWithBool:true];
    }];
    return result;
}

@end
