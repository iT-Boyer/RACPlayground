//
//  PublicApiService.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/15.
//

#import "PublicApiService.h"
#import "RACDogModel.h"

#define dogs @"https://dog.ceo/api/breed/hound/afghan/images/random/3"

@implementation PublicApiService

-(RACSignal *)fetchRandomDogs:(NSInteger)random
{
    //
    [[RACHttpRequest getWithURL:dogs params:@{}] map:^id(RACTuple *tuple) {
        NSData *data = tuple.first;
        NSDictionary *dic = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:nil];
        NSArray *msgs = [dic objectForKey:@"message"];
        NSArray<RACDogModel *> *models = [RACDogModel arrayOfModelsFromData:msgs error:nil];//[[RACDogModel alloc] initWithData:data error:nil];
        return models;
    }];
    return nil;
}
@end
