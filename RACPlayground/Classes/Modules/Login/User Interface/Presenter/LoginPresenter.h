//
//  LoginPresenter.h
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//

#import "LoginEventHandlerPort.h"
#import "XFPresenter.h"


@interface LoginPresenter : XFPresenter <LoginEventHandlerPort>

@property (nonatomic, strong) RACCommand *loginCommand;
@property (strong, nonatomic) NSString *userName;


@property (nonatomic, strong) RACCommand *mvcCommand;
@end
