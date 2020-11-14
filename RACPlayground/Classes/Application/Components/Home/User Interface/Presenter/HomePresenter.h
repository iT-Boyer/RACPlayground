//
//  HomePresenter.h
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//

#import "HomeEventHandlerPort.h"
#import "XFPresenter.h"


@interface HomePresenter : XFPresenter <HomeEventHandlerPort>
@property (strong, nonatomic) RACCommand *setCommand;
@end
