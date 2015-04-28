//
//  MyHistroyListCell.m
//  getrich
//
//  Created by huamulou on 14-10-26.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "MyHistroyListCell.h"

@implementation MyHistroyListCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setHTitle:(NSString *)hTitle {
    _hTitle = hTitle;
    _titleView.text = _hTitle;
}

- (void)setOrgin:(NSString *)orgin {
    _orgin = orgin;
    _orginView.text = _orgin;
}

- (void)setIncome:(NSString *)income {
    _income = income;
    _incomeView.text = _income;
}

- (void)setCard:(NSString *)card {
    _card = card;
    _cardView.text = _card;
}

- (void)setL1Length:(CGFloat)l1Length {
    _l1Length = l1Length;
    _l1Constraint.constant = _l1Length;
}

- (void)setL2Length:(CGFloat)l2Length {
    _l2Length = l2Length;
    _l2Constraint.constant = _l2Length;
}

- (void)setL3Length:(CGFloat)l3Length {
    _l3Length = l3Length;
    _l3Constraint.constant = _l3Length;
}

- (void)setL4Length:(CGFloat)l4Length {
    _l4Length = l4Length;
    _l4Constraint.constant = _l4Length;
}


@end
