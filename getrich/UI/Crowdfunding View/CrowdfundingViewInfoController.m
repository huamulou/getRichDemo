//
//  CrowdfundingViewInfoController.m
//  getrich
//
//  Created by huamulou on 14-10-21.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "CrowdfundingViewInfoController.h"
#import "UIColor+Hex.h"
#import "CrowdfundingPageViewController.h"
#import "UIViewController+HMLSlidingViewController.h"
#import "HMLSlidingViewController.h"
#import "UIViewController+Extend.h"
@interface CrowdfundingViewInfoController ()

@property(nonatomic, weak) CrowdfundingPageViewController *crowdfundingPageViewController;

@end

@implementation CrowdfundingViewInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    _titleLabelList = @[_titleLabel1, _titleLabel2, _titleLabel3];
    _titleHeightList = @[_titleHeightLight1, _titleHeightLight2, _titleHeightLight3];
    _titleView.userInteractionEnabled = YES;
    UITapGestureRecognizer *titleClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleBtnClick:)];
//    _titleView1
    [_titleView addGestureRecognizer:titleClick];
    [self selectTitleIndex:_seletedIndex];

    UIPanGestureRecognizer *edgeGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doingPan:)];
    edgeGestureRecognizer.delegate = self;

    [self.view addGestureRecognizer:edgeGestureRecognizer];

    for (UIViewController *controller in self.childViewControllers) {
        if ([controller isKindOfClass:[CrowdfundingPageViewController class]]) {
            self.titleBarDelegate = (CrowdfundingPageViewController *)controller;
            _crowdfundingPageViewController = (CrowdfundingPageViewController *)controller;
        }
    }

    for (UIView *view in _crowdfundingPageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]){
            UIScrollView *scrollView = (UIScrollView *)view;

            [scrollView.panGestureRecognizer requireGestureRecognizerToFail:edgeGestureRecognizer];
        }
    }


}


- (void)doingPan:(UIScreenEdgePanGestureRecognizer *)recognizer {

    [self.hmlSlidingViewController updateWithRecognizer:recognizer];
}


- (void)titleBtnClick:(UITapGestureRecognizer *)gestureRecognizer {
    NSInteger curIndex = 0;
    if (CGRectContainsPoint(_titleView1.bounds, [gestureRecognizer locationInView:_titleView1])) {
        [self selectTitleIndex:0];
        curIndex = 0;
    } else if (CGRectContainsPoint(_titleView2.bounds, [gestureRecognizer locationInView:_titleView2])) {
        [self selectTitleIndex:1];
        curIndex = 1;
    } else if (CGRectContainsPoint(_titleView3.bounds, [gestureRecognizer locationInView:_titleView3])) {
        [self selectTitleIndex:2];
        curIndex = 2;
    }
    if (_titleBarDelegate) {
        if ([_titleBarDelegate respondsToSelector:@selector(didSeleteAtIndex:)]) {
            [_titleBarDelegate didSeleteAtIndex:curIndex];
        }
    }
}

- (void)selectTitleIndex:(NSInteger)index {
    _seletedIndex = index;

    for (int i = 0; i < _titleLabelList.count; i++) {
        if (i != index) {
            [self changeTitleStatusAtIndex:i isHeightLight:NO];
        } else {
            [self changeTitleStatusAtIndex:i isHeightLight:YES];
        }
    }
//    [_fundingListView reloadData];
//    [self.view setNeedsDisplay];

}

- (void)changeTitleStatusAtIndex:(NSInteger)index isHeightLight:(BOOL)isHeightLight {
    UILabel *tLabel = [_titleLabelList objectAtIndex:index];
    UIView *hView = [_titleHeightList objectAtIndex:index];
    if (isHeightLight) {
        hView.hidden = NO;
        [tLabel setTextColor:[UIColor colorWithHexString:@"#0FC3CF"]];
    } else {
        hView.hidden = YES;
        [tLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.view];
    CGPoint transition = [gestureRecognizer translationInView:self.view];

    CGFloat startx = point.x  -transition.x;

    if([self isAtLeftOrRightByStartX: startx]) {
        return YES;
    }
    return NO;
}


@end
