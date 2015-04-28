//
//  UIViewController+Extend.h
//  demo
//
//  Created by huamulou on 14-9-26.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (Extend)
- (void)addLeftBarButtonItem:(UIButton *)button target:(id)target action:(SEL)action;

//- (UIView *)viewForTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext;

- (BOOL)isAtLeftOrRightByStartX:(CGFloat)startx;

- (BOOL)isAtLeftEdgeByStartX:(CGFloat)startx;
- (BOOL)isAtTopEdgeByStartY:(CGFloat)starty;

- (UIStoryboard *)sbNamed:(NSString *) name;

- (UIViewController*)sbNamed:(NSString *)sbName vcOfsbNamed:(NSString *)vcName;
@end
