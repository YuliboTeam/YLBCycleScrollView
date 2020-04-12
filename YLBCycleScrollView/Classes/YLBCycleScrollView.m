//
//  YLBCycleScrollView.m
//  YLBCycleScrollView_Example
//
//  Created by yulibo on 2020/4/10.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import "YLBCycleScrollView.h"
#import <YLBCommon/YLBCommon.h>
#import "UIScrollView+YLBPagingEnable.h"

@interface YLBCycleScrollView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation YLBCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<YLBCycleScrollViewDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = UIColor.grayColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _flowLayout.itemSize = CGSizeMake(300, 100);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
//        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _flowLayout;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
#ifdef DEBUG
    cell.contentView.backgroundColor = YLBRandomColor;
    if (indexPath.row == self.dataArray.count - 1) {
        cell.contentView.backgroundColor = UIColor.redColor;
    }
#endif
    return cell;
}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGSize cellSize = CGSizeZero;
//    
//    CGFloat scaleX = 1.2;
//    CGFloat scaleY = 1.2;
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
//    cell.layer.transform = CATransform3DMakeScale(scaleX, scaleY, 1.0);
//    
//    UIEdgeInsets insets = UIEdgeInsetsMake(5, 5, 5, 5);
//    CGRect originCellFrame = CGRectMake(cell.ylb_x, cell.ylb_y, 300, 100);
//    cellSize = UIEdgeInsetsInsetRect(originCellFrame, insets).size;
//    
//    return cellSize;
//}

- (void)ylb_reloadData {
    [self.collectionView reloadData];
}
#pragma mark - scrollview

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    YLBDLog(@"scrollView_contentOffset = %@",NSStringFromCGPoint(scrollView.contentOffset))
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    [scrollView ylb_scrollViewDidEndDecelerating:scrollView ylb_cellSize:self.flowLayout.itemSize ylb_cellCount:self.dataArray.count];

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
    [scrollView ylb_scrollViewDidEndDragging:scrollView willDecelerate:decelerate ylb_cellSize:self.flowLayout.itemSize ylb_cellCount:self.dataArray.count];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
}

@end
