//
//  HMLTransitionViewController.m
//  HMLTransitionViewController
//
//  Created by huamulou on 14-10-15.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "HMLTransitionViewController.h"
#import "HMLTransitionAnimationController.h"
#import "HMLInteractiveTransition.h"
#import <objc/runtime.h>

@interface HMLTransitionViewController ()
//现在topview所处于的状态
@property(nonatomic, assign) HMLTransitionViewControllerOperation currentOperation;

@property(nonatomic, assign) BOOL transitionInProgress;

//是否在交互中
@property(nonatomic, assign) BOOL isInteractive;
//现在的动画
@property(nonatomic, strong) id <UIViewControllerAnimatedTransitioning> currentAnimationController;

//现在的交互
@property(nonatomic, strong) id <UIViewControllerInteractiveTransitioning> currentInteractiveTransition;

//默认的动画
@property(nonatomic, strong) HMLTransitionAnimationController *defaultAnimationController;
//默认的交互
@property(nonatomic, strong) HMLInteractiveTransition *defaultInteractiveTransition;
//现在动画的完成度
@property(nonatomic, assign) CGFloat currentAnimationPercentage;
//交互是否被退出
@property(nonatomic, assign) BOOL transitionWasCancelled;


@property(nonatomic, copy) void (^animationComplete)();
@property(nonatomic, copy) void (^coordinatorAnimations)(id <UIViewControllerTransitionCoordinatorContext> context);
@property(nonatomic, copy) void (^coordinatorCompletion)(id <UIViewControllerTransitionCoordinatorContext> context);
@property(nonatomic, copy) void (^coordinatorInteractionEnded)(id <UIViewControllerTransitionCoordinatorContext> context);

@property(nonatomic, assign) BOOL isAnimated;


@end

@implementation HMLTransitionViewController

- (UIViewAnimationCurve)completionCurve {
    return UIViewAnimationCurveLinear;
}

- (CGFloat)completionVelocity {
    return 1.0;
}

- (void)notifyWhenInteractionEndsUsingBlock:(void(^)(id<UIViewControllerTransitionCoordinatorContext>context))handler {
    self.coordinatorInteractionEnded = handler;
}

#pragma mark - UIViewControllerTransitionCoordinatorContext

- (BOOL)initiallyInteractive {
    return _isAnimated && _isInteractive;
}

- (BOOL)isCancelled {
    return _transitionWasCancelled;
}

- (NSTimeInterval)transitionDuration {
    return [self.currentAnimationController transitionDuration:self];
}

- (CGFloat)percentComplete {
    return self.currentAnimationPercentage;
}
- (void)setDefaultTransitionDuration:(NSTimeInterval)defaultTransitionDuration {
    self.defaultAnimationController.defaultTransitionDuration = defaultTransitionDuration;
}
#pragma mark - UIViewControllerTransitionCoordinator

- (BOOL)animateAlongsideTransition:(void(^)(id<UIViewControllerTransitionCoordinatorContext>context))animation
                        completion:(void(^)(id<UIViewControllerTransitionCoordinatorContext>context))completion {
    self.coordinatorAnimations = animation;
    self.coordinatorCompletion = completion;
    return YES;
}
- (BOOL)animateAlongsideTransitionInView:(UIView *)view
                               animation:(void(^)(id<UIViewControllerTransitionCoordinatorContext>context))animation
                              completion:(void(^)(id<UIViewControllerTransitionCoordinatorContext>context))completion {
    self.coordinatorAnimations = animation;
    self.coordinatorCompletion = completion;
    return YES;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        // Custom initialization
        [self setup];
    }

    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}

- (instancetype)initWithPreViewController:(UIViewController *)preViewController topViewController:(UIViewController *)topViewController nextViewController:(UIViewController *)nextViewController {
    self = [super init];
    if (self) {
        self.preViewController = preViewController;
        self.topViewController = topViewController;
        self.nextViewController = nextViewController;
    }
    [self setup];
    return self;
}

#pragma mark - 静态的初始化方法

+ (instancetype)initWithTopViewController:(UIViewController *)topViewController preViewController:(UIViewController *)preViewController nextViewController:(UIViewController *)nextViewController {
    return [[self alloc] initWithPreViewController:preViewController topViewController:topViewController nextViewController:nextViewController];
}


- (void)setup {
    self.transitionInProgress = NO;

}

