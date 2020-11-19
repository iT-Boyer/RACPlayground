//
//  UIImage+Util.h
//  AT
//
//  Created by xiao6 on 14-11-5.
//  Copyright (c) 2014年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

/**
 * 缩放图片
 * @param newSize 尺寸大小
 * @return 新图片对象
 */
- (UIImage *)scaledToSize:(CGSize)newSize;
 
/**
 * 旋转图片
 * @return 新图片对象
 */
- (UIImage *)fixOrientation;
/**
 * 通过图片名称返回拉伸后图片，拉伸位置 left = 0.5 top = 0.5
 * @param name 图片名称
 * @return 新图片对象
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
/**
 * 通过图片名称返回拉伸后图片，拉伸位置
 * @param name 图片名称
 * @param left 图片左边位置
 * @param top 图片上边位置
 * @return  新图片对象
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 * 磨砂图片
 * @param blurAmount 模糊程度
 * @return 处理后图片对象
 */
- (UIImage*)blurredImage:(CGFloat)blurAmount;
/**
 * 通过色值创建图片
 * @param color 色值对象
 * @return 处理后图片对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 * 截屏
 * @return 截屏后图片
 */
+ (UIImage *)screenshot;

- (CGFloat)bestJPEGWithexpectSize:(long)expectSize;
- (CGFloat)bestJPEGCompressionQuality;
- (NSData*)bestJPEGRepresentation;
/**
 * 图片数组转Gif图
 * @return Gif图
 */
+ (UIImage *)combineWithImages:(NSArray<UIImage *> *)images;
/**
 * 图片合成
 * @param leftImage 图片
 * @param rightImage 图片
 * @return 合成后图片
 */
+ (UIImage *)combine:(UIImage *)leftImage :(UIImage *)rightImage;


// 给图片添加文字水印
-(UIImage *)addWaterByPattern:(NSAttributedString *)text;
    
@end
