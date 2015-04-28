//
//  RecommendFundContainerViewController.m
//  getrich
//
//  Created by huamulou on 14-10-17.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "RecommendFundContainerViewController.h"
#import "RecommendFundViewController.h"
#import "RecommendCrowdFundsViewController.h"
#import "UIViewController+HMLSlidingViewController.h"
#import "HMLSlidingViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "UIViewController+Extend.h"
#import "HMLCardTransition.h"
#import "Constants.h"

@interface RecommendFundContainerViewController () {

    HMLCardTransition *_cardTransition;
}

@property(nonatomic, assign) NSInteger index;
@end

@implementation RecommendFundContainerViewController


@synthesize isPassingPanGesture = _isPassingPanGesture;
@synthesize commonGestureRecognizer = _commonGestureRecognizer;

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"RecommendFundContainerViewController init");
        self.dataSource = self;
        self.customGestures = @[self.commonGestureRecognizer];
        _index = 1;
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.toNextDirection = HMLTransitionAnchoredUp;
    self.toPreDirection = HMLTransitionAnchoredDown;
    _cardTransition = [[HMLCardTransition alloc] init];
    self.delegate = _cardTransition;

}


- (UIStoryboard *)myStoryBoard {
    return [UIStoryboard storyboardWithName:@"Recommend" bundle:nil];
}

- (UIViewController *)getTopViewController {
    return  [self getRecommendFundViewController];
}

- (UIViewController *)getPreViewController {
    return  [self getRecommendFundViewController];
}

- (UIViewController *)getNextViewController {
    return [self getRecommendCrowdFundsViewController];
}

- (UIViewController *)fetchByOperation:(HMLTransitionViewControllerOperation)operation currentViewController:(UIViewController *)currentViewController {


    _index++;
    if (_index % 2 == 0) {
        return [self getRecommendCrowdFundsViewController];
    } else {
        return  [self getRecommendFundViewController];
    }
}

- (RecommendFundViewController *)getRecommendFundViewController {
    RecommendFundViewController *fundViewController;
    if (!BIGGER_SCREEN) {
        fundViewController = [[self myStoryBoard] instantiateViewControllerWithIdentifier:@"FundViewController4-"];
    } else {
        fundViewController = [[self myStoryBoard] instantiateViewControllerWithIdentifier:@"FundViewController5+"];
    }
    fundViewController.isRatioAnimate = YES;
    fundViewController.ratio = 7.30 + (CGFloat) arc4random_uniform(2000) / 100;
    return fundViewController;
}

- (RecommendCrowdFundsViewController *)getRecommendCrowdFundsViewController {
    RecommendCrowdFundsViewController *fundViewController;
    if (!BIGGER_SCREEN) {
        fundViewController = [[self myStoryBoard] instantiateViewControllerWithIdentifier:@"CrowdsFundViewController4-"];
    } else {
        fundViewController = [[self myStoryBoard] instantiateViewControllerWithIdentifier:@"CrowdsFundViewController5+"];
    }
    fundViewController.needPercentAnimation = YES;
    return fundViewController;
}


- (void)doGesture:(UIPanGestureRecognizer *)recognizer {

    [super detectPanGestureRecognizer:recognizer];
}


- (UIGestureRecognizer *)commonGestureRecognizer {
    if (!_commonGestureRecognizer) {
        _commonGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doingPan:)];
        _commonGestureRecognizer.cancelsTouchesInView = YES;

    }
    return _commonGestureRecognizer;
}


- (void)doingPan:(UIPanGestureRecognizer *)recognizer {
    CGFloat translationX = [recognizer translationInView:self.view].x;
    CGFloat translationY = [recognizer translationInView:self.view].y;

    CGPoint point = [recognizer locationInView:self.view];
    CGFloat startx = point.x - translationX;
    //[self.view setNeedsDisplay];
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {

            //  [self removeAnimationsRecursively:
            //         self.slidingViewController.view.layer];
            CGFloat i = (translationY == 0 || translationX == 0) ? 0 : fabsf(translationX) / fabsf(translationY);
            if ([self isAtLeftOrRightByStartX:startx] && (i > 1.7320508076 || (translationY == 0 && translationX != 0))) {
                _isPassingPanGesture = true;
            } else {
                _isPassingPanGesture = false;
            }
            break;
        }
        default:
            break;
    }
    if (_isPassingPanGesture) {

        [self.hmlSlidingViewController updateWithRecognizer:recognizer];
        [self.slidingViewController detectPanGestureRecognizer:recognizer withInteractive:NO];
    } else {
        [self doGesture:recognizer];
    }

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


@end
