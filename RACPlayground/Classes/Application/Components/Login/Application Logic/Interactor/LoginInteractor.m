//
//  LoginInteractor.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//

#import "LoginInteractor.h"
#import "LoginDataManagerPort.h"

#define DataManager XFConvertDataManagerToType(id<LoginDataManagerPort>)

@interface LoginInteractor ()

@end

@implementation LoginInteractor

#pragma mark - Request

-(RACSignal *)signInAction:(NSString *)name pwd:(NSString *)pwd
{
    return [DataManager signInAction:name pwd:pwd];
}

/*- (RACSignal *)fetchData
{
    [DataManager setPrefKey:@"PK_User_id" value:@"123"];
    return [RACSignal return:@""];
}*/


#pragma mark - BusinessReduce


#pragma mark - ConvertData


@end
