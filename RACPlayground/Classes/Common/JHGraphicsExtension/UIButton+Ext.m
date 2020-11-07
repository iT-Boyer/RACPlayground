//
//  UIButton+Ext.m
//  JHMyOrganization
//
//  Created by jh on 2019/6/11.
//  Copyright © 2019 chaizhiyong. All rights reserved.
//

#import "UIButton+Ext.h"
#import <objc/runtime.h>



@implementation UIButton (JHAddCallBackBlock)

static JHButtonActionCallBack _callBack;

- (void)setJHCallBack:(JHButtonActionCallBack)callBack {
    objc_setAssociatedObject(self, &_callBack, callBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JHButtonActionCallBack)getJHCallBack {
    return (JHButtonActionCallBack)objc_getAssociatedObject(self, &_callBack);
}

@end;

@implementation UIButton (Ext)

- (void)addJHCallBackAction:(JHButtonActionCallBack)callBack forControlEvents:(UIControlEvents)controlEvents{
    [self setJHCallBack:callBack];
    [self addTarget:self action:@selector(jhButtonAction:) forControlEvents:controlEvents];
}

- (void)addJHClickAction:(JHButtonActionCallBack)callBack{
    [self addJHCallBackAction:callBack forControlEvents:(UIControlEventTouchUpInside)];
    [self addTarget:self action:@selector(jhTouchDownAction:) forControlEvents:(UIControlEventTouchDown)];
    [self addTarget:self action:@selector(jhTouchUpAction:) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchDragOutside)];
}

- (void)jhButtonAction:(UIButton *)btn {
    self.getJHCallBack(btn);
}

- (void)jhTouchDownAction:(UIButton *)btn {
    btn.enabled = NO;
    btn.alpha = 0.5f;
}

- (void)jhTouchUpAction:(UIButton *)btn {
    btn.enabled = YES;
    btn.alpha = 1.0f;
}

@end
