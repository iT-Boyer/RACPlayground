//
//  HomeWireframePort.h
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//

#import <Foundation/Foundation.h>
#import "XFWireFramePort.h"

@protocol HomeWireFramePort <XFWireFramePort>
- (void)transition2Setting;
- (void)transition2Detail:(NSString *)imgUrl;
@end
