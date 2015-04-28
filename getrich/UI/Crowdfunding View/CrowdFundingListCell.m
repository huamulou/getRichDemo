//
//  CrowdFundingListCell.m
//  getrich
//
//  Created by huamulou on 14-10-22.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "CrowdFundingListCell.h"
#import "NSString+Extend.h"
#import "Constants.h"
#import "UIColor+Hex.h"

@implementation CrowdFundingListCell

- (id)initWithFrame:(CGRect)frame {
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
- (void)setTitle:(NSString *)title {
    _title = title;
    NSMutableAttributedString *attributedString = [_title attributedStringWithChineseFontSize:15 withNumberAndLetterFontSize:17];
    _titleLabel.attributedText = attributedString;
}

- (void)setDesc:(NSString *)desc {
    _desc = desc;
    NSMutableAttributedString *attributedString = [_desc attributedStringWithChineseFontSize:12 withNumberAndLetterFontSize:15];
    _descLabel.attributedText = attributedString;

}

- (void)setRestrict0:(NSString *)restrict0 {
    _restrict0 = restrict0;
    NSMutableAttributedString *attributedString = [_restrict0
            attributedStringWithChineseFontSize:12
                    withNumberAndLetterFontSize:15
                           withChineseFontColor:[UIColor colorWithHexString:@"#666666"]
                               withNALFontColor:[UIColor colorWithHexString:@"#FF5100"]
                                withLineSpacing:0];
    _restrictLabel.attributedText = attributedString;
}

- (void)setRestrict1:(NSString *)restrict1 {
    _restrict1 = restrict1;
    NSMutableAttributedString *attributedString = [_restrict1
            attributedStringWithChineseFontSize:12
                    withNumberAndLetterFontSize:15
                           withChineseFontColor:[UIColor colorWithHexString:@"#666666"]
                               withNALFontColor:[UIColor colorWithHexString:@"#FF5100"]
                                withLineSpacing:0];
    _restrictLabel1.attributedText = attributedString;
}


- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    _percentLabel.text = [NSString stringWithFormat:@"%.2f%@", _percent, PERCENT];
}


@end
