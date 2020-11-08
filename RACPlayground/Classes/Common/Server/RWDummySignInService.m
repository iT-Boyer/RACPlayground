//
//  RWDummySignInService.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWDummySignInService.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking-RACExtensions-umbrella.h>

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
    RACSignal *signIn = [RWDummySignInService postWithURL:@"" params:@{
                                                                       @"user":name,
                                                                       @"name":pwd
                                                                       }];
    RACSignal *result = [signIn map:^id(NSNumber *value) {
        NSLog(@"ccc%@",value);
        return [NSNumber numberWithBool:true];
    }];
    return result;
}


+ (RACSignal *)postWithURL:(NSString *)url params:(NSDictionary *)params
{
    return [self postWithHeaders:nil url:url params:params];
}

+ (RACSignal *)postWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (headers) {
        NSArray *keys = headers.allKeys;
        NSUInteger count = keys.count;
        for (int i = 0; i < count; i++) {
            NSString *key = keys[i];
            NSString *value = [headers valueForKey:key];
            [[manager requestSerializer] setValue:value forHTTPHeaderField:key];
        }
    }
    
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    RACSignal *result = [manager rac_POST:url parameters:params];
    return result;
}

@end
