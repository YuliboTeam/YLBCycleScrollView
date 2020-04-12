//
//  UIScrollView+YLBPagingEnable.h
//  GKCycleScrollView_Example
//
//  Created by yulibo on 2020/4/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (YLBPagingEnable)
// 当前显示的cell大小
@property (nonatomic,assign) CGSize ylb_cellSize;
// 当前显示的cell数量
@property(nonatomic, assign) NSInteger ylb_cellCount;
// scrollView
- (void)ylb_crollViewWithCellSize:(CGSize)ylb_cellSize ylb_cellCount:(NSInteger)ylb_cellCount;
- (void)ylb_scrollViewDidEndDecelerating:(UIScrollView *)scrollView ylb_cellSize:(CGSize)ylb_cellSize ylb_cellCount:(NSInteger)ylb_cellCount ;
- (void)ylb_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate ylb_cellSize:(CGSize)ylb_cellSize ylb_cellCount:(NSInteger)ylb_cellCount ;
// scrollView 停止滚动监测
- (void)ylb_scrollViewDidEndScroll:(UIScrollView *)scrollView ylb_cellSize:(CGSize)ylb_cellSize ylb_cellCount:(NSInteger)ylb_cellCount;
@end

NS_ASSUME_NONNULL_END
