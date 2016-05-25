//
//  LoopCollectionView.h
//  CollectionView横向纵向无限滚动
//
//  Created by 思久科技 on 16/5/25.
//  Copyright © 2016年 Seejoys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoopCollectionViewCell;
//滚动方向
typedef NS_ENUM(NSUInteger, ScrollDirection) {
    ScrollDirectionHorizontal = 0,
    ScrollDirectionVertical
};

@interface LoopCollectionView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>{
    UICollectionViewFlowLayout *_flowLayout;
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
}

@property (nonatomic, assign) ScrollDirection direction;    //方向

- (void)setDataSource:(NSArray *)array;

@end

@interface LoopCollectionViewCell : UICollectionViewCell

@end