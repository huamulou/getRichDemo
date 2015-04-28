//
//  RingView.h
//  getrich
//
//  Created by huamulou on 14-10-5.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RingViewTextDelegate<NSObject>

- (NSAttributedString *)getAttrStringByText:(NSString *)text;

@end

@interface RingView : UIView


@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, assign) CGFloat percent;
@property(nonatomic, retain) UIColor *lineColor;
@property(nonatomic, retain) UIColor *numColor;
@property(nonatomic, weak) id <RingViewTextDelegate> delegate;
@property(retain, nonatomic) UILabel *numLabel;
@property(nonatomic, retain) UIColor *lineBackGroundColor;


@end
