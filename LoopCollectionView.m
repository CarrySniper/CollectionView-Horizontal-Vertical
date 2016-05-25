//
//  LoopCollectionView.m
//  CollectionView横向纵向无限滚动
//
//  Created by 思久科技 on 16/5/25.
//  Copyright © 2016年 Seejoys. All rights reserved.
//

#import "LoopCollectionView.h"

static NSString *identifier = @"LoopCollectionViewCellIdentifier";

@implementation LoopCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.itemSize                    = CGSizeMake(frame.size.width, frame.size.height);
        _flowLayout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing     = 0;
        _flowLayout.minimumLineSpacing          = 0;
        
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:frame
                                                    collectionViewLayout:_flowLayout];
        view.delegate   = self;
        view.dataSource = self;
        
        view.backgroundColor                = [UIColor clearColor];
        view.pagingEnabled                  = YES;
        view.bounces                        = NO;
        view.showsVerticalScrollIndicator   = NO;
        view.showsHorizontalScrollIndicator = NO;
        
        [view registerClass:[LoopCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        _collectionView = view;
        [self addSubview:_collectionView];
        
    }
    return self;
}


- (void)setDataSource:(NSArray *)array
{
    _dataArray = [array mutableCopy];
    if (array.count > 1)
    {
        [_dataArray insertObject:array[array.count - 1] atIndex:0];         // 第一个
        [_dataArray addObject:array[0]];                                    // 最后一个
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:NO];
    }else{
        _collectionView.scrollEnabled = NO;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (LoopCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LoopCollectionViewCell *cell = (LoopCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = _dataArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndex %ld", indexPath.item);
}

#pragma mark - UIScrollView 滚动代理
#pragma mark 移动位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.direction == ScrollDirectionHorizontal) {
        CGFloat offsetX = scrollView.contentOffset.x;
        if (offsetX >= (_dataArray.count - 1) * _collectionView.bounds.size.width)
        {
            // 显示第一张图。即数组中的第二个数据
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:NO];
        }else if (offsetX <= 0.0f)
        {
            // 显示最后一张图。即滚动到数组的倒数第二个数据。
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataArray.count - 2 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionRight
                                            animated:NO];
        }
    }else{
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY >= (_dataArray.count - 1) * _collectionView.bounds.size.height)
        {
            // 显示第一张图。即数组中的第二个数据
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionTop
                                            animated:NO];
        }else if (offsetY <= 0.0f)
        {
            // 显示最后一张图。即滚动到数组的倒数第二个数据。
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataArray.count - 2 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionBottom
                                            animated:NO];
        }
    }
    
}

#pragma mark UIScrollView 滚动方向
- (void)setDirection:(ScrollDirection)direction
{
    if (direction == ScrollDirectionHorizontal) {
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }else{
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    _direction = direction;
}

@end

@implementation LoopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end