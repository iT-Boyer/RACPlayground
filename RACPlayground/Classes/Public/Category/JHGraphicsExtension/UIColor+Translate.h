//
//  UIColor+Translate.h
//  JHUniversalApp
//
//  Created by pk on 2016/11/30.
//  Copyright © 2016年  William Sterling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Translate)

/**
 色值操作
 @param inColorString 色值
 @param alpha 透明度
 @return 返回色值对象
 */
+(UIColor *)colorFromHexRGB:(NSString *)inColorString alpha:(float)alpha;
    
/**
 色值操作
 @param inColorString 色值
 @return 返回色值对象
 */
+(UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end
