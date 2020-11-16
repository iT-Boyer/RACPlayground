//
//  RACDogProvider.h
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/15.
//

#import <Foundation/Foundation.h>
#import "XFRenderData.h"
NS_ASSUME_NONNULL_BEGIN
@class RACDogModel;
@interface RACDogProvider : NSObject
+(XFRenderData *)fetchDogRandom:(RACDogModel *)models;
@end

NS_ASSUME_NONNULL_END
