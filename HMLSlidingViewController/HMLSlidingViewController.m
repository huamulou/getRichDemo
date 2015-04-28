/**
// Copyright (c) 2014 huamulou. All rights reserved.
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
* //                       _oo0oo_
* //                      o8888888o
* //                      88" . "88
* //                      (| -_- |)
* //                      0\  =  /0
* //                    ___/`---'\___
* //                  .' \\|     |// '.
* //                 / \\|||  :  |||// \
* //                / _||||| -:- |||||- \
* //               |   | \\\  -  /// |   |
* //               | \_|  ''\---/''  |_/ |
* //               \  .-\__  '-'  ___/-. /
* //             ___'. .'  /--.--\  `. .'___
* //          ."" '<  `.___\_<|>_/___.' >' "".
* //         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
* //         \  \ `_.   \_ __\ /__ _/   .-` /  /
* //     =====`-.____`.___ \_____/___.-`___.-'=====
* //                       `=---='
* //     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* //
* //               佛祖保佑         永无BUG
*/


//

#import "HMLSlidingViewController.h"


@interface HMLSlidingViewController () {

}
@property(nonatomic, assign) BOOL transitionInProgress;
@property(nonatomic, assign) HMLSlidingViewControllerOperation currentOperation;
@property(nonatomic, assign) HMLSlidingViewControllerTopViewPosition currentTopViewPosition;

@end

@implementation HMLSlidingViewController {

}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }

    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }

    return self;
}

- (instancetype)initWithCenterViewController:(UIViewController *)center {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.center = center;
    }

    return self;
}

- (void)setup {
    _distanceToEdge = _distanceToEdge ? _distanceToEdge : 62;
    _defaultTransitionDuration = _defaultTransitionDuration ?: 0.25;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    _centerZoomFactor = _centerZoomFactor ? _centerZoomFactor : (screenHeight - 29 * 2) / screenHeight;
    _sideZoomFactor = _sideZoomFactor ? _sideZoomFactor : 1.25;
    _sideAlpha = 0.9;
    _currentTopViewPosition = HMLSlidingViewControllerTopViewPositionCentered;
    self.transitionInProgress = NO;
}

#pragma mark - UIViewController

- (void)awakeFromNib {
    if (self.centerStoryboardId) {
        self.center = [self.storyboard instantiateViewControllerWithIdentifier:self.centerStoryboardId];
    }

    if (self.leftStoryboardId) {
        self.left = [self.storyboard instantiateViewControllerWithIdentifier:self.leftStoryboardId];
    }

    if (self.rightStoryboardId) {
        self.right = [self.storyboard instantiateViewControllerWithIdentifier:self.rightStoryboardId];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.center)
        [NSException raise:@"Missing topViewController"
                    format:@"Set the topViewController before loading ECSlidingViewController"];
    self.center.view.frame = self.view.bounds;
    [self.view addSubview:self.center.view];
}

#pragma mark - Properties

- (void)setCenter:(UIViewController *)center {
    UIViewController *oldTopViewController = _center;

    [oldTopViewController.view removeFromSuperview];
    [oldTopViewController willMoveToParentViewController:nil];
    [oldTopViewController beginAppearanceTransition:NO animated:NO];
    [oldTopViewController removeFromParentViewController];
    [oldTopViewController endAppearanceTransition];

    _center = center;

    if (_center) {
        [self addChildViewController:_center];
        [_center didMoveToParentViewController:self];

        if ([self isViewLoaded]) {
            [_center beginAppearanceTransition:YES animated:NO];
            [self.view addSubview:_center.view];
            [_center endAppearanceTransition];
        }
    }
}

- (void)setLeft:(UIViewController *)left {
    UIViewController *oldUnderLeftViewController = _left;

    [oldUnderLeftViewController.view removeFromSuperview];
    [oldUnderLeftViewController willMoveToParentViewController:nil];
    [oldUnderLeftViewController beginAppearanceTransition:NO animated:NO];
    [oldUnderLeftViewController removeFromParentViewController];
    [oldUnderLeftViewController endAppearanceTransition];

    _left = left;

    if (_left) {
        [self addChildViewController:_left];
        [_left didMoveToParentViewController:self];
    }
}