- (void)setDataSource:(id <HMLTansitionViewControllerDataSource>)dataSource {
    _dataSource = dataSource;
    if (_dataSource) {
        if ([_dataSource respondsToSelector:@selector(getTopViewController)]) {
            self.topViewController = _dataSource.getTopViewController;
        }
        if ([_dataSource respondsToSelector:@selector(getPreViewController)]) {
            self.preViewController = _dataSource.getPreViewController;
        }
        if ([_dataSource respondsToSelector:@selector(getNextViewController)]) {
            self.nextViewController = _dataSource.getNextViewController;
        }
    }
}


#pragma mark - 是否自动传递AppearanceMethods

//NS_AVAILABLE_IOS(6_0)
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (BOOL)shouldAutorotate {
    return self.currentOperation == HMLTransitionViewControllerOperationNone;
}

//#pragma mark - 是否自动传递AppearanceMethods
//NS_AVAILABLE_IOS(6_0)
- (BOOL)shouldAutomaticallyForwardRotationMethods {
    return NO;
}

//NS_DEPRECATED_IOS(5_0,6_0)
- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
    return NO;
}

#pragma mark - view的生命周期

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.topViewController beginAppearanceTransition:YES animated:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.topViewController endAppearanceTransition];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.topViewController)
        [NSException raise:@"Missing topViewController"
                    format:@"Set the topViewController before loading HMLTransitionViewController"];
    self.topViewController.view.frame = self.view.frame;
    [self.view addSubview:self.topViewController.view];
    [self addGestureRecognizers:_topViewController];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.topViewController beginAppearanceTransition:NO animated:animated];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.topViewController endAppearanceTransition];

}


#pragma mark - view的生命周期   end


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties

- (void)setTopViewController:(UIViewController *)topViewController {

    UIViewController *oldTopViewController = _topViewController;

    if (oldTopViewController) {
        [oldTopViewController.view removeFromSuperview];
        [oldTopViewController willMoveToParentViewController:nil];
        [oldTopViewController beginAppearanceTransition:NO animated:NO];
        [oldTopViewController removeFromParentViewController];
        [oldTopViewController endAppearanceTransition];

    }
    _topViewController = topViewController;
    if (_topViewController) {
        [self addChildViewController:_topViewController];
        [_topViewController didMoveToParentViewController:self];

        if ([self isViewLoaded]) {
            [_topViewController beginAppearanceTransition:YES animated:NO];
            [self.view addSubview:_topViewController.view];
            [_topViewController endAppearanceTransition];
        }
    }
}

- (void)setNextViewController:(UIViewController *)nextViewController {
    UIViewController *oldNextViewController = _nextViewController;
    if (oldNextViewController) {
        [oldNextViewController.view removeFromSuperview];
        [oldNextViewController willMoveToParentViewController:nil];
        [oldNextViewController beginAppearanceTransition:NO animated:NO];
        [oldNextViewController removeFromParentViewController];
        [oldNextViewController endAppearanceTransition];
    }

    _nextViewController = nextViewController;

    if (_nextViewController) {
        [self addChildViewController:_nextViewController];
        [_nextViewController didMoveToParentViewController:self];
    }
}

- (void)setPreViewController:(UIViewController *)preViewController {


    UIViewController *oldPreViewController = _preViewController;

    if (oldPreViewController) {
        [oldPreViewController.view removeFromSuperview];
        [oldPreViewController willMoveToParentViewController:nil];
        [oldPreViewController beginAppearanceTransition:NO animated:NO];
        [oldPreViewController removeFromParentViewController];
        [oldPreViewController endAppearanceTransition];
    }

    _preViewController = preViewController;

    if (_preViewController) {
        [self addChildViewController:_preViewController];
        [_preViewController didMoveToParentViewController:self];
    }
}


- (id <UIViewControllerTransitionCoordinator>)transitionCoordinator {
    if (!self.transitionInProgress) {
        return [super transitionCoordinator];
    }
    return self;
}

#pragma mark - Properties end

#pragma mark - 动画调用的方法 start

- (void)transitionToPreView:(BOOL)animated {

    [self transitionToPreView:animated onComplete:nil];
}

- (void)transitionToNextView:(BOOL)animated {
    [self transitionToNextView:animated onComplete:nil];
}

- (void)transitionToPreView:(BOOL)animated onComplete:(void (^)())complete {
    [self transitionToView:animated operation:HMLTransitionViewControllerOperation2Pre onComplete:complete];
}

- (void)transitionToNextView:(BOOL)animated onComplete:(void (^)())complete {
    [self transitionToView:animated operation:HMLTransitionViewControllerOperation2Next onComplete:complete];
}

