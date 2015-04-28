//
//  MyMoneyViewController.m
//  getrich
//
//  Created by huamulou on 14-10-26.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "MyMoneyViewController.h"
#import "Constants.h"
#import "UIColor+Hex.h"
#import "MyHistroyListCell.h"
#import "UIViewController+HMLSlidingViewController.h"
#import "HMLSlidingViewController.h"
#import "UIViewController+Extend.h"

@interface MyMoneyViewController ()

@end

#define MMLLineView @"mmline"

@implementation MyMoneyViewController

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
    [self setUp];
}

-(void)mockDatas{
    self.money = @"32000.00";
    self.income = @"898.97";

    _datas = @[
            @{@"hTitle" : @"工银货币", @"orgin" : @"1000", @"income" : @"20.90", @"card" : @"招商银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"2000", @"income" : @"10.90", @"card" : @"工商银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"3000", @"income" : @"60.90", @"card" : @"农业银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"4000", @"income" : @"80.11", @"card" : @"招商银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"5000", @"income" : @"3.90", @"card" : @"招商银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"2000", @"income" : @"5.34", @"card" : @"招商银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"1000", @"income" : @"11.65", @"card" : @"招商银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"7000", @"income" : @"43.11", @"card" : @"招商银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"7000", @"income" : @"43.11", @"card" : @"招商银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"7000", @"income" : @"43.11", @"card" : @"招商银行"},
            @{@"hTitle" : @"南方现金货币", @"orgin" : @"7000", @"income" : @"43.11", @"card" : @"招商银行"}
    ];
    [[self collectionView] reloadData];
}

- (void)setUp {

    _roundContainerView.layer.cornerRadius = 10;
    _flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 21.5);
//    _flowLayout.dele = UIEdgeInsetsMake(0, 0, 0, 0);


    [self.collectionView registerClass:
                    [UICollectionViewCell class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:MMLLineView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    self.collectionView.contentInset = UIEdgeInsetsMake(-0.5, 0, 0, 0);

    UIPanGestureRecognizer *edgeGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doingPan:)];
    edgeGestureRecognizer.delegate = self;

    [self.view addGestureRecognizer:edgeGestureRecognizer];
    self.firstTime = YES;
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


- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MyHistroyListCell *cell = (MyHistroyListCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
}

- (void)collectionView:(UICollectionView *)colView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MyHistroyListCell *cell = (MyHistroyListCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.2 animations:^{
        cell.backgroundColor = [UIColor whiteColor];
    }                completion:^(BOOL isFinished) {
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger num = _datas ? [_datas count] : 0;
    return num;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {


    MyHistroyListCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MyHistroyListCell" forIndexPath:indexPath];

    NSDictionary *dictionary = [_datas objectAtIndex:indexPath.item];
    //cell.desc = [dictionary objectForKey:@"desc"];
    cell.hTitle = [dictionary objectForKey:@"hTitle"];
    cell.orgin = [dictionary objectForKey:@"orgin"];
    cell.card = [dictionary objectForKey:@"card"];
    cell.income = [dictionary objectForKey:@"income"];

    return cell;

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"MyMoneyViewController-%@", indexPath);


}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {

        UICollectionViewCell *view = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MMLLineView forIndexPath:indexPath];
        view.backgroundColor = [UIColor clearColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 0, view.frame.size.width - 20, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
        [view addSubview:line];
        return view;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 0.5);
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer {
    CGFloat translationX = [recognizer translationInView:self.view].x;

    CGPoint point = [recognizer locationInView:self.view];
    CGFloat startx = point.x - translationX;
    if ([self isAtLeftOrRightByStartX:startx]) {
        return YES;
    }
    return NO;
}

- (void)doingPan:(UIScreenEdgePanGestureRecognizer *)recognizer {
    [self.hmlSlidingViewController updateWithRecognizer:recognizer];
}


- (void)setFirstTime:(BOOL)firstTime {
    _firstTime = firstTime;
    if(_firstTime){
        _bx1.hidden = YES;
        self.money = @"0.00";
        self.income = @"0.00";

    } else{
        _bx1.hidden = NO;
        [_zzView removeFromSuperview];
        [self mockDatas];
    }

}
- (IBAction)nowBtnClick:(id)sender {

    self.firstTime = NO;
}


- (void)setMoney:(NSString *)money {
    _money = money;
    _moneyLabel.text = _money;
}

- (void)setIncome:(NSString *)income {
    _income = income;
    _incomeLabel.text = _income;
}


@end