- (void)setRight:(UIViewController *)right {
    UIViewController *oldUnderRightViewController = _right;

    [oldUnderRightViewController.view removeFromSuperview];
    [oldUnderRightViewController willMoveToParentViewController:nil];
    [oldUnderRightViewController beginAppearanceTransition:NO animated:NO];
    [oldUnderRightViewController removeFromParentViewController];
    [oldUnderRightViewController endAppearanceTransition];

    _right = right;

    if (_right) {
        [self addChildViewController:_right];
        [_right didMoveToParentViewController:self];
    }
}


- (void)updateWithRecognizer:(UIPanGestureRecognizer *)recognizer {
    CGFloat translationX = [recognizer translationInView:self.view].x;
    CGFloat velocityX = [recognizer velocityInView:self.view].x;

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            BOOL isMovingRight = velocityX > 0;

            if (_transitionInProgress) {
                self.currentOperation = HMLSlidingViewControllerOperationNone;
            }

            if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionCentered && isMovingRight) {
                self.currentOperation = HMLSlidingViewControllerOperationAnchorRight;
            } else if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionCentered && !isMovingRight) {
                self.currentOperation = HMLSlidingViewControllerOperationAnchorLeft;
            } else if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredLeft && isMovingRight) {
                self.currentOperation = HMLSlidingViewControllerOperationResetFromLeft;
            } else if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredRight && !isMovingRight) {
                self.currentOperation = HMLSlidingViewControllerOperationResetFromRight;
            } else {
                self.currentOperation = HMLSlidingViewControllerOperationNone;
            }

            if (self.currentOperation != HMLSlidingViewControllerOperationNone) {
                [self removeAnimationsRecursively:self.view.layer];
                _transitionInProgress = YES;
            }
            if (self.currentOperation == HMLSlidingViewControllerOperationAnchorRight) {
                [self setSideViewStartOfView:_left.view];
            }
            if (self.currentOperation == HMLSlidingViewControllerOperationAnchorLeft) {
                [self setSideViewStartOfView:_right.view];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if (self.currentOperation == HMLSlidingViewControllerOperationNone)return;
            CGFloat percentComplete = (fabs(translationX) / (self.view.bounds.size.width - _distanceToEdge));
            if (percentComplete < 0) percentComplete = 0;
            if (percentComplete > 1) percentComplete = 1;
            [self updateViews:percentComplete];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if (self.currentOperation == HMLSlidingViewControllerOperationNone)return;
            BOOL isPanningRight = velocityX > 0;
            CGFloat percentComplete = (fabs(translationX) / (self.view.bounds.size.width - _distanceToEdge));
            if (percentComplete < 0) percentComplete = 0;
            if (percentComplete > 1) percentComplete = 1;
            if (isPanningRight &&
                    (self.currentOperation == HMLSlidingViewControllerOperationAnchorRight
                            || self.currentOperation == HMLSlidingViewControllerOperationResetFromLeft)
                    ) {
                [self finishInteractiveTransition:percentComplete];
            } else if (isPanningRight &&
                    (self.currentOperation == HMLSlidingViewControllerOperationAnchorLeft
                            || self.currentOperation == HMLSlidingViewControllerOperationResetFromRight
                    )) {
                [self cancelInteractiveTransition:percentComplete];
            } else if (!isPanningRight &&
                    (self.currentOperation == HMLSlidingViewControllerOperationAnchorRight
                            || self.currentOperation == HMLSlidingViewControllerOperationResetFromLeft)
                    ) {
                [self cancelInteractiveTransition:percentComplete];
            } else if (!isPanningRight &&
                    (self.currentOperation == HMLSlidingViewControllerOperationAnchorLeft
                            || self.currentOperation == HMLSlidingViewControllerOperationResetFromRight
                    )) {
                [self finishInteractiveTransition:percentComplete];
            }

        }
        default:
            break;
    }
}

