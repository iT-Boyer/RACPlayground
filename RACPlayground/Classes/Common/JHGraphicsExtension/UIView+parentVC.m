//
//  UIView+parentVC.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/6/14.
//  Copyright © 2018年 pk. All rights reserved.
//

#import "UIView+parentVC.h"

@implementation UIView (parentVC)

- (UIViewController *)parentViewController{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
