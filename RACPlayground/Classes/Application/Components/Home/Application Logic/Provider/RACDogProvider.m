//
//  RACDogProvider.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/15.
//

#import "RACDogProvider.h"
#import "RACDogItem.h"
#import "RACDogModel.h"
#import "XFRenderData.h"
@implementation RACDogProvider

+(XFRenderData *)fetchDogRandom:(RACDogModel *)model
{
    XFRenderData *data = [XFRenderData new];
    data.list = [model.message.rac_sequence map:^id(NSString *url) {
        RACDogItem *item = [RACDogItem new];
        item.url = url;
        return item;
    }];
    return data;
}
@end
