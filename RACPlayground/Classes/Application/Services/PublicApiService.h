//
//  PublicApiService.h
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/15.
//

#import <Foundation/Foundation.h>
#import "RACHttpRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface PublicApiService : NSObject
///随机获取图片个数
-(RACSignal *)fetchRandomDogs:(NSInteger)random;
@end

NS_ASSUME_NONNULL_END
