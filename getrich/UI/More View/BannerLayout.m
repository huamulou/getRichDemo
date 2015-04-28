//
//  BannerLayout.m
//  getrich
//
//  Created by huamulou on 14-10-30.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "BannerLayout.h"

@implementation BannerLayout



-(CGSize)collectionViewContentSize
{
    float width = 320 + (250 +15)*([self.collectionView numberOfItemsInSection:0 ] -1);
    float height= 160;
    CGSize  size = CGSizeMake(width, height);
    return size;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark - UICollectionViewLayout
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //3D代码
    UICollectionViewLayoutAttributes* attributes = attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    UICollectionView *collection = self.collectionView;
    float width = collection.frame.size.width;
    float height = collection.frame.size.height;
//    float x = collection.contentOffset.x;
//    CGFloat arc = M_PI * 2.0f;




//    int numberOfVisibleItems = 3;

    attributes.center = CGPointMake((250 +15) * indexPath.item + width/2,height/2);
    attributes.size = CGSizeMake(250.0f, 150.0f);





    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    if ([arr count] >0) {
        return arr;
    }
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < [self.collectionView numberOfItemsInSection:0 ]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

@end
