//
//  RecommendCrowdFundsViewController.m
//  getrich
//
//  Created by huamulou on 14-10-14.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <pop/POPAnimatableProperty.h>
#import "RecommendCrowdFundsViewController.h"
#import "NSString+Extend.h"
#import "Constants.h"
#import "UIColor+Hex.h"
#import "POPBasicAnimation.h"
#import "UIViewController+Extend.h"

@interface RecommendCrowdFundsViewController ()

@end

static NSString *const monthPattern = @"期限%d个月";
static NSString *const ratePattern = @"%.2f%@";
static NSString *const datesPattern = @"%@—%@";
static NSString *const percentPattern = @"已筹%.2f";

static const CGFloat radius = 4.0f;

@implementation RecommendCrowdFundsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view. .
    [self setUp];
}


- (void)setUp {

    _cfTitle = @"西溪湿地五星宾馆双人体验";
    _cfName = @"天天利一号";
    _timeOfMonth = 12;
    _rate = 8.20;
    _startDate = @"10.10";
    _endDate = @"10.17";
    _percent = 73.2;


    CGFloat titleSize = [[_cfTitleLabel font] pointSize];

    _cfTitleLabel.attributedText = [_cfTitle attributedStringWithChineseFontSize:titleSize withNumberAndLetterFontSize:titleSize];
    CGFloat nameSize = [[_cfNameLabel font] pointSize];
    _cfNameLabel.attributedText = [_cfName attributedStringWithChineseFontSize:nameSize withNumberAndLetterFontSize:nameSize];

    NSString *monthString = [NSString stringWithFormat:monthPattern, _timeOfMonth];
    CGFloat monthSize = [[_cfMonthLabel font] pointSize];
    _cfMonthLabel.attributedText = [monthString attributedStringWithChineseFontSize:monthSize withNumberAndLetterFontSize:monthSize];


    NSString *rateString = [NSString stringWithFormat:ratePattern, _rate, PERCENT];
    NSMutableAttributedString *rateAttributedString = [self getAttrStringByText:rateString biggerSize:36 normalSize:24];
    _rateLabel.attributedText = rateAttributedString;

    NSString *dates = [NSString stringWithFormat:datesPattern, _startDate, _endDate];
    _cfDatesLabel.text = dates;


    _progressBackView.layer.cornerRadius = radius;
    _progressView.layer.cornerRadius = radius;

    self.percent = _percent;
    if(_needPercentAnimation){
        [self percentAnimation:_percent];
    }


    _detailView.layer.cornerRadius = DEFAULT_RADIUS;
    _detailView.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    _detailView.layer.borderWidth = 1.0f;

    _securityView.userInteractionEnabled = YES;
    UITapGestureRecognizer *securityClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(securityClick:)];
    [_securityView addGestureRecognizer:securityClick];

}

- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    CGFloat width = SCREEN_WIDTH - 2 * 10;
    width = _percent * width / 100;
    _progressWidthConstrain.constant = width;

    NSString *percentString = [[NSString stringWithFormat:percentPattern, _percent] stringByAppendingString:PERCENT];
    NSMutableAttributedString *percentAttributeString = [percentString attributedStringWithChineseFontSize:12 withNumberAndLetterFontSize:14];
    _cfPercentLabel.attributedText = percentAttributeString;
}


-(void)percentAnimation:(CGFloat)percent{
    // POPSpringAnimation *animation1 ;

    POPAnimatableProperty *animatableProperty = [POPAnimatableProperty
            propertyWithName:@"com.geeklu.animatableValue.RecommendCrowdFundsViewController"
                 initializer:^(POPMutableAnimatableProperty *prop) {
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            float now = values[0];
            [self setPercent:now];
        };
        prop.readBlock = nil;
    }];
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = animatableProperty;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:percent];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 3.6;
    [self.view pop_addAnimation:animation forKey:@"CrowdFundsViewController_easeOut"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 设置中间view的文字

- (NSMutableAttributedString *)getAttrStringByText:(NSString *)text biggerSize:(CGFloat)biggerSize normalSize:(CGFloat)normalSize {
    NSRange pointR = [text rangeOfString:POINTOFFLOAT];
    //NSRange percentR = [text rangeOfString:PERCENT];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    NSInteger length = [text length];

    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:biggerSize] range:NSMakeRange(0, pointR.location)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5100"] range:NSMakeRange(0, length)];
    //   [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(length - 1, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:normalSize] range:NSMakeRange(pointR.location, length - pointR.location)];
    return attributedString;

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

- (IBAction)buyBtnClick:(id)sender {
    [[self navigationController] pushViewController: [self sbNamed:@"DetailAndBuy" vcOfsbNamed:@"CrowdfundingDetailViewController"] animated:YES];
}
@end
