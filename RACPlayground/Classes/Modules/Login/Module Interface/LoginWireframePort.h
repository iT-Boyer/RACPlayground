//
//  LoginWireframePort.h
//  RACPlayground
//
//  Created by jhmac on 2020/11/2.
//  
//

#import <Foundation/Foundation.h>
#import "XFWireFramePort.h"

@protocol LoginWireFramePort <XFWireFramePort>
- (void)transition2homeWith:(NSString *)userId;
@end
