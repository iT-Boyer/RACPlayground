//
//  LoginEventHandlerPort.h
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//

#import <Foundation/Foundation.h>
#import "XFEventHandlerPort.h"

@protocol LoginEventHandlerPort <XFEventHandlerPort>

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;

@property (nonatomic, strong) RACCommand *loginCommand;
@property (strong, nonatomic) RACCommand *registerCommand;

@property (nonatomic, strong) RACCommand *mvcCommand;
@end
