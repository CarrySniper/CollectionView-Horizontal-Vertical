//
//  ViewController.m
//  CollectionView横向纵向无限滚动
//
//  Created by 思久科技 on 16/5/25.
//  Copyright © 2016年 Seejoys. All rights reserved.
//

#import "ViewController.h"
#import "LoopCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LoopCollectionView *loopView = [[LoopCollectionView alloc]initWithFrame:self.view.bounds];
    [loopView setDirection:ScrollDirectionHorizontal];
    [self.view addSubview:loopView];
    [loopView setDataSource:@[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor brownColor]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
