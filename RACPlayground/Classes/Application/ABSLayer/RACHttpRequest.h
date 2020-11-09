//
//  RACHttpRequest.h
//  RACPlayground
//
//  Created by jhmac on 2020/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//abs隔离层，封装AFNetWork第三方库
@interface RACHttpRequest : NSObject
//post方法
+(RACSignal *)postWithURL:(NSString *)url params:(NSDictionary *)params;

+(RACSignal *)postWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params;

//get方法


@end

NS_ASSUME_NONNULL_END
