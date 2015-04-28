//
//  RecommendFundViewController.h
//  getrich
//
//  Created by huamulou on 14-10-17.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RingView.h"

@interface RecommendFundViewController : UIViewController<RingViewTextDelegate>


@property (weak, nonatomic) IBOutlet RingView *ringView;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIView *securityView;
@property (weak, nonatomic) IBOutlet UIView *securityContentView;
@property (weak, nonatomic) IBOutlet UIImageView *securityLogoView;
@property (weak, nonatomic) IBOutlet UILabel *securityTextView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;


@property (assign, nonatomic) BOOL isRatioAnimate;
@property (assign, nonatomic) CGFloat ratio;
@end