- (void)updateViews:(CGFloat)percentComplete {
    if (self.currentOperation == HMLSlidingViewControllerOperationNone) {
        return;
    }

    CGFloat centerZoom;
    if (self.currentOperation == HMLSlidingViewControllerOperationAnchorLeft
            || self.currentOperation == HMLSlidingViewControllerOperationAnchorRight) {
        centerZoom = 1 - (1 - _centerZoomFactor) * percentComplete;
    } else {
        centerZoom = _centerZoomFactor + (1 - _centerZoomFactor) * percentComplete;
    }
    _center.view.layer.transform = CATransform3DMakeScale(centerZoom, centerZoom, 1);
    _center.view.frame = [self centerViewPositionByPercent:percentComplete factor:centerZoom];
    UIView *_curSideView = (self.currentOperation == HMLSlidingViewControllerOperationAnchorLeft ||
            self.currentOperation == HMLSlidingViewControllerOperationResetFromLeft) ? _right.view : _left.view;
    [self setSideViewPositionOfView:_curSideView percentComplete:percentComplete isPositive:(self.currentOperation == HMLSlidingViewControllerOperationAnchorLeft
            || self.currentOperation == HMLSlidingViewControllerOperationAnchorRight)];

}

- (void)setSideViewStartOfView:(UIView *)view {

    [self.view insertSubview:view belowSubview:_center.view];
    view.layer.transform = CATransform3DMakeScale(_sideZoomFactor, _sideZoomFactor, 1.0);
    view.center = self.view.center;
}

- (void)setSideViewPositionOfView:(UIView *)view percentComplete:(CGFloat)percentComplete isPositive:(BOOL)isPositive {
    CGFloat curSideAlpha = 1.0;
    if (_sideAlpha < 1) {
        if (isPositive) {
            curSideAlpha = _sideAlpha + (1 - _sideAlpha) * percentComplete;
        } else {
            curSideAlpha = 1 - (1 - _sideAlpha) * percentComplete;
        }
    }
    CGFloat curSideZoom = 1.0;
    if (_sideZoomFactor > 1.0) {
        if (isPositive) {
            curSideZoom = _sideZoomFactor - (_sideZoomFactor - 1) * percentComplete;
        } else {
            curSideZoom = 1 + (_sideZoomFactor - 1) * percentComplete;
        }
    }
    view.alpha = curSideAlpha;
    view.center = self.view.center;
//    view.frame = CGRectMake(0, (self.view.bounds.size.height - curSideZoom * self.view.bounds.size.height) / 2, curSideZoom * self.view.bounds.size.width, curSideZoom * self.view.bounds.size.height);
    view.layer.transform = CATransform3DMakeScale(curSideZoom, curSideZoom, 1);
}

- (void)cancelInteractiveTransition:(CGFloat)percentComplete {
    NSLog(@"calcle ");
    if (self.currentOperation == HMLSlidingViewControllerOperationNone) {
        return;
    }
    NSTimeInterval time = _defaultTransitionDuration * percentComplete;
    if (time < 0) {
        return;
    }
    if (self.currentOperation == HMLSlidingViewControllerOperationResetFromLeft) {
        [self centerToLeftWithAnimation:YES time:time];
    }
    else if (self.currentOperation == HMLSlidingViewControllerOperationResetFromRight) {
        [self centerToRightWithAnimation:YES time:time];
    }
    else if (self.currentOperation == HMLSlidingViewControllerOperationAnchorLeft) {
        [self centerResetFromLeftWithAnimation:YES time:time];

    }
    else if (self.currentOperation == HMLSlidingViewControllerOperationAnchorRight) {
        [self centerResetFromRightWithAnimation:YES time:time];
    }

}

- (void)finishInteractiveTransition:(CGFloat)percentComplete {
    NSLog(@"finish ");
    if (self.currentOperation == HMLSlidingViewControllerOperationNone) {
        return;
    }
    NSTimeInterval time = _defaultTransitionDuration - _defaultTransitionDuration * percentComplete;
    if (time < 0) {
        return;
    }
    if (self.currentOperation == HMLSlidingViewControllerOperationAnchorLeft) {
        [self centerToLeftWithAnimation:YES time:time];
    }
    else if (self.currentOperation == HMLSlidingViewControllerOperationAnchorRight) {
        [self centerToRightWithAnimation:YES time:time];

    }
    else if (self.currentOperation == HMLSlidingViewControllerOperationResetFromLeft) {
        [self centerResetFromLeftWithAnimation:YES time:time];
    }
    else if (self.currentOperation == HMLSlidingViewControllerOperationResetFromRight) {
        [self centerResetFromRightWithAnimation:YES time:time];
    }
}


