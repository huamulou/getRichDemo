//
//  MyHistoryDetailCell.h
//  getrich
//
//  Created by huamulou on 14-10-28.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriangleView.h"


typedef NS_ENUM(NSInteger, MyHistoryDetailCellStatus) {

positionNone = 0,
    firstAtSetion = 1 << 0,
    firstSetion = 1 << 1,
    lastAtSetion = 1 << 2

};

@interface MyHistoryDetailCell : UICollectionViewCell


@property(weak, nonatomic) IBOutlet UILabel *yearLabel;
@property(weak, nonatomic) IBOutlet UILabel *monthAndDateLabel;
@property(weak, nonatomic) IBOutlet UIView *roundContainer;
@property(weak, nonatomic) IBOutlet UIView *roundContent;
@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(weak, nonatomic) IBOutlet UILabel *orginLabel;
@property(weak, nonatomic) IBOutlet UILabel *earnLabel;
@property(weak, nonatomic) IBOutlet UILabel *bottomDash;
@property(weak, nonatomic) IBOutlet UIView *bottomLine;
@property(weak, nonatomic) IBOutlet TriangleView *triangleView;


@property(nonatomic, strong) NSString *year;
@property(nonatomic, strong) NSString *month;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) NSString *hTitle;
@property(nonatomic, strong) NSString *orgin;
@property(nonatomic, strong) NSString *earn;
@property(nonatomic, assign) MyHistoryDetailCellStatus status;

@end
