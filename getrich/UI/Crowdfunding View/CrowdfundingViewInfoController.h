//
//  CrowdfundingViewInfoController.h
//  getrich
//
//  Created by huamulou on 14-10-21.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CrowdFundingViewTitleBarDelegate<NSObject>

-(void)didSeleteAtIndex:(NSInteger)index;
@end

@interface CrowdfundingViewInfoController : UIViewController<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UIView *titleHeightLight2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UIView *titleHeightLight1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;
@property (weak, nonatomic) IBOutlet UIView *titleHeightLight3;
@property (weak, nonatomic) IBOutlet UIView *titleView3;
@property (weak, nonatomic) IBOutlet UIView *titleView1;
@property (weak, nonatomic) IBOutlet UIView *titleView2;

@property (weak, nonatomic) IBOutlet UIView *titleView;


@property (strong, nonatomic)  NSArray *titleLabelList;
@property (strong, nonatomic)  NSArray *titleHeightList;

@property (weak, nonatomic) IBOutlet UIView *leftGView;
@property (weak, nonatomic) IBOutlet UIView *rightGview;


@property (assign, nonatomic)  NSInteger seletedIndex;
@property (assign, nonatomic)  id<CrowdFundingViewTitleBarDelegate> titleBarDelegate;

- (void)selectTitleIndex:(NSInteger)index;

@end
