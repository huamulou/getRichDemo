// MEZoomAnimationController.m
// TransitionFun
//
// Copyright (c) 2013, Michael Enriquez (http://enriquez.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MEZoomAnimationController.h"

//static CGFloat const MEZoomAnimationScaleFactor = 0.75;
static CGFloat const MarginTop = 29;

@interface MEZoomAnimationController ()
@property(nonatomic, assign) ECSlidingViewControllerOperation operation;

@property(nonatomic, assign) CGFloat MEZoomAnimationScaleFactor;
@property(nonatomic, weak) ECSlidingViewController *slidingViewController;

- (CGRect)topViewAnchoredRightFrame:(ECSlidingViewController *)slidingViewController;

- (void)topViewStartingState:(UIView *)topView containerFrame:(CGRect)containerFrame;

- (void)topViewAnchorEndState:(UIView *)topView anchoredFrame:(CGRect)anchoredFrame;

- (void)underLeftOrRightViewStartingState:(UIView *)underLeftView containerFrame:(CGRect)containerFrame;

- (void)underLeftOrRightViewEndState:(UIView *)underLeftView;
@end

@implementation MEZoomAnimationController

#pragma mark - ECSlidingViewControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)slidingViewController:(ECSlidingViewController *)slidingViewController
                                    animationControllerForOperation:(ECSlidingViewControllerOperation)operation
                                                  topViewController:(UIViewController *)topViewController {
    _slidingViewController = slidingViewController;
    self.operation = operation;
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        _MEZoomAnimationScaleFactor = ([UIScreen mainScreen].bounds.size.height - MarginTop * 2) / [UIScreen mainScreen].bounds.size.height;
    }

    return self;
}


- (id <ECSlidingViewControllerLayout>)slidingViewController:(ECSlidingViewController *)slidingViewController
                         layoutControllerForTopViewPosition:(ECSlidingViewControllerTopViewPosition)topViewPosition {
    return self;
}

#pragma mark - ECSlidingViewControllerLayout

- (CGRect)slidingViewController:(ECSlidingViewController *)slidingViewController
         frameForViewController:(UIViewController *)viewController
                topViewPosition:(ECSlidingViewControllerTopViewPosition)topViewPosition {
    if (topViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight && viewController == slidingViewController.topViewController) {
        return [self topViewAnchoredRightFrame:slidingViewController];
    } else if (topViewPosition == ECSlidingViewControllerTopViewPositionAnchoredLeft && viewController == slidingViewController.topViewController) {
        return [self topViewAnchoredLeftFrame:slidingViewController];
    }

    else {
        return CGRectInfinite;
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *topViewController = [transitionContext viewControllerForKey:ECTransitionContextTopViewControllerKey];
    UIViewController *underLeftViewController = [transitionContext viewControllerForKey:ECTransitionContextUnderLeftControllerKey];
    UIViewController *underRightViewController = [transitionContext viewControllerForKey:ECTransitionContextUnderRightControllerKey];
    UIView *containerView = [transitionContext containerView];

    _slidingViewController.modalTransitionStyle =UIModalPresentationFullScreen;
    UIView *topView = topViewController.view;


    underLeftViewController.view.layer.transform = CATransform3DIdentity;

    if (self.operation == ECSlidingViewControllerOperationAnchorRight) {
        if (_slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
            return;
        }
        underRightViewController.view.hidden = YES;
        underLeftViewController.view.hidden = NO;
        [containerView insertSubview:underLeftViewController.view belowSubview:topView];
        topView.frame = containerView.bounds;
        // [self topViewStartingState:topView containerFrame:containerView.bounds];
        [self underLeftOrRightViewStartingState:underLeftViewController.view containerFrame:containerView.bounds];

        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            [self underLeftOrRightViewEndState:underLeftViewController.view];
            [self topViewAnchorEndState:topView anchoredFrame:[transitionContext finalFrameForViewController:topViewController]];
        }                completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                underLeftViewController.view.frame = [transitionContext finalFrameForViewController:underLeftViewController];
                underLeftViewController.view.alpha = 1;
                [self topViewStartingState:topView containerFrame:containerView.bounds];
            }

            [transitionContext completeTransition:finished];
//            if(![[UIApplication sharedApplication].keyWindow.subviews containsObject:topView]) {
//                [[UIApplication sharedApplication].keyWindow addSubview:topView ];
//                [[UIApplication sharedApplication].keyWindow addSubview:_slidingViewController.gestureView ];
//            }

        }];
    } else if (self.operation == ECSlidingViewControllerOperationResetFromRight) {
        [self topViewAnchorEndState:topView anchoredFrame:[transitionContext initialFrameForViewController:topViewController]];
        [self underLeftOrRightViewEndState:underLeftViewController.view];

        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            [self underLeftOrRightViewStartingState:underLeftViewController.view containerFrame:containerView.bounds];
            [self topViewStartingState:topView containerFrame:containerView.bounds];
        }                completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [self underLeftOrRightViewEndState:underLeftViewController.view];
                [self topViewAnchorEndState:topView anchoredFrame:[transitionContext initialFrameForViewController:topViewController]];
            } else {
                underLeftViewController.view.alpha = 1;
                underLeftViewController.view.layer.transform = CATransform3DIdentity;
                [underLeftViewController.view removeFromSuperview];
            }

            [transitionContext completeTransition:finished];
            [[[UIApplication sharedApplication] keyWindow] addSubview:topView];
        }];
    } else if (self.operation == ECSlidingViewControllerOperationAnchorLeft) {

        if (_slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredLeft) {
            return;
        }
        underRightViewController.view.hidden = NO;
        underLeftViewController.view.hidden = YES;
        [containerView insertSubview:underRightViewController.view belowSubview:topView];

        [self topViewStartingState:topView containerFrame:containerView.bounds];
        [self underLeftOrRightViewStartingState:underRightViewController.view containerFrame:containerView.bounds];

        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            [self underLeftOrRightViewEndState:underRightViewController.view];
            [self topViewAnchorEndState:topView anchoredFrame:[transitionContext finalFrameForViewController:topViewController]];
        }                completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                underRightViewController.view.frame = [transitionContext finalFrameForViewController:underRightViewController];
                underRightViewController.view.alpha = 1;
                [self topViewStartingState:topView containerFrame:containerView.bounds];
            }

            [transitionContext completeTransition:finished];
        }];
    } else if (self.operation == ECSlidingViewControllerOperationResetFromLeft) {
        [self topViewAnchorEndState:topView anchoredFrame:[transitionContext initialFrameForViewController:topViewController]];
        [self underLeftOrRightViewEndState:underRightViewController.view];

        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            [self underLeftOrRightViewStartingState:underRightViewController.view containerFrame:containerView.bounds];
            [self topViewStartingState:topView containerFrame:containerView.bounds];
        }                completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [self underLeftOrRightViewEndState:underRightViewController.view];
                [self topViewAnchorEndState:topView anchoredFrame:[transitionContext initialFrameForViewController:topViewController]];
            } else {
                underRightViewController.view.alpha = 1;
                underRightViewController.view.layer.transform = CATransform3DIdentity;
                [underRightViewController.view removeFromSuperview];
            }

            [transitionContext completeTransition:finished];
            [[[UIApplication sharedApplication] keyWindow] addSubview:topView];
        }];
    }
}

