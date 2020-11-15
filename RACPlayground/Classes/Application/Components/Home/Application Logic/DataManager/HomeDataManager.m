//
//  HomeDataManager.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//


#import "HomeDataManager.h"
#import "PublicApiService.h"
@interface HomeDataManager ()

@property (strong, nonatomic) PublicApiService *service;
@end

@implementation HomeDataManager
-(void)fetchRandom:(NSInteger)random
{
    [self.service fetchRandomDogs:random];
}

#pragma mark - getter
-(PublicApiService *)service
{
    if (!_service) {
        _service = [PublicApiService new];
    }
    return _service;
}
@end
