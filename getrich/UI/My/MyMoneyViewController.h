//
//  MyMoneyViewController.h
//  getrich
//
//  Created by huamulou on 14-10-26.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>

CGFloat  const l1Length_const = 9.5;
CGFloat  const l2Length_const = 94;
CGFloat  const l3Length_const = 78.5;
CGFloat  const l4Length_const = 83;
@interface MyMoneyViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *roundContainerView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *datas;
@property (nonatomic, assign)BOOL firstTime;


@property (weak, nonatomic) IBOutlet UIView *bx1;
@property (weak, nonatomic) IBOutlet UIView *zzView;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *income;

@end
