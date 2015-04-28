//
//  CommonViewController.m
//  getrich
//
//  Created by huamulou on 14-9-28.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "CommonViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "MEZoomAnimationController.h"
#import "PanGestureCommon.h"
#import "UIViewController+HMLSlidingViewController.h"
#import "HMLSlidingViewController.h"

@interface CommonViewController ()

@property(nonatomic, strong) MEZoomAnimationController *zoomAnimationController;

@end

@implementation CommonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    _zoomAnimationController = [[MEZoomAnimationController alloc] init];
    self.slidingViewController.delegate = _zoomAnimationController;

    self.slidingViewController.customAnchoredGestures = @[];
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftClick:(id)sender {

}

- (IBAction)leftTouch:(id)sender {
    NSLog(@"touch left");
//    [[self slidingViewController] anchorTopViewToRightAnimated:YES];
    [[self hmlSlidingViewController] centerToRightWithAnimation:YES];
}

- (IBAction)rightTouch:(id)sender {
    NSLog(@"touch right");
//    [[self slidingViewController] anchorTopViewToLeftAnimated:YES];
    [[self hmlSlidingViewController] centerToLeftWithAnimation:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];


}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}


- (void)awakeFromNib {
    [super awakeFromNib];

}


@end
