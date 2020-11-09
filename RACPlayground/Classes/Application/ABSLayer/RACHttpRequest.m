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
    [RACHttpRequest installTextStub:[[NSURL URLWithString:url] host]];
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

+(void)installTextStub:(NSString *)host
{
    //    __weak JHURLRequest *weakself = self;
    textStub = [HTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        // This stub will only configure stub requests for "*.txt" files
        //        return [request.URL.pathExtension isEqualToString:@"txt"];
        return [request.URL.host isEqualToString:host];
    } withStubResponse:^HTTPStubsResponse *(NSURLRequest *request) {
        // Stub txt files with this
        NSString *urlStr = request.URL.path;
        NSString *fileName = [[urlStr lastPathComponent] stringByAppendingString:@".json"];
        NSString *filePath = OHPathForFile(fileName, self.class);
        return [[HTTPStubsResponse responseWithFileAtPath:filePath
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"application/json"}]
                requestTime:2.f
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }];
    textStub.name = @"Text stub";
    
    [HTTPStubs onStubActivation:^(NSURLRequest * _Nonnull request, id<HTTPStubsDescriptor>  _Nonnull stub, HTTPStubsResponse * _Nonnull responseStub) {
        NSLog(@"[OHHTTPStubs] Request to %@ has been stubbed with %@", request.URL, stub.name);
    }];
}
@end
