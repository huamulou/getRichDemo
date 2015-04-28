//
//  RecommendSlidingViewController.m
//  getrich
//
//  Created by huamulou on 14-10-12.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "RecommendSlidingViewController.h"
#import "Constants.h"

@interface RecommendSlidingViewController ()

@end

@implementation RecommendSlidingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.anchorLeftPeekAmount = 62;
    self.anchorRightRevealAmount = SCREEN_WIDTH - self.anchorLeftPeekAmount;;
    // _tabItem.
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

@end
