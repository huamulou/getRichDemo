//
//  MoreViewController.m
//  getrich
//
//  Created by huamulou on 14-10-30.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "MoreViewController.h"
#import "BannerCell.h"
#import "BannerLayout.h"
#import "UIColor+Hex.h"
#import "UIViewController+Extend.h"
#import "UIViewController+HMLSlidingViewController.h"
#import "HMLSlidingViewController.h"

@interface MoreViewController ()
@property(nonatomic, strong) NSMutableArray *datas;
@property(nonatomic, strong) NSArray *orginDatas;
@property(nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view..
    [self setUp];
    [self dataModify];

    [self.listView.collectionViewLayout prepareLayout];
    UIPanGestureRecognizer *edgeGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doingPan:)];
    edgeGestureRecognizer.delegate = self;
    [self .view addGestureRecognizer:edgeGestureRecognizer];

}

- (void)doingPan:(UIScreenEdgePanGestureRecognizer *)recognizer {
    [self.hmlSlidingViewController updateWithRecognizer:recognizer];
}


- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.view];
    CGPoint transition = [gestureRecognizer translationInView:self.view];
    
    CGFloat startx = point.x  -transition.x;
    
    if([self isAtLeftOrRightByStartX: startx]) {
        return YES;
    }
    return NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self move];
}


- (void)move {
    [[self listView] setContentOffset:CGPointMake(265 * 2, 0)];

}

- (void)dataModify {

    if (_orginDatas) {
        _datas = [_orginDatas mutableCopy];
        [_datas insertObject:[_orginDatas objectAtIndex:[_orginDatas count] - 1] atIndex:0];
        if ([_datas count] >= 2) {
            [_datas insertObject:[_orginDatas objectAtIndex:[_orginDatas count] - 2] atIndex:0];
        } else {
            [_datas insertObject:[_orginDatas objectAtIndex:0] atIndex:0];
        }

        [_datas addObject:[_orginDatas objectAtIndex:0]];
        if ([_datas count] >= 2) {
            [_datas addObject:[_orginDatas objectAtIndex:1]];
        } else {
            [_datas addObject:[_orginDatas objectAtIndex:0]];
        }
    }
    [self.listView reloadData];

}


- (void)mockData {
    _orginDatas = @[@"1.jpg", @"2.jpg", @"3.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

- (void)setUp {
    _friendsView.layer.cornerRadius = 2;
    _friendsView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    _friendsView.layer.borderWidth = 1;

    _myCoinView.layer.cornerRadius = 2;
    _myCoinView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    _myCoinView.layer.borderWidth = 1;


    _featuresView.layer.cornerRadius = 2;
    _featuresView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    _featuresView.layer.borderWidth = 1;


    UITapGestureRecognizer *tapGesture    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    UITapGestureRecognizer *tapGesture1    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    UITapGestureRecognizer *tapGesture2    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    UITapGestureRecognizer *tapGesture3    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    UITapGestureRecognizer *tapGesture4    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    [_myCoinView addGestureRecognizer:tapGesture];
    [_friendsView addGestureRecognizer:tapGesture1];
    [_infoCenter addGestureRecognizer:tapGesture2];
    [_infoRight addGestureRecognizer:tapGesture3];
    [_infoLeft addGestureRecognizer:tapGesture4];


    [self mockData];
    self.listView.collectionViewLayout = [[BannerLayout alloc] init];
//    [self.listView ]
    [self listView].showsHorizontalScrollIndicator = NO;


}

-(void)clickView:(UITapGestureRecognizer *) recognizer{

    UIView *view = recognizer.view;
    view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [UIView animateWithDuration:0.2 animations:^{
        view.backgroundColor = [UIColor whiteColor];
    }];
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger num = _datas ? [_datas count] : 0;
    return num;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    //  NSLog(@"MoreViewController init cell");
    BannerCell *cell = [self.listView dequeueReusableCellWithReuseIdentifier:@"BannerCell" forIndexPath:indexPath];

    NSString *imageOfIndex = [_datas objectAtIndex:indexPath.item];
    cell.imageVIew.layer.cornerRadius = 10;
    cell.imageVIew.layer.borderWidth = 0;
    cell.imageVIew.layer.masksToBounds = YES;
    cell.imageVIew.image = [UIImage imageNamed:imageOfIndex];

    return cell;

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"MyMoneyViewController-%@", indexPath);


}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
//{
//    //无限循环....
//    float targetX = _scrollView.contentOffset.x;
//    int numCount = [self.listView numberOfItemsInSection:0];
//    float ITEM_WIDTH = _scrollView.frame.size.width;
//
//    if (numCount>=3)
//    {
//        if (targetX < ITEM_WIDTH/2) {
//            [_scrollView setContentOffset:CGPointMake(targetX+ITEM_WIDTH *numCount, 0)];
//        }
//        else if (targetX >ITEM_WIDTH/2+ITEM_WIDTH *numCount)
//        {
//            [_scrollView setContentOffset:CGPointMake(targetX-ITEM_WIDTH *numCount, 0)];
//        }
//    }
//
//}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {


    CGFloat x = _listView.contentOffset.x;
    CGFloat frameLength = _listView.frame.size.width;
    CGFloat pageLength = 250 + 30;
    CGFloat firstPageLength = 250 + 15;

    CGFloat edgeSize = (frameLength - pageLength) / 2;
    CGFloat moveLength = firstPageLength;
    if (x > _lastContentOffset) {
        int j = x / moveLength;
        j = (x > (moveLength * j)) ? (j + 1) : j;

        CGFloat newx = (j * moveLength);
        targetContentOffset->x = newx;
        if (_listView.contentOffset.x > (250 + 15) * ([self.orginDatas count] + 2)) {

            CGFloat offset = _listView.contentOffset.x - (250 + 15) * ([self.orginDatas count] + 2);
            self.listView.contentOffset = CGPointMake(265 * 3 - offset, 0);
            targetContentOffset->x = 265 * 3;
        }
    } else {
        if (x - 265 < 0) {
            self.listView.contentOffset = CGPointMake((250 + 15) * ([self.orginDatas count]) + (265 - x), 0);
            targetContentOffset->x = (250 + 15) * ([self.orginDatas count]);
        } else {
            int j = x / moveLength;
            j = (x > (moveLength * j)) ? (j + 1) : j;

            CGFloat newx = ((j - 1) * moveLength);
            targetContentOffset->x = newx;
        }
    }

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview {

    // Calculate where the collection view should be at the right-hand end item
    float contentOffsetWhenFullyScrolledRight = (250 + 15) * ([self.orginDatas count] + 2);

    if (_listView.contentOffset.x == contentOffsetWhenFullyScrolledRight) {

        NSLog(@"MoreViewController 1");
        self.listView.contentOffset = CGPointMake(265 * 2, 0);

    } else if (_listView.contentOffset.x == 265) {

        NSLog(@"MoreViewController 2");
        self.listView.contentOffset = CGPointMake((250 + 15) * ([self.orginDatas count] + 1), 0);

    } else if (_listView.contentOffset.x > contentOffsetWhenFullyScrolledRight) {

        NSLog(@"MoreViewController 3");
        self.listView.contentOffset = CGPointMake(265 * 3, 0);

    } else if (_listView.contentOffset.x < 265) {

        NSLog(@"MoreViewController 4");
        self.listView.contentOffset = CGPointMake((250 + 15) * ([self.orginDatas count]), 0);

    }
}

@end
