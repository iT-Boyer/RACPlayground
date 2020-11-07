//
//  UIButton+Ext.h
//  JHMyOrganization
//
//  Created by jh on 2019/6/11.
//  Copyright © 2019 chaizhiyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^JHButtonActionCallBack)(UIButton *button);

@interface UIButton (JHAddCallBackBlock)

- (void)setJHCallBack:(JHButtonActionCallBack)callBack;
- (JHButtonActionCallBack)getMHCallBack;

@end

@interface UIButton (Ext)
/*
 * 替换方法 'addTarget:forControlEvents:'
 */
- (void)addJHCallBackAction:(JHButtonActionCallBack)callBack forControlEvents:(UIControlEvents)controlEvents;
/*
 * 替换方法 'addTarget:forControlEvents:UIControlEventTouchUpInside'
 */
- (void)addJHClickAction:(JHButtonActionCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
