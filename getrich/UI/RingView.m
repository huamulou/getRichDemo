//
//  RingView.m
//  getrich
//
//  Created by huamulou on 14-10-5.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "RingView.h"

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)
#define DEGREES_START 270.0f

@interface RingView () {

}
@end

@implementation RingView


- (void)setPercent:(CGFloat)percent {
    //NSLog(@"");
    _percent = percent;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@".##"];

    if (!_numLabel)            {
        _numLabel = [[UILabel alloc] init];
        [self addSubview:_numLabel];
    }


    NSString *text = [NSString stringWithFormat:@"%.2f%@", _percent, @"%"];
    BOOL flag = NO;
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(getAttrStringByText:)]) {
            _numLabel.attributedText = [_delegate getAttrStringByText:text];
            flag = YES;
        }
    }

    if (!flag) {
        _numLabel.text = text;
    }
    [_numLabel sizeToFit];
    _numLabel.center = [self convertPoint:self.center fromView:self.superview];
    [self setNeedsDisplay];
}

- (void)setNumColor:(UIColor *)numColor {
    _numColor = numColor;
    _numLabel.textColor = _numColor;

}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_radius > 0 && _lineWidth > 0) {
        CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        float strokeWidth = _lineWidth;
        float radius = (_radius - _lineWidth / 2);


        float endAngle = (_percent / 100) * 360.0f;
        float startAngle = DEGREES_START;
        if (endAngle - 90.0f >= 270.0f) {
            startAngle = 0.0f;
            endAngle = 360.0f;
        } else if (endAngle - 90.0f > 0) {
            endAngle = (endAngle - 90.0f);
        } else {
            endAngle = (endAngle + 270.0f);
        }

        UIBezierPath *lineCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                                  radius:radius
                                                              startAngle:DEGREES_TO_RADIANS(startAngle)
                                                                endAngle:DEGREES_TO_RADIANS(endAngle)
                                                               clockwise:YES];

        [_lineColor setStroke];
        lineCircle.lineWidth = strokeWidth;
        [lineCircle stroke];

        //Background circle
        if (!(startAngle == 0 && endAngle == 360)) {
            UIBezierPath *backGroundCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                                            radius:radius
                                                                        startAngle:DEGREES_TO_RADIANS(endAngle)
                                                                          endAngle:DEGREES_TO_RADIANS(startAngle)
                                                                         clockwise:YES];


            [_lineBackGroundColor setStroke];
            backGroundCircle.lineWidth = strokeWidth;
            [backGroundCircle stroke];
        }


//        UIBezierPath *backGroundCircle1  = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 50, 30) cornerRadius:15];
//        backGroundCircle1.lineWidth = 0.5;
//        [backGroundCircle1 stroke];
    }

}


@end
