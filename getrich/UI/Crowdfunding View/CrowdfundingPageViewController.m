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

#import "CrowdfundingPageViewController.h"
#import "CrowdFundingListViewController.h"
#import "UIPageViewController+Extend.h"
#import "CrowdfundingViewInfoController.h"

@interface CrowdfundingPageViewController ()
@property(nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation CrowdfundingPageViewController {

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    [self setUp];
}

- (void)setUp {
    NSArray *array0 = @[
                        @{@"title" : @"合盈优选项目合集", @"desc" : @"预期年化收益", @"restrict0" : @"限12个月", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]},
                        @{@"title" : @"合盈优选项目合集", @"desc" : @"预期年化收益", @"restrict0" : @"限12个月", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]},
                        @{@"title" : @"合盈优选项目合集", @"desc" : @"预期年化收益", @"restrict0" : @"限12个月", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]},
                        @{@"title" : @"合盈优选项目合集", @"desc" : @"预期年化收益", @"restrict0" : @"限12个月", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]},
                        @{@"title" : @"合盈优选项目合集", @"desc" : @"预期年化收益", @"restrict0" : @"限12个月", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]}
                        ];
    NSArray *array1 = @[@{@"title" : @"西溪湿地五星宾馆双人体验之旅", @"desc" : @"预期年化收益", @"restrict0" : @"限12个月", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]},
                        @{@"title" : @"西溪湿地五星宾馆双人体验之旅", @"desc" : @"预期年化收益", @"restrict0" : @"限12个月", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]},
                        @{@"title" : @"西溪湿地五星宾馆双人体验之旅", @"desc" : @"预期年化收益", @"restrict0" : @"限12个月", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]},
                        @{@"title" : @"西溪湿地五星宾馆双人体验之旅", @"desc" : @"预期年化收益", @"restrict0" : @"限12个月", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]}];
    NSArray *array2 = @[
                        @{@"title" : @"工银货币", @"desc" : @"七日年化", @"restrict0" : @"随买随卖", @"restrict1" : @"已申购8888人", @"percent" : [NSNumber numberWithFloat:9.32]},@{@"title" : @"南方现金货币", @"desc" : @"七日年化", @"restrict0" : @"随买随卖", @"restrict1" : @"1000元起购", @"percent" : [NSNumber numberWithFloat:9.32]},
                        @{@"title" : @"博时现金货币", @"desc" : @"七日年化", @"restrict0" : @"随买随卖", @"restrict1" : @"已申购8888人", @"percent" : [NSNumber numberWithFloat:9.32]},
                        @{@"title" : @"诚信货币A", @"desc" : @"七日年化", @"restrict0" : @"随买随卖", @"restrict1" : @"已申购8888人", @"percent" : [NSNumber numberWithFloat:9.32]}];
    
    _dataSourceArray = [@[array0, array1, array2] mutableCopy];


    self.delegate = self;
    CrowdFundingListViewController *startingViewController = (CrowdFundingListViewController *)[self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    // Change the size of page view controller
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return [_dataSourceArray count];
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return 0;
//}



- (UIViewController *)                                             pageViewController:
(UIPageViewController *)pageViewController viewControllerBeforeViewController:
(UIViewController *)viewController {
    NSUInteger index = ((CrowdFundingListViewController *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}


- (UIViewController *)                                            pageViewController:
        (UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((CrowdFundingListViewController *) viewController).pageIndex;

    if (index == NSNotFound) {
        return nil;
    }

    index++;
    if (index == [self.dataSourceArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}



- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.dataSourceArray count] == 0) || (index >= [self.dataSourceArray count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    CrowdFundingListViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CrowdFundingListViewController"];
    pageContentViewController.datas = [self.dataSourceArray objectAtIndex:index];
    pageContentViewController.pageIndex = index;

    return pageContentViewController;
}

- (void)didSeleteAtIndex:(NSInteger)index {
    if (index < 0) {
        return;
    }
    if (index >= [_dataSourceArray count]) {
        return;
    }
    NSInteger currentPage = ((CrowdFundingListViewController *) [self.viewControllers objectAtIndex:0]).pageIndex;

    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if (currentPage > index) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    [self setViewControllers:@[[self viewControllerAtIndex:index]] direction:direction invalidateCache:YES animated:NO completion:nil];

}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {

    NSLog(@"Current Page = %@", pageViewController.viewControllers);

    CrowdFundingListViewController *currentView = [pageViewController.viewControllers objectAtIndex:0];
    CrowdfundingViewInfoController *crowdfundingViewController = [self crowdfundingViewController];
    if (crowdfundingViewController) {
        [crowdfundingViewController selectTitleIndex:currentView.pageIndex];
    }

}

- (CrowdfundingViewInfoController *)crowdfundingViewController {
    UIViewController *viewController = self.parentViewController ? self.parentViewController : self.presentingViewController;
    while (!(viewController == nil || [viewController isKindOfClass:[CrowdfundingViewInfoController class]])) {
        viewController = viewController.parentViewController ? viewController.parentViewController : viewController.presentingViewController;
    }

    return (CrowdfundingViewInfoController *) viewController;
}


@end