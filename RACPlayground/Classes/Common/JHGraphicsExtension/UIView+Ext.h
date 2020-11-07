//
//  UIView+Ext.h
//
//  Created by jh on 2019/4/30.
//  Copyright © 2019.chaizhiyong All rights reserved.
//
#import <UIKit/UIKit.h>
/**
 *  UIView Frame操作
 */
@interface UIView (Frame)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft; //左下角点位置
@property (readonly) CGPoint bottomRight;//右下角点位置
@property (readonly) CGPoint topRight;//右上角点位置

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;  //定点y值
@property CGFloat left; //定点x值

@property CGFloat bottom;//左下角y值
@property CGFloat right;//左下角x值

// 简化设置
- (CGFloat)frameHight;
- (CGFloat)frameWidth;
- (CGFloat)originX;
- (CGFloat)originY;
- (CGPoint)frameOrigin;
- (CGSize)frameSize;
//缩放
- (void)uniformScale;

- (void)setFrameHight:(CGFloat)hight;
- (void)setFrameWidth:(CGFloat)width;
- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;
- (void)setFrameSize:(CGSize)size;

@end

/**
 *  手势
 */
typedef void (^JMWhenTappedBlock)(void);
@interface UIView (JMWhenTappedBlocks) <UIGestureRecognizerDelegate>

/**
 单次点击
 @param block 回调
 */
- (void)whenTapped:(JMWhenTappedBlock)block;
/**
 点击两次
 @param block 回调
 */
- (void)whenDoubleTapped:(JMWhenTappedBlock)block;
/**
 两根手指
 @param block 回调
 */
- (void)whenTwoFingerTapped:(JMWhenTappedBlock)block;
/**
 按下手指
 @param block 回调
 */
- (void)whenTouchedDown:(JMWhenTappedBlock)block;
/**
 抬起手指
 @param block 回调
 */
- (void)whenTouchedUp:(JMWhenTappedBlock)block;

@end
/**
 *  从Nib加载
 */
@interface UIView (creat)

/**
 通过nib创建UIView
 @param className 类名
 @return  UIView实例对象
 */
+ (instancetype)classFromNib:(NSString *)className;
/**
 代码创建View
 @param frame View大小
 @return  className 类名
 */
+ (instancetype)viewFromFrame:(CGRect)frame className:(NSString *)className;
/**
 返回父控件
 */
- (UIViewController *)findViewController;
/**
 查找父控件
 @param className 类名
 @return  sourceView 源View
 */
+ (id)findViewWithClassName: (Class)className view:(UIView *)sourceView;

@end

@interface UIView (vconvert)
/*
  使用该方法不会模糊，根据屏幕密度计算
  @return  view转image
 */
- (UIImage *)convertViewToImage;

@end

@interface UIView (LSCore)

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

@end
