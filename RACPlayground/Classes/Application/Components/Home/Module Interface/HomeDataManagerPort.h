//
//  HomeDataManagerPort.h
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/2.
//  
//

#import <Foundation/Foundation.h>
#import "XFDataManagerPort.h"

@protocol HomeDataManagerPort <XFDataManagerPort>
///随机获取图片
-(void)fetchRandom:(NSInteger)random;
@end
