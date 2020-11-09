//
//  UIImage+ResizeImage.h
//  HelpSell
//
//  Created by pk on 2017/2/6.
//  Copyright © 2017年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeImage)
/**
 *  压缩图片
 *
 *  @param sourceImage   image source
 *  @param maxValue  宽或高最大值
 *
 *  @return resizeImage
 */
+(NSData *)zipScaleNSDataWithImage:(UIImage *)sourceImage maxValue:(CGFloat)value;
/**
 *  压缩图片
 *
 *  @param image   image source
 *  @param newSize size for image
 *
 *  @return resizeImage
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
    
/**
 * 色值转图片
 *
 * @param color 色值对象
 * @param size 尺寸大小
 *
 * @return 返回图片对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
    
@end
