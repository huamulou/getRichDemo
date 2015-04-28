/**
// Copyright (c) 2014 huamulou. All rights reserved.

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

#import "HMLCardTransition.h"
#import "UIColor+Hex.h"

@interface HMLCardTransition ()
@property(nonatomic, assign) HMLTransitionViewControllerOperation operation;

@property(nonatomic, weak) HMLTransitionViewController *transitionViewController;
@end

@implementation HMLCardTransition {

}


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (_defaultTransitionDuration) {
        return _defaultTransitionDuration;
    } else {
        return 0.25;
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *topViewController = [transitionContext viewControllerForKey:HMLTransitionContextTopViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:HMLTransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
    if (self.operation == HMLTransitionViewControllerOperation2Pre) {

        [containerView insertSubview:toViewController.view belowSubview:topViewController.view];
    } else{
        [containerView addSubview:toViewController.view];
    }

     [self topInit:topViewController.view containerView:containerView];
     [self toInit:toViewController.view containerView:containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        [self topEnd:topViewController.view containerView:containerView];
        [self toEnd:toViewController.view containerView:containerView];
    }                completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [self topInit:topViewController.view containerView:containerView];
           // [toViewController.view removeFromSuperview];
        }
        //NSLog(@"initWithTransitionViewController");
        [transitionContext completeTransition:finished];

    }];
}

- (void)topInit:(UIView *)topView containerView:(UIView *)containerView {
        topView.frame = containerView.bounds;
        topView.layer.transform = CATransform3DIdentity;
        topView.alpha = 1;
}

- (void)topEnd:(UIView *)topView containerView:(UIView *)containerView {
    if (self.operation == HMLTransitionViewControllerOperation2Pre) {
        topView.frame = CGRectMake(0, containerView.bounds.size.height, containerView.bounds.size.width, containerView.bounds.size.height);
    } else if (self.operation == HMLTransitionViewControllerOperation2Next) {
        topView.frame = containerView.bounds;
        topView.layer.transform = [self secondTransformWithView];
        topView.alpha = 0.6;
    }
}


- (void)toInit:(UIView *)toView containerView:(UIView *)containerView {
    if (self.operation == HMLTransitionViewControllerOperation2Pre) {
        toView.frame = containerView.bounds;
        toView.layer.transform = [self secondTransformWithView];
        toView.alpha = 0.6;
    } else if (self.operation == HMLTransitionViewControllerOperation2Next) {
        toView.frame = CGRectMake(0, containerView.bounds.size.height, containerView.bounds.size.width, containerView.bounds.size.height);
        toView.layer.transform = CATransform3DIdentity;
        toView.alpha = 1;
    }
}

- (void)toEnd:(UIView *)toView containerView:(UIView *)containerView {
    toView.frame = containerView.bounds;
    toView.layer.transform = CATransform3DIdentity;
    toView.alpha = 1;
}


- (CATransform3D)secondTransformWithView {

    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = 1.0 / -100;
    t2 = CATransform3DTranslate(t2, 0, 0, 0);
    t2 = CATransform3DScale(t2, 0.9, 0.9, 1);

    return t2;
}

- (id <UIViewControllerAnimatedTransitioning>)transitionViewController:(HMLTransitionViewController *)transitionViewController animationControllerForOperation:(HMLTransitionViewControllerOperation)operation topViewController:(UIViewController *)topViewController {
    _transitionViewController = transitionViewController;
    self.operation = operation;
    return self;
}


@end