- (CGRect)centerViewPositionByPercent:(CGFloat)percent factor:(CGFloat)factor {

    CGFloat offset = (self.view.bounds.size.width - _distanceToEdge) * percent;
    CGFloat width = self.view.bounds.size.width * factor;
    CGFloat height = self.view.bounds.size.height * factor;
    CGFloat y = ((self.view.bounds.size.height) - height) / 2;
    CGFloat x = 0;
    if (self.currentOperation == HMLSlidingViewControllerOperationNone) {
        return CGRectInfinite;
    }
    else if (self.currentOperation == HMLSlidingViewControllerOperationAnchorLeft) {
        x = -(width + offset - self.view.bounds.size.width);
    } else if (self.currentOperation == HMLSlidingViewControllerOperationAnchorRight) {
        x = offset;
    } else if (self.currentOperation == HMLSlidingViewControllerOperationResetFromLeft) {
        x = _distanceToEdge + offset - width;
    } else {
        x = self.view.bounds.size.width - offset - _distanceToEdge;
    }

    return CGRectMake(x, y, width, height);


}

- (CGRect)centerViewLeftEnd {
    CGFloat width = self.view.bounds.size.width * _centerZoomFactor;
    CGFloat height = self.view.bounds.size.height * _centerZoomFactor;
    CGFloat y = ((self.view.bounds.size.height) - height) / 2;
    CGFloat x = -(width - _distanceToEdge);
    return CGRectMake(x, y, width, height);
}

- (CGRect)centerViewRightEnd {
    CGFloat width = self.view.bounds.size.width * _centerZoomFactor;
    CGFloat height = self.view.bounds.size.height * _centerZoomFactor;
    CGFloat y = ((self.view.bounds.size.height) - height) / 2;
    CGFloat x = (self.view.bounds.size.width - _distanceToEdge);
    return CGRectMake(x, y, width, height);
}

#pragma mark - Private

- (void)removeAnimationsRecursively:(CALayer *)layer {
    if (layer.sublayers.count > 0) {
        for (CALayer *subLayer in layer.sublayers) {
            [subLayer removeAllAnimations];
            [self removeAnimationsRecursively:subLayer];
        }
    }
}

#pragma mark - view生命周期

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.center beginAppearanceTransition:YES animated:animated];

    if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredLeft) {
        [self.right beginAppearanceTransition:YES animated:animated];
    } else if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredRight) {
        [self.left beginAppearanceTransition:YES animated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.center endAppearanceTransition];

    if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredLeft) {
        [self.right endAppearanceTransition];
    } else if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredRight) {
        [self.left endAppearanceTransition];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.center beginAppearanceTransition:NO animated:animated];

    if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredLeft) {
        [self.right beginAppearanceTransition:NO animated:animated];
    } else if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredRight) {
        [self.left beginAppearanceTransition:NO animated:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.center endAppearanceTransition];

    if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredLeft) {
        [self.right endAppearanceTransition];
    } else if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredRight) {
        [self.left endAppearanceTransition];
    }
}


#pragma mark - animations

- (void)centerToLeftWithAnimation:(BOOL)isAnimate {
    [self centerToLeftWithAnimation:isAnimate time:0];
}

- (void)centerToLeftWithAnimation:(BOOL)isAnimate time:(NSTimeInterval)time {
    time = time ? time : _defaultTransitionDuration;
    if (!_transitionInProgress) {
        _transitionInProgress = YES;
        [self setSideViewStartOfView:_right.view];
    }
    [UIView animateWithDuration:time animations:^{
                _right.view.alpha = 1.0;
                _right.view.layer.transform = CATransform3DIdentity;
                _right.view.center = self.view.center;
                _center.view.layer.transform = CATransform3DMakeScale(_centerZoomFactor, _centerZoomFactor, 1);
                _center.view.frame = [self centerViewLeftEnd];
            }
                     completion:^(BOOL finished) {
                         _transitionInProgress = NO;
                         _currentTopViewPosition = HMLSlidingViewControllerTopViewPositionAnchoredLeft;
                         [self addGestureView];
                     }];
}

- (void)centerToRightWithAnimation:(BOOL)isAnimate {
    [self centerToRightWithAnimation:isAnimate time:0];
}

