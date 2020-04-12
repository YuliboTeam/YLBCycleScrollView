//
//  YULIBOViewController.m
//  YLBCycleScrollView
//
//  Created by ProBobo on 04/10/2020.
//  Copyright (c) 2020 ProBobo. All rights reserved.
//

#import "YULIBOViewController.h"
#import <YLBCycleScrollView/YLBCycleScrollView.h>
#import <YLBCommon/YLBCommon.h>
@interface YULIBOViewController ()<YLBCycleScrollViewDelegate>

@end

@implementation YULIBOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    YLBCycleScrollView *cycleScrollView = [[YLBCycleScrollView alloc] initWithFrame:CGRectMake(0, YLBStatusBarHeight + YLBNavigationBarHeight, self.view.ylb_width, 100) delegate:self];
    [self.view addSubview:cycleScrollView];
    
    cycleScrollView.dataArray = [@[@"1",@"2",@"3",@"4",@"5",@"6"] mutableCopy];
    [cycleScrollView ylb_reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