#pragma mark - Private

- (CGRect)topViewAnchoredRightFrame:(ECSlidingViewController *)slidingViewController {
    CGRect frame = slidingViewController.view.bounds;

    frame.origin.x = slidingViewController.anchorRightRevealAmount;
    frame.size.width = frame.size.width * _MEZoomAnimationScaleFactor;
    frame.size.height = frame.size.height * _MEZoomAnimationScaleFactor;
    frame.origin.y = (slidingViewController.view.bounds.size.height - frame.size.height) / 2;

    return frame;
}


#pragma mark 当从左拉的时候矩形

- (CGRect)topViewAnchoredLeftFrame:(ECSlidingViewController *)slidingViewController {
    CGRect frame = slidingViewController.view.bounds;
    float fatherWidth = frame.size.width;

    frame.size.width = frame.size.width * _MEZoomAnimationScaleFactor;
    frame.origin.x = fatherWidth - frame.size.width - slidingViewController.anchorLeftRevealAmount;
    frame.size.height = frame.size.height * _MEZoomAnimationScaleFactor;
    frame.origin.y = (slidingViewController.view.bounds.size.height - frame.size.height) / 2;

    return frame;
}


- (void)topViewStartingState:(UIView *)topView containerFrame:(CGRect)containerFrame {
    topView.layer.transform = CATransform3DIdentity;
//    topView.layer.position = CGPointMake(containerFrame.size.width / 2, containerFrame.size.height / 2);
//    topView.layer.position = CGPointMake(0, 0);
    topView.frame = containerFrame;
}

- (void)topViewAnchorEndState:(UIView *)topView anchoredFrame:(CGRect)anchoredFrame {
    topView.layer.transform = CATransform3DMakeScale(_MEZoomAnimationScaleFactor, _MEZoomAnimationScaleFactor, 1);
    topView.frame = anchoredFrame;
    // topView.layer.position = CGPointMake(anchoredFrame.origin.x + ((topView.layer.bounds.size.width * _MEZoomAnimationScaleFactor) / 2), topView.layer.position.y);
}


- (void)underLeftOrRightViewStartingState:(UIView *)underLeftView containerFrame:(CGRect)containerFrame {
    underLeftView.alpha = 0.9;
    underLeftView.frame = containerFrame;
    underLeftView.layer.transform = CATransform3DMakeScale(1.25, 1.25, 1);
}


- (void)underLeftOrRightViewEndState:(UIView *)view {
    view.alpha = 1;
    view.layer.transform = CATransform3DIdentity;
}

@end
