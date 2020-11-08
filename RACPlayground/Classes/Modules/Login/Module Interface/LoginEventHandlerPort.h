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
@property (nonatomic, strong) RACCommand *loginCommand;
@property (strong, nonatomic) NSString *userName;

@property (strong, nonatomic) UIColor *userNameBackgroundColor;
@property (strong, nonatomic) UIColor *passwordBackgroundColor;

@property (strong, nonatomic) RACCommand *userValidCommand;
@property (strong, nonatomic) RACCommand *pwdValidCommand;

@property (nonatomic, strong) RACCommand *mvcCommand;
@end
