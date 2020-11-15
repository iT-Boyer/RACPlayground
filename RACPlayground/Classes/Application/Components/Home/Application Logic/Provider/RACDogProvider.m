//
//  RACDogProvider.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/15.
//

#import "RACDogProvider.h"
#import "RACDogItem.h"
#import "RACDogModel.h"
@implementation RACDogProvider

+(NSArray<RACDogItem *> *)fetchDogRandom:(NSArray *)models
{
    return [[models.rac_sequence map:^id(RACDogModel *model) {
        RACDogItem *item = [RACDogItem new];
        item.url = model.url;
        return item;
    }] array];
}
@end
