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

#import "CrowdFundingListViewController.h"
#import "Constants.h"
#import "CrowdFundingListCell.h"
#import "UIColor+Hex.h"
#import "UIViewController+Extend.h"
#import "FundDetailViewController.h"
#import "DABViewController.h"
#import "CrowdfundingDetailViewController.h"

#define  CrowdFundingListCellReuseIdentifier @"CrowdFundingListCellReuseIdentifier"
#define  CFLLineView @"CFLLineView"

@interface CrowdFundingListViewController ()
@end

@implementation CrowdFundingListViewController {

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}


- (void)setUp {

    _flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 86);
//    _flowLayout.dele = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CFLLineView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    self.collectionView.contentInset = UIEdgeInsetsMake(-0.5, 0, 0, 0);


}

- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    CrowdFundingListCell *cell = (CrowdFundingListCell * )[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
}

- (void)collectionView:(UICollectionView *)colView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    CrowdFundingListCell *cell = (CrowdFundingListCell * )[self.collectionView cellForItemAtIndexPath:indexPath];
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

    CrowdFundingListCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CrowdFundingListCellReuseIdentifier forIndexPath:indexPath];

    NSDictionary *dictionary = [_datas objectAtIndex:indexPath.item];
    cell.desc = [dictionary objectForKey:@"desc"];
    cell.title = [dictionary objectForKey:@"title"];
    cell.restrict0 = [dictionary objectForKey:@"restrict0"];
    cell.restrict1 = [dictionary objectForKey:@"restrict1"];
    cell.percent = [[dictionary objectForKey:@"percent"] floatValue];
//     if([_seletedCellIndex isEqual:indexPath ]&& _seleteCellAnimating){
//         cell.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
//     } else{
//         cell.backgroundColor = [UIColor whiteColor];
//     }
//


    if (_pageIndex == 2) {
        cell.restrictLabel.textColor = [UIColor colorWithHexString:@"#FF5100"];
        cell.restrictLabel1.textColor = [UIColor colorWithHexString:@"#666666"];
    }

    return cell;

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    NSDictionary *data = [_datas objectAtIndex:indexPath.item];
    if (_pageIndex == 0 || _pageIndex == 2) {

        FundDetailViewController *detailViewController = (FundDetailViewController *)[self sbNamed:@"DetailAndBuy" vcOfsbNamed:@"FundDetailView"];

                detailViewController.fundTitle = [data objectForKey:@"title"];
     

//        [self presentViewController:detailViewController animated:YES completion:^{
//
//        }];
        [[self navigationController] pushViewController:detailViewController animated:YES];

    } else{
        CrowdfundingDetailViewController *detailViewController = (CrowdfundingDetailViewController *)[self sbNamed:@"DetailAndBuy" vcOfsbNamed:@"CrowdfundingDetailViewController"];
      
                detailViewController.fundTitle = [data objectForKey:@"title"];
        

        [[self navigationController] pushViewController:detailViewController animated:YES];

    }

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

        UICollectionViewCell *view = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CFLLineView forIndexPath:indexPath];
        view.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        return view;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 0.5);
}


@end