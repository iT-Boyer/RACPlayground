//
//  LoginDataManagerPort.h
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//

#import <Foundation/Foundation.h>
#import "XFDataManagerPort.h"

@protocol LoginDataManagerPort <XFDataManagerPort>
-(RACSignal *)signInAction:(NSString *)name pwd:(NSString *)pwd;
@end
