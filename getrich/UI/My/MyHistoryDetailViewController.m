//
//  MyHistoryDetailViewController.m
//  getrich
//
//  Created by huamulou on 14-10-28.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "MyHistoryDetailViewController.h"
#import "Constants.h"
#import "MyHistoryDetailCell.h"
#import "UIColor+Hex.h"

@interface MyHistoryDetailViewController () {


    NSArray *_datas;
}

@end

@implementation MyHistoryDetailViewController

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
    [self mockDatas];
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[[self navigationController] navigationBar] setBarTintColor:[UIColor colorWithHexString:@"#e6e6e6"]];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{
            NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"],
            NSFontAttributeName : [UIFont fontWithName:@"STHeitiSC-Light" size:17],
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor colorWithHexString:@"#FF5100"]];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{
            NSForegroundColorAttributeName : [UIColor whiteColor],
            NSFontAttributeName : [UIFont fontWithName:@"STHeitiSC-Light" size:17],
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



- (void)mockDatas {

    _datas = @[
            @{@"year" : @"2014", @"month" : @"12", @"date" : @"12", @"datas" : @[
                    @{@"title" : @"工银货币", @"orgin" : @"10000.00", @"earn" : @"10.11"},
                    @{@"title" : @"车金融B444号", @"orgin" : @"10000.00", @"earn" : @"10.11"},
                    @{@"title" : @"南方现金货币", @"orgin" : @"10000.00", @"earn" : @"10.11"}]
            },
            @{@"year" : @"2014", @"month" : @"11", @"date" : @"12", @"datas" : @[
                    @{@"title" : @"诚信货币", @"orgin" : @"1500.00", @"earn" : @"10.11"}]
            },
            @{@"year" : @"2014", @"month" : @"11", @"date" : @"12", @"datas" : @[
                    @{@"title" : @"诚信货币", @"orgin" : @"80.00", @"earn" : @"8.11"}]
            },
            @{@"year" : @"2014", @"month" : @"12", @"date" : @"12", @"datas" : @[
                    @{@"title" : @"工银货币", @"orgin" : @"10000.00", @"earn" : @"10.11"},
                    @{@"title" : @"车金融B444号", @"orgin" : @"10000.00", @"earn" : @"10.11"},
                    @{@"title" : @"南方现金货币", @"orgin" : @"10000.00", @"earn" : @"10.11"}]
            }
    ];
    [_listView reloadData];
    CGFloat  newHeight = _flowLayout.collectionViewContentSize.height;
    _listViewHeightConstrain.constant =newHeight > (SCREEN_HEIGHT - 64) ? (SCREEN_HEIGHT - 64) : newHeight;

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger num = _datas ? [[[_datas objectAtIndex:section] valueForKey:@"datas"] count] : 0;
    return num;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {


    MyHistoryDetailCell *cell = [self.listView dequeueReusableCellWithReuseIdentifier:@"MyHistoryDetailCell" forIndexPath:indexPath];

    NSArray *dataAtSection = [[_datas objectAtIndex:indexPath.section] valueForKey:@"datas"];
    NSDictionary *dictionary = [dataAtSection objectAtIndex:indexPath.item];
    cell.hTitle = [dictionary objectForKey:@"title"];
    cell.orgin = [dictionary objectForKey:@"orgin"];
    cell.earn = [dictionary objectForKey:@"earn"];

    cell.year = nil;
    cell.month = nil;
    cell.date = nil;

    cell.roundContainer.layer.cornerRadius = 5;
    cell.roundContainer.layer.borderWidth = 1;
    cell.roundContainer.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    cell.roundContent.layer.cornerRadius = 2;

    if (indexPath.item == 0) {
        cell.year = [[_datas objectAtIndex:indexPath.section] valueForKey:@"year"];
        cell.month = [[_datas objectAtIndex:indexPath.section] valueForKey:@"month"];
        cell.date = [[_datas objectAtIndex:indexPath.section] valueForKey:@"date"];
        cell.status = firstAtSetion;
        if (indexPath.section == 0) {
            cell.status = firstAtSetion | firstSetion;
        }
    }
    if (indexPath.item == [dataAtSection count] - 1) {
        cell.status = cell.status ? cell.status | lastAtSetion : lastAtSetion;
    } else {
        cell.status = cell.status ? cell.status : positionNone;
    }

    return cell;

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_datas count];
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


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {

        UICollectionViewCell *view = [self.listView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHistoryDetailHeader" forIndexPath:indexPath];

        return view;
    }
    return nil;
}

@end
