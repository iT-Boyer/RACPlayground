//
//  UIImage+ResizeImage.m
//  HelpSell
//
//  Created by pk on 2017/2/6.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "UIImage+ResizeImage.h"

@implementation UIImage (ResizeImage)

//压图片
//1）图片大于2M的，将压缩系数调整到0.7
//2）图片在0.5M<image<2M,将压缩系数调整到0.8
//3）图片小于0.5M，压缩系数可以写0.9或者1
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像的画面质量压
    NSData *data=UIImageJPEGRepresentation(sourceImage, 1.0);
    if (data.length>512*1024) {
        if (data.length>2 * 1024*1024) {//2M以及以上
            data=UIImageJPEGRepresentation(sourceImage, 0.7);
        }else  {//0.5M-2M
            data=UIImageJPEGRepresentation(sourceImage, 0.8);
        }
    }
    return data;
}
//1）宽高均大于1280，取较大值等于1280，较大值等比例压缩
//2）宽或高一个大于1280，取较大的等于1280，较小的等比压缩
//3）宽高均小于1280，压缩比例不变
+(UIImage *)zipScaleWithImage:(UIImage *)sourceImage  maxValue:(CGFloat) value {
    //进行图像尺寸的压缩
    CGFloat compareValue = value > 0 ? value:1280;
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>compareValue||height>compareValue) {
        if (width>height) {
            CGFloat scale = height/width;
            width = compareValue;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = compareValue;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>compareValue||height<compareValue){
        CGFloat scale = height/width;
        width = compareValue;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<compareValue||height>compareValue){
        CGFloat scale = width/height;
        height = compareValue;
        width = height*scale;
        //4.宽高都小于1280
    }
    //进行尺寸重绘
    // UIGraphicsBeginImageContext(CGSizeMake(width, height));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [UIScreen mainScreen].scale);//强烈建议使用这种方法
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSData *)zipScaleNSDataWithImage:(UIImage *)sourceImage maxValue:(CGFloat)value {
    UIImage* image = [UIImage zipScaleWithImage:sourceImage maxValue:value];
    NSData* data = [UIImage zipNSDataWithImage:image];
    return data;
}
// 缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (!color || size.width <= 0 || size.height <= 0)
        return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
