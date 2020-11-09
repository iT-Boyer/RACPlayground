//
//  UIView+WaterMark.h
//  WaterMarkDemo
//
//  Created by jinher on 2018/6/25.
//  Copyright © 2018年 wsk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WaterMark)

/**
* 创建水印
* @param text 文案
* @param photo 底图
* @return 水印图
*/
- (UIImage *)addWatemarkText:(NSString *)text Photo:(UIImage *)photo;

@end
