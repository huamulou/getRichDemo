//
//  MyHistoryDetailCell.m
//  getrich
//
//  Created by huamulou on 14-10-28.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "MyHistoryDetailCell.h"
#import "UIColor+Hex.h"


NSString *const yearPattern = @"%@-";
NSString *const monthAndDatePattern = @"%@.%@";

@implementation MyHistoryDetailCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
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

- (void)setUp {
    NSLog(@"MyHistoryDetailCell setUp");
    _roundContainer.layer.cornerRadius = 5;
    _roundContainer.layer.borderWidth = 1;
    _roundContainer.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    _roundContent.layer.cornerRadius = 2;

}


- (void)setYear:(NSString *)year {
    _year = year;
    if (_year)
        _yearLabel.text = [NSString stringWithFormat:yearPattern, year];
    else {
        _yearLabel.text = @"";
    }
}

- (void)setMonth:(NSString *)month {
    _month = month;
    if (_month) {
        NSString *monthAndDate = [NSString stringWithFormat:monthAndDatePattern, _month, _date];
        _monthAndDateLabel.text = monthAndDate;
    } else {
        _monthAndDateLabel.text = @"";
    }
}

- (void)setDate:(NSString *)date {
    _date = date;
    if (_date) {
        NSString *monthAndDate = [NSString stringWithFormat:monthAndDatePattern, _month, _date];
        _monthAndDateLabel.text = monthAndDate;
    } else {
        _monthAndDateLabel.text = @"";
    }
}

- (void)setHTitle:(NSString *)hTitle {
    _hTitle = hTitle;
    _titleLabel.text = hTitle;
}

- (void)setOrgin:(NSString *)orgin {
    _orgin = orgin;
    _orginLabel.text = orgin;
}

- (void)setEarn:(NSString *)earn {
    _earn = earn;
    _earnLabel.text = earn;
}

- (void)setStatus:(MyHistoryDetailCellStatus)status {
    _status = status;

    if (_status & firstAtSetion) {
        _roundContainer.hidden = NO;
        _triangleView.hidden = NO;
    } else {
        _roundContainer.hidden = YES;
        _triangleView.hidden = YES;
    }


    if (_status & firstAtSetion && _status & firstSetion) {
        _roundContainer.layer.borderColor = [UIColor colorWithHexString:@"#FF5100"].CGColor;
        _roundContent.hidden = NO;
    } else if (_status & firstAtSetion) {
        _roundContainer.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        _roundContent.hidden = YES;
    } else {
        _roundContainer.hidden = YES;
    }

    if (_status & lastAtSetion) {
        _bottomDash.hidden = YES;
        _bottomLine.hidden = NO;
    } else {
        _bottomDash.hidden = NO;
        _bottomLine.hidden = YES;
    }


}


@end
