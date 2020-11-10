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
- (void)transition2registerWith:(NSString *)name;
- (void)transition2JHVC;
@end
