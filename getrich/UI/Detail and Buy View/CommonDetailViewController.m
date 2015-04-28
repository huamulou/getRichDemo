/**
// Copyright (c) 2014 huamulou. All rights reserved.

 * //                       _oo0oo_
 * //                      o8888888o
 * //                      88" . "88
 * //                      (| -_- |)
 * //                      0\  =  /0
 * //                    ___/`---'\___
 * //                  .' \\|     |// '.
 * //                 / \\|||  :  |||// \
 * //                / _||||| -:- |||||- \
 * //               |   | \\\  -  /// |   |
 * //               | \_|  ''\---/''  |_/ |
 * //               \  .-\__  '-'  ___/-. /
 * //             ___'. .'  /--.--\  `. .'___
 * //          ."" '<  `.___\_<|>_/___.' >' "".
 * //         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 * //         \  \ `_.   \_ __\ /__ _/   .-` /  /
 * //     =====`-.____`.___ \_____/___.-`___.-'=====
 * //                       `=---='
 * //     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * //
 * //               佛祖保佑         永无BUG
 */


//

#import "CommonDetailViewController.h"

#import "UIColor+Hex.h"
#import "Constants.h"

@implementation CommonDetailViewController {
    UIButton *_btnAccessoryView;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[[self navigationController] navigationBar] setBarTintColor:[UIColor colorWithHexString:@"#e6e6e6"]];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{
            NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"],
            NSFontAttributeName : [UIFont fontWithName:@"STHeitiSC-Light" size:17],
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp {


    _moneyContainerView.layer.borderWidth = 1;
    _moneyContainerView.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    _moneyContainerView.layer.cornerRadius = 2;
    _moneyContainerView.backgroundColor = [UIColor clearColor];

    _buyBtn.layer.cornerRadius = 2;

    _infosContainerView.layer.cornerRadius = 2;
    _infosContainerView.layer.borderWidth = 1;
    _infosContainerView.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    [self addAccessoryView];


    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexSpace, doneButton, nil]];
    _moneyText.inputAccessoryView = keyboardDoneButtonView;
}

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor colorWithHexString:@"#FF5100"]];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{
            NSForegroundColorAttributeName : [UIColor whiteColor],
            NSFontAttributeName : [UIFont fontWithName:@"STHeitiSC-Light" size:17],
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self controlAccessoryView:0];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setFundTitle:(NSString *)fundTitle {
    _fundTitle = fundTitle;
    _navItem.title = _fundTitle;
}


- (void)addAccessoryView {
    // 遮盖层
    _btnAccessoryView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [_btnAccessoryView setBackgroundColor:[UIColor blackColor]];
    [_btnAccessoryView setAlpha:0.0f];
    _btnAccessoryView.backgroundColor = [UIColor clearColor];
    [_btnAccessoryView addTarget:self action:@selector(ClickControlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnAccessoryView];
}

- (void)ClickControlAction:(id)sender {
    [self controlAccessoryView:0];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    [self controlAccessoryView:0.2f];
    return YES;
}

// 控制遮罩层的透明度
- (void)controlAccessoryView:(float)alphaValue {

    [UIView animateWithDuration:0.2 animations:^{
        //动画代码
        [_btnAccessoryView setAlpha:alphaValue];
    }                completion:^(BOOL finished) {
        if (alphaValue <= 0) {
            [_moneyText resignFirstResponder];
//            [self.navigationController setNavigationBarHidden:NO animated:YES];
//
        }

    }];
}
@end