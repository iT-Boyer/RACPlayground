//
//  HomeInteractorPort.h
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"
#import "XFRenderData.h"
@protocol HomeInteractorPort <XFInteractorPort>
-(XFRenderData *)fetchDogs:(NSInteger)random;
@end
