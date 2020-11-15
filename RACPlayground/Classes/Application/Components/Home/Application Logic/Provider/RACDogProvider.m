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

+(XFRenderData *)fetchDogRandom:(NSArray *)models
{
    XFRenderData *data = [XFRenderData new];
    data.list = [models.rac_sequence map:^id(RACDogModel *model) {
        RACDogItem *item = [RACDogItem new];
        item.url = model.url;
        return item;
    }];
    
    return data;
}
@end
