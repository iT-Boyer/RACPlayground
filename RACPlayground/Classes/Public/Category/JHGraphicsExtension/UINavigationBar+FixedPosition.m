//
//  UINavigationBar+FixedPosition.m
//  JRHaoJie
//
//  Created by jh on 2019/5/13.
//  Copyright © 2019 chaizhiyong. All rights reserved.
//

#import "UINavigationBar+FixedPosition.h"
#import <objc/message.h>

@implementation UINavigationBar (FixedPosition)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect hitRect =CGRectMake(0.0,0.0,120.0,44.0);
    bool naviCustomViewExist = CGRectContainsPoint(hitRect, point);
    if (naviCustomViewExist) {
        //扩大JHNaviLeftBar的点击区域
        if ([self.topItem.leftBarButtonItem.customView isKindOfClass:NSClassFromString(@"JHNaviLeftBar")]) {
            return  self.topItem.leftBarButtonItem.customView;
        }else{
            UIView *hitView = [super hitTest:point withEvent:event];
            return hitView;
        }
    }else{
        UIView *hitView = [super hitTest:point withEvent:event];
        return hitView;
    }
}
    
@end
