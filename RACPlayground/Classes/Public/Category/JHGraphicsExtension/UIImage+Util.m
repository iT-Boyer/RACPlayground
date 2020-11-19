//
//  UIImage+Util.m
//  AT
//
//  Created by xiao6 on 14-11-5.
//  Copyright (c) 2014年 Summer. All rights reserved.
//

#import "UIImage+Util.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#import "UIView+Ext.h"

@implementation UIImage (Util)

- (UIImage *)scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    // Tell the old image to draw in this new context, with the desired new size
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}


#pragma mark -- imageFixOrientation
- (UIImage *)fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }

    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }

    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }

    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage*)blurredImage:(CGFloat)blurAmount
{
    if (blurAmount < 0.0 || blurAmount > 1.0) {
        blurAmount = 0.5;
    }

    int boxSize = (int)(blurAmount * 40);
    boxSize = boxSize - (boxSize % 2) + 1;

    CGImageRef img = self.CGImage;

    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;

    void *pixelBuffer;

    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);

    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);

    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);

    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));

    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    if (!error) {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

        if (!error) {
            vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        }
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);

    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);

    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    CGContextRelease(ctx);

    free(pixelBuffer);
    CFRelease(inBitmapData);

    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);

    return returnImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage *)screenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;

    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();

    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);

            CGContextTranslateCTM(context, [window center].x, [window center].y);

            CGContextConcatCTM(context, [window transform]);

            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);

            [[window layer] renderInContext:context];

            CGContextRestoreGState(context);
        }
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return image;
}
- (CGFloat)bestJPEGWithexpectSize:(long)expectSize {
    float compressionQuality = 0.5f;
    float compressionQualityMax = 1.0f, compressionQualityMin = 0.001f;
    long maxSize = expectSize * 1.1;
    long minSize = expectSize * 0.9;
    
    long long int size = [UIImageJPEGRepresentation(self, 1.0f) length];
    if (size < maxSize) {
        return 1.0f;
    }
    
    for (int i = 0; i < 8; i++) {
        size = [UIImageJPEGRepresentation(self, compressionQuality) length];
        if (size > maxSize) {
            compressionQualityMax = compressionQuality;
            compressionQuality = (compressionQuality + compressionQualityMin)/ 2;
        }
        else if (size < minSize) {
            compressionQualityMin = compressionQuality;
            compressionQuality = (compressionQuality + compressionQualityMax)/ 2;
        }
        else {
            break;
        }
    }
    return compressionQuality;
}
- (CGFloat)bestJPEGCompressionQuality {
    return [self bestJPEGWithexpectSize:100000];
}
- (NSData *)bestJPEGRepresentation {
    return UIImageJPEGRepresentation(self, [self bestJPEGCompressionQuality]);
}
+ (UIImage *)combineWithImages:(NSArray<UIImage *> *)images {
    UIImage *leftImage = images[0];
    UIImage *rightImage;
    for (int i = 0; i < images.count - 1; i++) {
        rightImage = images[i+1];
        leftImage = [UIImage combine:leftImage :rightImage];
    }
    return leftImage;
}
+ (UIImage *)combine:(UIImage *)leftImage :(UIImage *)rightImage {
    CGFloat width = leftImage.size.width + rightImage.size.width;
    CGFloat height = leftImage.size.height > rightImage.size.height ? leftImage.size.height : rightImage.size.height;
    CGSize offScreenSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(offScreenSize);
    
    CGRect rect = CGRectMake(0, (height - leftImage.size.height) / 2.0, leftImage.size.width, leftImage.size.height);
    [leftImage drawInRect:rect];
    
    rect = CGRectMake(leftImage.size.width, (height - rightImage.size.height) / 2.0, rightImage.size.width, rightImage.size.height);
    [rightImage drawInRect:rect];
    
    UIImage *combineImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return combineImage;
}

-(UIImage *)addWaterByPattern:(NSAttributedString *)text
{
    // 绘制单个水印
    UIImage *img = [self imageWithText:text];
//    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName:[UIColor whiteColor]};
//    UIImage *img = [self waterImageWithSize:CGSizeMake(150, 150) text:text.string attr:attr];
    // 平铺到view上
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    view.backgroundColor = [[UIColor alloc] initWithPatternImage:img];
    // 获取view截图
    UIImage *image = [self convertViewToImage:view];
    
    //合并
    return [self addImage:image toImage:self];
}

// 绘制单个水印
- (UIImage *)imageWithText:(NSAttributedString *)text{
    
    /**
     这里之所以外面再放一个UIView，是因为直接用label画图的话，旋转就不起作用了
     */
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.backgroundColor = [UIColor clearColor];
    label.attributedText = text;
    label.transform = CGAffineTransformMakeRotation(-M_PI/4.0);
    [view addSubview:label];
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
// 给图片添加文字水印：
- (UIImage *)waterImageWithSize:(CGSize)size text:(NSString *)text attr:(NSDictionary *)attr{
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
////    CGContextSetFillColorWithColor(context, [color CGColor]);
////    CGContextFillRect(context, rect);
//
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //2.绘制图片
    [[UIImage new] drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //添加水印文字
    [text drawAtPoint:CGPointMake(size.width/2.0, size.height/2.0) withAttributes:attr];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}
/// 合并
-(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    UIGraphicsBeginImageContext(image2.size);
    
    //Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    //Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resultImage;
}

//使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
    
}
@end
