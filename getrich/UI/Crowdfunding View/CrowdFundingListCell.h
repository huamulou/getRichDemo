//
//  CrowdFundingListCell.h
//  getrich
//
//  Created by huamulou on 14-10-22.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrowdFundingListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *restrictLabel;
@property (weak, nonatomic) IBOutlet UILabel *restrictLabel1;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;


@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, strong)NSString *restrict1;
@property(nonatomic, strong)NSString *restrict0;
@property(nonatomic, assign)CGFloat percent;


@end