- (void)centerToRightWithAnimation:(BOOL)isAnimate time:(NSTimeInterval)time {
    time = time ? time : _defaultTransitionDuration;
    if (!_transitionInProgress) {
        _transitionInProgress = YES;
        [self setSideViewStartOfView:_left.view];
    }
    [UIView animateWithDuration:time animations:^{
                _left.view.alpha = 1.0;
                _left.view.layer.transform = CATransform3DIdentity;
                _left.view.frame = self.view.bounds;
                _center.view.layer.transform = CATransform3DMakeScale(_centerZoomFactor, _centerZoomFactor, 1);

                _center.view.frame = [self centerViewRightEnd];
            }
                     completion:^(BOOL finished) {
                         _transitionInProgress = NO;
                         _currentTopViewPosition = HMLSlidingViewControllerTopViewPositionAnchoredRight;
                         [self addGestureView];
                     }];
}

- (void)centerResetFromRightWithAnimation:(BOOL)isAnimate {
    [self centerResetFromRightWithAnimation:isAnimate time:0];
}

- (void)centerResetFromRightWithAnimation:(BOOL)isAnimate time:(NSTimeInterval)time {
    time = time ? time : _defaultTransitionDuration;
    if (!_transitionInProgress) _transitionInProgress = YES;
    [UIView animateWithDuration:time animations:^{
                _left.view.alpha = _sideAlpha;
                _left.view.layer.transform = CATransform3DMakeScale(_sideZoomFactor, _sideZoomFactor, 1);
                _left.view.center = self.view.center;

                //  _center.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
                _center.view.layer.transform = CATransform3DIdentity;
                _center.view.center = self.view.center;
                _center.view.frame= self.view.bounds;
            }
                     completion:^(BOOL finished) {
                         _transitionInProgress = NO;
                         _currentTopViewPosition = HMLSlidingViewControllerTopViewPositionCentered;
                         [_left.view removeFromSuperview];
                         [self reMoveGestureView];
                     }];
}

- (void)centerResetFromLeftWithAnimation:(BOOL)isAnimate {
    [self centerResetFromLeftWithAnimation:isAnimate time:0];
}

- (void)centerResetFromLeftWithAnimation:(BOOL)isAnimate time:(NSTimeInterval)time {
    time = time ? time : _defaultTransitionDuration;
    if (!_transitionInProgress) _transitionInProgress = YES;
    [UIView animateWithDuration:time animations:^{
                _right.view.alpha = _sideAlpha;
                _right.view.layer.transform = CATransform3DMakeScale(_sideZoomFactor, _sideZoomFactor, 1);
                _right.view.center = self.view.center;

                //  _center.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
                _center.view.layer.transform = CATransform3DIdentity;
                _center.view.center = self.view.center;

                _center.view.frame= self.view.bounds;
            }
                     completion:^(BOOL finished) {
                         for (UIView *subView in _center.view.subviews) {
                             subView.layer.transform = CATransform3DIdentity;
                         }
                         _center.view.layer.transform = CATransform3DIdentity;
                         _transitionInProgress = NO;
                         _currentTopViewPosition = HMLSlidingViewControllerTopViewPositionCentered;
                         [_right.view removeFromSuperview];
                         [self reMoveGestureView];
                     }];
}

#pragma mark - gestureView

- (UIView *)gestureView {
    if (_gestureView) return _gestureView;

    _gestureView = [[UIView alloc] initWithFrame:CGRectZero];
    _gestureView.userInteractionEnabled = YES;
    UITapGestureRecognizer *securityClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureViewClick:)];
    [_gestureView addGestureRecognizer:securityClick];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(updateWithRecognizer:)];
    [_gestureView addGestureRecognizer:panGestureRecognizer];
    return _gestureView;
}

- (void)gestureViewClick:(UITapGestureRecognizer *)recognizer {
    if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredLeft) {
        [self centerResetFromLeftWithAnimation:YES];
    } else if (self.currentTopViewPosition == HMLSlidingViewControllerTopViewPositionAnchoredRight) {
        [self centerResetFromRightWithAnimation:YES];
    }
}

- (void)addGestureView {
    [self.view insertSubview:self.gestureView aboveSubview:_center.view];
    self.gestureView.frame = _center.view.frame;
}

- (void)reMoveGestureView {
    [self.gestureView removeFromSuperview];
}
@end