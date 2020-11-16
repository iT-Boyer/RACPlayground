//
//  PublicApiService.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/15.
//

#import "PublicApiService.h"
#import "RACDogModel.h"

//https://dog.ceo/api/breeds/image/random/3
#define dogs @"https://dog.ceo/api/breed/hound/afghan/images/random/3"

@implementation PublicApiService

-(RACSignal *)fetchRandomDogs:(NSInteger)random
{
    //
    return [[RACHttpRequest getWithURL:dogs params:@{}] map:^id(RACTuple *tuple) {
        
        NSDictionary *data = tuple.first;
        if (![tuple.first isKindOfClass:[NSDictionary class]]
            && [NSJSONSerialization isValidJSONObject:data]) {
            NSError *error;
            data = [NSJSONSerialization JSONObjectWithData:data
                                                   options:kNilOptions
                                                     error:&error];
        }
        
//        NSArray *msgs = [data objectForKey:@"message"];
//        NSArray<RACDogModel *> *models = [RACDogModel arrayOfModelsFromData:msgs error:nil];
        RACDogModel *dogss = [[RACDogModel alloc] initWithDictionary:data error:nil];
        return dogss;
    }];
}
@end
