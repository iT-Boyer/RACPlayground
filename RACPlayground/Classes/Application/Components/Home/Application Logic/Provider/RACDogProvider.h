//
//  RACDogProvider.h
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class RACDogItem;
@interface RACDogProvider : NSObject
+(NSArray<RACDogItem *> *)fetchDogRandom:(NSArray *)models;
@end

NS_ASSUME_NONNULL_END
