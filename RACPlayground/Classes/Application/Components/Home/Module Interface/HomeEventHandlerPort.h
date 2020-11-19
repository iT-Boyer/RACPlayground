//
//  HomeEventHandlerPort.h
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//

#import <Foundation/Foundation.h>
#import "XFEventHandlerPort.h"

@protocol HomeEventHandlerPort <XFEventHandlerPort>
@property (strong, nonatomic) RACCommand *setCommand;
-(RACSignal *)fetchDogs:(NSInteger)random;

//跳转到详情
- (void)transition2Detail:(NSString *)imgUrl;
@end
