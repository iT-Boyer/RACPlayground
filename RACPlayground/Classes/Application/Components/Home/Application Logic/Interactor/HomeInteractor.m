//
//  HomeInteractor.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//

#import "HomeInteractor.h"
#import "HomeDataManagerPort.h"
#import "RACDogProvider.h"
#define DataManager XFConvertDataManagerToType(id<HomeDataManagerPort>)

@interface HomeInteractor ()

@end

@implementation HomeInteractor

#pragma mark - Request
/*- (RACSignal *)fetchData
{
    [DataManager setPrefKey:@"PK_User_id" value:@"123"];
    return [RACSignal return:@""];
}*/
-(RACSignal *)fetchDogs:(NSInteger)random
{
    return [[DataManager fetchRandom:4] map:^id(NSArray *models) {
        return [RACDogProvider fetchDogRandom:models];
    }];
}

#pragma mark - BusinessReduce


#pragma mark - ConvertData


@end
