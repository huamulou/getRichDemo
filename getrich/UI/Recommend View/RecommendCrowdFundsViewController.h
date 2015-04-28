//
//  RecommendCrowdFundsViewController.h
//  getrich
//
//  Created by huamulou on 14-10-14.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RecommendCrowdFundsViewController : UIViewController



@property(nonatomic, strong)NSString *cfTitle;
@property(nonatomic, strong)NSString *cfName;
@property(nonatomic, assign)NSInteger timeOfMonth;
@property(nonatomic, assign)CGFloat rate;
@property(nonatomic, strong)NSString *startDate;
@property(nonatomic, strong)NSString *endDate;
@property(nonatomic, assign)CGFloat percent;
@property(nonatomic, assign)BOOL needPercentAnimation;

@property (weak, nonatomic) IBOutlet UILabel *cfTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cfNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cfMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cfDatesLabel;


@property (weak, nonatomic) IBOutlet UIView *securityView;
@property (weak, nonatomic) IBOutlet UIView *progressBackView;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidthConstrain;
@property (weak, nonatomic) IBOutlet UILabel *cfPercentLabel;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIImageView *securityLogoView;
@property (weak, nonatomic) IBOutlet UIView *securityContentView;
@property (weak, nonatomic) IBOutlet UILabel *securityTextView;

@end
