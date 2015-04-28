//
//  MoreViewController.h
//  getrich
//
//  Created by huamulou on 14-10-30.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MoreViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property(weak, nonatomic) IBOutlet UICollectionView *listView;
@property (weak, nonatomic) IBOutlet UIView *myCoinView;
@property (weak, nonatomic) IBOutlet UIView *friendsView;
@property (weak, nonatomic) IBOutlet UIView *featuresView;
@property (weak, nonatomic) IBOutlet UIView *infoLeft;
@property (weak, nonatomic) IBOutlet UIView *infoCenter;
@property (weak, nonatomic) IBOutlet UIView *infoRight;

@end
