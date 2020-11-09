//
//  RACHttpRequest.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/9.
//

#import "RACHttpRequest.h"
#import <AFNetworking3_RACExtensions/AFHTTPSessionManager+RACSupport.h>

//abs隔离层，封装AFNetWork第三方库
@implementation RACHttpRequest


+(RACSignal *)postWithURL:(NSString *)url params:(NSDictionary *)params
{
    return [RACHttpRequest postWithHeaders:nil url:url params:params];
}

+(RACSignal *)postWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (headers) {
        NSArray *keys = headers.allKeys;
        NSUInteger count = keys.count;
        for (int i = 0; i < count; i++) {
            NSString *key = keys[i];
            NSString *value = [headers valueForKey:key];
            [[manager requestSerializer] setValue:value forKey:key];
        }
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    RACSignal *result = [manager rac_POST:url parameters:params];
    return result;
}

@end
