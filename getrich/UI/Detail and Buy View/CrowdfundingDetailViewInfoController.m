//
//  CrowdfundingDetailViewInfoController.m
//  getrich
//
//  Created by huamulou on 14-10-26.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "CrowdfundingDetailViewInfoController.h"
#import "UIColor+Hex.h"

@interface CrowdfundingDetailViewInfoController ()

@end

@implementation CrowdfundingDetailViewInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _roundContainerView.layer.cornerRadius = 10;
    _roundView.layer.cornerRadius = 9;
    _roundView.layer.borderWidth = 1;
    _roundView.layer.borderColor = [UIColor colorWithHexString:@"#0fc3cf"].CGColor;
    _roundView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
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

@end
