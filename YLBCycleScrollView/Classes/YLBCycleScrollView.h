//
//  YLBCycleScrollView.h
//  YLBCycleScrollView_Example
//
//  Created by yulibo on 2020/4/10.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YLBCycleScrollViewDelegate <NSObject>

@optional

@end

@interface YLBCycleScrollView : UIView
@property(nonatomic, weak) id<YLBCycleScrollViewDelegate> delegate;
@property (nonatomic, strong) UIImage *placeholderImage;//占位图
@property(nonatomic, strong) NSMutableArray *dataArray;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<YLBCycleScrollViewDelegate>)delegate;
- (void)ylb_reloadData;
@end

NS_ASSUME_NONNULL_END
