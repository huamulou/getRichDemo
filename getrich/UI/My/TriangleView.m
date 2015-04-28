//
//  TriangleView.m
//  getrich
//
//  Created by huamulou on 14-10-28.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "TriangleView.h"
#import "UIColor+Hex.h"

@implementation TriangleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code




    CGContextRef context = UIGraphicsGetCurrentContext();

    CGMutablePathRef path = CGPathCreateMutable();

    UIColor *lineColor = [UIColor colorWithHexString:@"#cccccc"];

    CGPoint sPoints[3];//坐标点
    sPoints[0] = CGPointMake(5.5, 0);//坐标1
    sPoints[1] = CGPointMake(0, 5);//坐标2
    sPoints[2] = CGPointMake(5.5, 10);//坐标3

    CGPathAddLines(path, nil, sPoints, 3);

    UIBezierPath *lines = [UIBezierPath bezierPathWithCGPath:path] ;
    [lineColor setStroke];
    lines.lineWidth = 0.5;
    [lines stroke];



    CGMutablePathRef fillPath = CGPathCreateMutable();

    UIColor *fillColor = [UIColor colorWithHexString:@"#f2f2f2"];

    CGPoint fillPoints[3];//坐标点
    fillPoints[0] = CGPointMake(5.5, 0.5);//坐标1
    fillPoints[1] = CGPointMake(0.5, 5);//坐标2
    fillPoints[2] = CGPointMake(5.5, 9.5);//坐
    UIBezierPath * triangle = [UIBezierPath bezierPathWithCGPath:path];
    [fillColor setFill];
    [triangle fill];

}

@end