- (void)transitionToView:(BOOL)animated operation:(HMLTransitionViewControllerOperation)operation onComplete:(void (^)())complete {
    if (_dataSource)
        objc_setAssociatedObject(self, &HMLTransitionContextViewTobeAdd, [_dataSource fetchByOperation:operation currentViewController:_topViewController], OBJC_ASSOCIATION_RETAIN);
    if (operation == HMLTransitionViewControllerOperationNone) {
        return;
    }
    else if (operation == HMLTransitionViewControllerOperation2Pre) {
        objc_setAssociatedObject(self, &HMLTransitionContextViewTobeDelete, _nextViewController, OBJC_ASSOCIATION_ASSIGN);
    }
    else if (operation == HMLTransitionViewControllerOperation2Next) {
        objc_setAssociatedObject(self, &HMLTransitionContextViewTobeDelete, _preViewController, OBJC_ASSOCIATION_ASSIGN);
    }
    self.animationComplete = complete;
    self.isAnimated = animated;

    [self.view endEditing:YES];
    [self animateOperation:operation];
}

#pragma mark - 动画调用的方法 end

- (UIPanGestureRecognizer *)panGesture {
    if (_panGesture) return _panGesture;

    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(detectPanGestureRecognizer:)];

    return _panGesture;
}

#pragma mark - defaultInteractiveTransition

- (HMLInteractiveTransition *)defaultInteractiveTransition {
    if (_defaultInteractiveTransition) return _defaultInteractiveTransition;

    _defaultInteractiveTransition = [[HMLInteractiveTransition alloc] initWithTransitionViewController:self];
    //_defaultInteractiveTransition.animationController = self.defaultAnimationController;

    return _defaultInteractiveTransition;
}


#pragma mark - UIPanGestureRecognizer action

- (void)detectPanGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.view endEditing:YES];
        _isInteractive = YES;
    }

    [self.defaultInteractiveTransition updateTopViewHorizontalCenterWithRecognizer:recognizer];
    _isInteractive = NO;
}


#pragma mark - default animation

- (HMLTransitionAnimationController *)defaultAnimationController {
    if (_defaultAnimationController) return _defaultAnimationController;

    _defaultAnimationController = [[HMLTransitionAnimationController alloc] init];

    return _defaultAnimationController;
}


#pragma mark - animateOperation
- (void)animateOperation:(HMLTransitionViewControllerOperation)operation {
    if (self.transitionInProgress) return;

    self.view.userInteractionEnabled = NO;
    self.transitionInProgress = YES;

    self.currentOperation = operation;

    if ([(NSObject *) self.delegate respondsToSelector:@selector(transitionViewController:animationControllerForOperation:topViewController:)]) {
        self.currentAnimationController = [self.delegate transitionViewController:self
                                                  animationControllerForOperation:operation
                                                                topViewController:self.topViewController];

        if ([(NSObject *) self.delegate respondsToSelector:@selector(transitionViewController:interactionControllerForAnimationController:)]) {
            self.currentInteractiveTransition = [self.delegate transitionViewController:self
                                            interactionControllerForAnimationController:self.currentAnimationController];
        } else {
            self.currentInteractiveTransition = nil;
        }
    } else {
        self.currentAnimationController = nil;
    }

    if (self.currentAnimationController) {
        if (self.currentInteractiveTransition) {
            _isInteractive = YES;
        } else {
            self.defaultInteractiveTransition.animationController = self.currentAnimationController;
            self.currentInteractiveTransition = self.defaultInteractiveTransition;
        }
    } else {
        self.currentAnimationController = self.defaultAnimationController;

        self.defaultInteractiveTransition.animationController = self.currentAnimationController;
        self.currentInteractiveTransition = self.defaultInteractiveTransition;
    }

    [self beginAppearanceTransitionForOperation:operation];

    [self.defaultAnimationController setValue:self.coordinatorAnimations forKey:@"coordinatorAnimations"];
    [self.defaultAnimationController setValue:self.coordinatorCompletion forKey:@"coordinatorCompletion"];
    [self.defaultInteractiveTransition setValue:self.coordinatorInteractionEnded forKey:@"coordinatorInteractionEnded"];

    if ([self isInteractive]) {
        [self.currentInteractiveTransition startInteractiveTransition:self];
    } else {
        [self.currentAnimationController animateTransition:self];
    }
}


- (void)beginAppearanceTransitionForOperation:(HMLTransitionViewControllerOperation)operation {
    UIViewController *viewControllerWillAppear = [self topViewControllerForSuccessfulOperation:operation];

    [viewControllerWillAppear beginAppearanceTransition:YES animated:_isAnimated];
    [_topViewController beginAppearanceTransition:NO animated:_isAnimated];
}

