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
@end
