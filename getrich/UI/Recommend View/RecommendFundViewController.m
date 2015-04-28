//
//  RecommendFundViewController.m
//  getrich
//
//  Created by huamulou on 14-10-17.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "POPBasicAnimation.h"
#import "RecommendFundViewController.h"
#import "UIColor+Hex.h"
#import "Constants.h"
#import "UIViewController+Extend.h"

@interface RecommendFundViewController ()

@end



static const CGFloat ratioOfBigToSmall = 1.5769;


@implementation RecommendFundViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // [_rateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:26]];
    // [_monthLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    // [_countLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];

    [_buyBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF5100"]];
    _buyBtn.layer.cornerRadius = 1.5f;
    _securityView.userInteractionEnabled = YES;
    UITapGestureRecognizer *securityClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(securityClick:)];
    [_securityView addGestureRecognizer:securityClick];


    _ringView.lineBackGroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    _ringView.lineColor = [UIColor colorWithHexString:@"ff5100"];
    _ringView.numColor = [UIColor redColor];
    _ringView.delegate = self;
    _ringView.percent = _ratio;

    if (_isRatioAnimate && _ratio > 0) {
        // POPSpringAnimation *animation1 ;
        POPAnimatableProperty *animatableProperty = [POPAnimatableProperty propertyWithName:@"com.geeklu.animatableValue" initializer:^(POPMutableAnimatableProperty *prop) {
            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                float now = values[0];
               [((RingView *) obj) setPercent:now];
            };
            prop.readBlock = nil;
        }];
        POPBasicAnimation *animation = [POPBasicAnimation animation];
        animation.property = animatableProperty;
        animation.fromValue = [NSNumber numberWithFloat:0];
        animation.toValue = [NSNumber numberWithFloat:_ratio];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 1.6;
        [_ringView pop_addAnimation:animation forKey:@"FundViewController_easeOut"];
    }

    [_securityView sizeToFit];
    [_titleView sizeToFit];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}






- (void)securityClick:(UITapGestureRecognizer *)recognizer {

    _securityLogoView.image = [UIImage imageNamed:@"recommend-security-s"];
    _securityView.backgroundColor = [UIColor colorWithHexString:@"#0fc3cf"];
    _securityContentView.backgroundColor = [UIColor colorWithHexString:@"#0fc3cf"];
    _securityTextView.textColor = [UIColor whiteColor];

    [UIView
            animateWithDuration:0.4f
                     animations:^{
                         _securityLogoView.image = [UIImage imageNamed:@"recommend-security-n"];
                         _securityView.backgroundColor = [UIColor whiteColor];
                         _securityContentView.backgroundColor = [UIColor whiteColor];
                         _securityTextView.textColor = [UIColor colorWithHexString:@"#666666"];

                     } completion:nil];

}

#pragma mark - 设置中间view的文字

- (NSAttributedString *)getAttrStringByText:(NSString *)text {
    NSRange pointR = [text rangeOfString:POINTOFFLOAT];
    //NSRange percentR = [text rangeOfString:PERCENT];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    NSInteger length = [text length];
    CGFloat size0 = 50.0;
    CGFloat size1 = 30.0;

    if (BIGGER_SCREEN) {
        size0 = ratioOfBigToSmall * size0;
        size1 = ratioOfBigToSmall * size1;
    }

    if (length >= 6) {
        size0 = 42;
        if (BIGGER_SCREEN) {
            size0 = ratioOfBigToSmall * size0;
        }
        size1 = (30.0) * size0 / 50.0;
    }

    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:size0] range:NSMakeRange(0, pointR.location)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5100"] range:NSMakeRange(0, length - 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(length - 1, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:size1] range:NSMakeRange(pointR.location, length - pointR.location)];
    return attributedString;

}

- (IBAction)buyBtnClick:(id)sender {
    [[self navigationController] pushViewController: [self sbNamed:@"DetailAndBuy" vcOfsbNamed:@"FundDetailView"] animated:YES];
}

@end