- (UIViewController *)topViewControllerForSuccessfulOperation:(HMLTransitionViewControllerOperation)operation {
    switch (operation) {
        case HMLTransitionViewControllerOperationNone: {
            return nil;
        }
        case HMLTransitionViewControllerOperation2Pre: {
            return _preViewController;
        }
        case HMLTransitionViewControllerOperation2Next: {
            return _nextViewController;
        }
    }
    return nil;
}

- (UIViewController *)preViewControllerForSuccessfulOperation:(HMLTransitionViewControllerOperation)operation {
    switch (operation) {
        case HMLTransitionViewControllerOperationNone: {
            return nil;
        }
        case HMLTransitionViewControllerOperation2Pre: {
            return objc_getAssociatedObject(self, &HMLTransitionContextViewTobeAdd);;
        }
        case HMLTransitionViewControllerOperation2Next: {
            return _topViewController;
        }
    }
    return nil;
}

- (UIViewController *)nextViewControllerForSuccessfulOperation:(HMLTransitionViewControllerOperation)operation {
    switch (operation) {
        case HMLTransitionViewControllerOperationNone: {
            return nil;
        }
        case HMLTransitionViewControllerOperation2Pre: {
            return _topViewController;
        }
        case HMLTransitionViewControllerOperation2Next: {
            return objc_getAssociatedObject(self, &HMLTransitionContextViewTobeAdd);
        }
    }
    return nil;
}


#pragma mark - default animation

- (UIModalPresentationStyle)presentationStyle {
    return UIModalPresentationCustom;
}

#pragma mark -  updateInteractiveTransition

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    self.currentAnimationPercentage = percentComplete;
}

#pragma mark -  finishInteractiveTransition

- (void)finishInteractiveTransition {
    _transitionWasCancelled = NO;
}

#pragma mark -  cancelInteractiveTransition

- (void)cancelInteractiveTransition {
    _transitionWasCancelled = YES;
}

#pragma mark -  删除所有的手势监听

- (void)removeGestureRecognizers:(UIViewController *)viewController {
    for (UIGestureRecognizer *gesture in self.customGestures) {
        [viewController.view removeGestureRecognizer:gesture];
    }
}

#pragma mark -  添加所有的手势监听

- (void)addGestureRecognizers:(UIViewController *)viewController {
    for (UIGestureRecognizer *gesture in self.customGestures) {
        [viewController.view addGestureRecognizer:gesture];
    }
}

#pragma mark -  completeTransition

