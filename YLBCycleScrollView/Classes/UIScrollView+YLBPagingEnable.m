//
//  UIScrollView+YLBPagingEnable.m
//  GKCycleScrollView_Example
//
//  Created by yulibo on 2020/4/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import "UIScrollView+YLBPagingEnable.h"
#import <objc/runtime.h>

static char ylb_cellSize_key;
static char ylb_cellCount_key;
@implementation UIScrollView (YLBPagingEnable)
#pragma mark - ylb_cellSize
- (void)setYlb_cellSize:(CGSize)ylb_cellSize {
    NSValue *value = [NSValue valueWithCGSize:ylb_cellSize];
    objc_setAssociatedObject(self, &ylb_cellSize_key, value, OBJC_ASSOCIATION_ASSIGN);
}
- (CGSize)ylb_cellSize {
    return [objc_getAssociatedObject(self, &ylb_cellSize_key) CGSizeValue];
}
#pragma mark - ylb_cellCount
- (void)setYlb_cellCount:(NSInteger)ylb_cellCount {
    NSNumber *value = [NSNumber numberWithInteger:ylb_cellCount];
    objc_setAssociatedObject(self, &ylb_cellCount_key, value, OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)ylb_cellCount {
    return [objc_getAssociatedObject(self, &ylb_cellCount_key) integerValue];
}
#pragma mark - scrollView
/*
UIScrollView有三个Bool类型属性：tracking、dragging、decelerating，在滚动和结束滚动时都有自己的值。
在3种动作触发的两个方法中，tracking、dragging、decelerating 的Bool值分别为：

停止类型1：DidEndDecelerat:0,dragging:0,decelerating:0

停止类型2：DidEndDragging:tracking:1,dragging:0,decelerating:1 DidEndDecelerat:tracking:0,dragging:0,decelerating:0

停止类型3：DidEndDragging:tracking:1,dragging:0,decelerating:0

上面三种动作结束后，只要捕捉到tracking、dragging、decelerating的1个组合即可监测到UICollectionView的停止滚动。
*/
- (void)ylb_crollViewWithCellSize:(CGSize)ylb_cellSize ylb_cellCount:(NSInteger)ylb_cellCount{
    self.ylb_cellSize = ylb_cellSize;
    self.ylb_cellCount = ylb_cellCount;
}
- (void)ylb_scrollViewDidEndDecelerating:(UIScrollView *)scrollView ylb_cellSize:(CGSize)ylb_cellSize ylb_cellCount:(NSInteger)ylb_cellCount {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging &&    !scrollView.decelerating;
    if (scrollToScrollStop) {
       [self ylb_scrollViewDidEndScroll:scrollView ylb_cellSize:ylb_cellSize ylb_cellCount:ylb_cellCount];
    }

}
- (void)ylb_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate ylb_cellSize:(CGSize)ylb_cellSize ylb_cellCount:(NSInteger)ylb_cellCount {
    if (!decelerate) {
         // 停止类型3
         BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
         if (dragToDragStop) {
            [self ylb_scrollViewDidEndScroll:scrollView ylb_cellSize:ylb_cellSize ylb_cellCount:ylb_cellCount];
         }
    }
    
}
#pragma mark - scrollView 停止滚动监测

- (void)ylb_scrollViewDidEndScroll:(UIScrollView *)scrollView ylb_cellSize:(CGSize)cellSize ylb_cellCount:(NSInteger)cellCount {
    int index;
    index = (int)round(scrollView.contentOffset.x / cellSize.width) % cellCount;
    NSLog(@"scrollView index = %d", index);
    if (index < 1) {
        [scrollView setContentOffset:CGPointMake(cellSize.width * index, scrollView.contentOffset.y) animated:YES];
    }
    else {
        if (index == cellCount - 1) {
            CGFloat rightSpace = (self.frame.size.width - cellSize.width);
            [scrollView setContentOffset:CGPointMake(cellSize.width * (index) - rightSpace , scrollView.contentOffset.y) animated:YES];
        }
        else {
            [scrollView setContentOffset:CGPointMake(cellSize.width * index, scrollView.contentOffset.y) animated:YES];
        }
    }
}
@end
