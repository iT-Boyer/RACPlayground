//
//  UIViewController+topmost.h
//  JHUniversalApp
//
//  Created by  William Sterling on 15/8/3.
//  Copyright (c) 2015年  William Sterling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (topmost)

/**
 *  返回上一级控制器
 *
 *  @return 上一级控制器
 */
+ (UIViewController*) topMostController;

/**
 *  回到根控制器
 *
 *  @return 根控制器
 */
+ (id)getRootController;

/**
 *  回到主界面
 *
 *  @param view 当前显示的视图
 *  @param vc 当前显示的视图控制器
 */
+ (void)backToHostController:(UIView *)view viewController:(UIViewController *)vc;
/**
 *  回到主界面
 *
 *  @param view 当前显示的试图
 */
+ (void)backToHostController:(UIView *)view;

/**
 *  打开H5
 *
 *  @param serverUrl 远程URL
 *  @param localUrl 本地url
 */
+ (void)openUrlWithServerUrl:(NSString *)serverUrl localUrl:(NSString *)localUrl;
@end