- (void)completeTransition:(BOOL)didComplete {
    if (self.currentOperation == HMLTransitionViewControllerOperationNone) return;


    if ([self.currentAnimationController respondsToSelector:@selector(animationEnded:)]) {
        [self.currentAnimationController animationEnded:didComplete];
    }

    if (self.animationComplete) self.animationComplete();
    self.animationComplete = nil;

    [self endAppearanceTransitionForOperation:self.currentOperation isCancelled:[self transitionWasCancelled]];

    if ([self transitionWasCancelled]) {

    } else {
        UIViewController *newTop = [self topViewControllerForSuccessfulOperation:self.currentOperation];
        UIViewController *newPre = [self preViewControllerForSuccessfulOperation:self.currentOperation];
        UIViewController *newNext = [self nextViewControllerForSuccessfulOperation:self.currentOperation];

        [self refreshViewControllers];

        [self removeGestureRecognizers:_topViewController];
        _topViewController = newTop;
        [self addGestureRecognizers:_topViewController];
        _preViewController = newPre;
        _nextViewController = newNext;
    }

    if ([self.currentAnimationController respondsToSelector:@selector(animationEnded:)]) {
        [self.currentAnimationController animationEnded:didComplete];
    }



    if (self.animationComplete) self.animationComplete();
    self.animationComplete = nil;


    _transitionWasCancelled = NO;
    _isInteractive = NO;
    self.coordinatorAnimations = nil;
    self.coordinatorCompletion = nil;
    self.coordinatorInteractionEnded = nil;
    self.currentAnimationPercentage = 0;
    self.currentOperation = HMLTransitionViewControllerOperationNone;
    self.transitionInProgress = NO;
    self.view.userInteractionEnabled = YES;
//    _defaultAnimationController = nil;
//    _defaultInteractiveTransition=nil;
//    _currentAnimationController = nil;
//    _currentInteractiveTransition = nil;
    //[self removeAnimationsRecursively:self.view.layer];

    [UIViewController attemptRotationToDeviceOrientation];
    if (HML_IOS7_PLUS)
        [self setNeedsStatusBarAppearanceUpdate];
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

#pragma mark -  动画结束之后清理viewcontroller

- (void)refreshViewControllers {
    UIViewController *toBeDelete = objc_getAssociatedObject(self, &HMLTransitionContextViewTobeDelete);
    UIViewController *toBeAdd = objc_getAssociatedObject(self, &HMLTransitionContextViewTobeAdd);

    if (toBeAdd) {
        [self addChildViewController:toBeAdd];
        [toBeAdd didMoveToParentViewController:self];
    }
    if (toBeDelete) {
        [toBeDelete.view removeFromSuperview];
        [toBeDelete willMoveToParentViewController:nil];
        [toBeDelete beginAppearanceTransition:NO animated:NO];
        [toBeDelete removeFromParentViewController];
        [toBeDelete endAppearanceTransition];
    }
}

- (void)endAppearanceTransitionForOperation:(HMLTransitionViewControllerOperation)operation isCancelled:(BOOL)canceled {
    UIViewController *viewControllerWillAppear = [self topViewControllerForSuccessfulOperation:operation];
    UIViewController *viewControllerWillDisappear = self.topViewController;

    if (canceled) {
        [viewControllerWillDisappear beginAppearanceTransition:YES animated:_isAnimated];
        [viewControllerWillDisappear endAppearanceTransition];
        [viewControllerWillAppear beginAppearanceTransition:NO animated:_isAnimated];
        [viewControllerWillAppear endAppearanceTransition];

        [viewControllerWillAppear.view removeFromSuperview];
    } else {
        [viewControllerWillDisappear endAppearanceTransition];
        [viewControllerWillAppear endAppearanceTransition];
         [viewControllerWillDisappear.view removeFromSuperview];
    }
}


#pragma mark -  通过key来获取对应的viewController

- (UIViewController *)viewControllerForKey:(NSString *)key {
    if ([key isEqualToString:HMLTransitionContextTopViewControllerKey]) {
        return self.topViewController;
    } else if ([key isEqualToString:HMLTransitionContextPreViewControllerKey]) {
        return self.preViewController;
    } else if ([key isEqualToString:HMLTransitionContextNextViewControllerKey]) {
        return self.nextViewController;
    } else if ([key isEqualToString:HMLTransitionContextToViewControllerKey]) {
        return [self topViewControllerForSuccessfulOperation:self.currentOperation];
    }
    return nil;
}

#pragma mark - UIViewControllerContextTransitioning and UIViewControllerTransitionCoordinatorContext

- (UIView *)containerView {
    return self.view;
}


//用于给初始动画提供起始点
- (CGRect)initialFrameForViewController:(UIViewController *)vc {
    if (self.currentOperation == HMLTransitionViewControllerOperationNone) {
        return CGRectZero;
    }
    if ([vc isEqual:_topViewController]) {
        return self.view.bounds;
    }

    return CGRectZero;
}


- (CGRect)finalFrameForViewController:(UIViewController *)vc {
    CGRect bounds = self.view.bounds;
    if (self.currentOperation == HMLTransitionViewControllerOperationNone) {
        return CGRectZero;
    }
    if ([vc isEqual:_topViewController]) {
        if (self.currentOperation == HMLTransitionViewControllerOperation2Pre) {
            if (self.toPreDirection == HMLTransitionAnchoredUp) {
                return CGRectMake(0, -bounds.size.height, bounds.size.width, bounds.size.height);
            } else if (self.toPreDirection == HMLTransitionAnchoredDown) {
                return CGRectMake(0, 2 * bounds.size.height, bounds.size.width, bounds.size.height);
            } else if (self.toPreDirection == HMLTransitionAnchoredLeft) {
                return CGRectMake(-bounds.size.width, 0, bounds.size.width, bounds.size.height);
            } else if (self.toPreDirection == HMLTransitionAnchoredRight) {
                return CGRectMake(2 * bounds.size.width, 0, bounds.size.width, bounds.size.height);
            }


        } else {
            if (self.toNextDirection == HMLTransitionAnchoredUp) {
                return CGRectMake(0, -bounds.size.height, bounds.size.width, bounds.size.height);
            } else if (self.toNextDirection == HMLTransitionAnchoredDown) {
                return CGRectMake(0, 2 * bounds.size.height, bounds.size.width, bounds.size.height);
            } else if (self.toNextDirection == HMLTransitionAnchoredLeft) {
                return CGRectMake(-bounds.size.width, 0, bounds.size.width, bounds.size.height);
            } else if (self.toNextDirection == HMLTransitionAnchoredRight) {
                return CGRectMake(2 * bounds.size.width, 0, bounds.size.width, bounds.size.height);
            }

        }

    } else {
        return self.view.bounds;
    }

    return CGRectZero;
}
@end
