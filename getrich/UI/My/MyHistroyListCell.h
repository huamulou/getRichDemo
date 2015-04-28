//
//  MyHistroyListCell.h
//  getrich
//
//  Created by huamulou on 14-10-26.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHistroyListCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *orginView;
@property (weak, nonatomic) IBOutlet UILabel *incomeView;

@property (weak, nonatomic) IBOutlet UILabel *cardView;


@property (nonatomic, strong)NSString *hTitle;
@property (nonatomic, strong)NSString *orgin;
@property (nonatomic, strong)NSString *income;
@property (nonatomic, strong)NSString *card;

@property(nonatomic,assign) CGFloat l1Length;
@property(nonatomic,assign) CGFloat l2Length;
@property(nonatomic,assign) CGFloat l3Length;
@property(nonatomic,assign) CGFloat l4Length;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *l1Constraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *l2Constraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *l3Constraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *l4Constraint;

@end
