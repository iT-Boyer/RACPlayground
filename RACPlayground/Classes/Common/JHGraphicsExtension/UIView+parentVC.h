//
//  UIView+parentVC.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/6/14.
//  Copyright © 2018年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (parentVC)
/**
 过滤View对应控制器
 @return view对应的控制器
 */
- (UIViewController *)parentViewController;

@end
