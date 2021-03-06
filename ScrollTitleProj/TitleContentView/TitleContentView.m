//
//  TitleContentView.m
//  collectionView
//
//  Created by dxs on 2017/4/13.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "TitleContentView.h"
#import "TitleContentViewItem.h"

#define kLplitScreenLimitValue      5

@interface TitleContentView ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *cellDict;
@property (nonatomic, strong) TitleContentViewItem *currentSelectItem;
@property (nonatomic, strong) NSIndexPath *currentIndexpath;

@end

@implementation TitleContentView

- (void)titleContentViewWithFrame:(CGRect)frame contentView:(UIView *)view sourceArray:(NSArray *)array {
    _cellDict = [NSMutableDictionary dictionary];
    _dataArray = [NSMutableArray arrayWithArray:array];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    if (array.count < kLplitScreenLimitValue) {
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / array.count, frame.size.height);
    } else {
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / kLplitScreenLimitValue, frame.size.height);
    }
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.scrollEnabled = YES;
    [_collectionView registerClass:[TitleContentViewItem class] forCellWithReuseIdentifier:@"CellId"];
    [view addSubview:_collectionView];
}

- (void)didSelectNextItem {
    if ((_currentIndexpath.row + 1) < _dataArray.count) {
        [self collectionView:_collectionView didDeselectItemAtIndexPath:_currentIndexpath];
        _currentIndexpath = [NSIndexPath indexPathForRow:_currentIndexpath.row + 1 inSection:0];
        [self collectionView:_collectionView didSelectItemAtIndexPath:_currentIndexpath];
    }
}

- (void)didSelectPrefixItem {
    if (_currentIndexpath.row > 0) {
        [self collectionView:_collectionView didDeselectItemAtIndexPath:_currentIndexpath];
        _currentIndexpath = [NSIndexPath indexPathForRow:_currentIndexpath.row - 1 inSection:0];
        [self collectionView:_collectionView didSelectItemAtIndexPath:_currentIndexpath];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleContentViewItem *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    cell.titleLab.text = _dataArray[indexPath.row];
    if (indexPath.row == 0) {
       [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        _currentIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        [cell.lineView setHidden:NO];
        [cell.titleLab setTextColor:[UIColor redColor]];
        [cell.titleLab setFont:[UIFont systemFontOfSize:18]];
        _currentSelectItem = cell;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //为collection view添加一个补充视图(页眉或页脚)
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    //设定页眉的尺寸
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    //设定页脚的尺寸
    return CGSizeMake(0, 0);
}

- (void)registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier {
    //添加页眉和页脚以前需要注册类和标识
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    //设定指定区内Cell的最小间距，也可以直接设置UICollectionViewFlowLayout的minimumInteritemSpacing属性
    return 0.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    //设定指定区内Cell的最小行距，也可以直接设置UICollectionViewFlowLayout的minimumLineSpacing属性
    return 0.f;
}

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //设置指定Cell的尺寸
    return CGSizeMake(10, 10);
}
*/

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //设定collectionView(指定区)的边距
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //当指定indexPath处的item被选择时触发
    TitleContentViewItem *cell = (TitleContentViewItem*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.lineView setHidden:NO];
    [cell.titleLab setTextColor:[UIColor redColor]];
    [cell.titleLab setFont:[UIFont systemFontOfSize:18]];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (![_currentSelectItem isEqual:cell]) {
        [self collectionView:_collectionView didDeselectItemAtIndexPath:_currentIndexpath];
    }
    _currentSelectItem = cell;
    _currentIndexpath = indexPath;

    
    //第一种方法：delegate 对外传参数
    if (_delegate && [_delegate respondsToSelector:@selector(itemDidClickReactionWithDictionary:)]) {
        [_delegate itemDidClickReactionWithDictionary:@{}];
    }
    
    //第二种方法：block 对外传参数
    __weak TitleContentView *weakSelf = self;
    weakSelf.selectItemBlock(indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    //当指定indexPath处的item取消选择时触发
    [_currentSelectItem.lineView setHidden:YES];
    [_currentSelectItem.titleLab setTextColor:[UIColor blackColor]];
    [_currentSelectItem.titleLab setFont:[UIFont systemFontOfSize:15]];
}


@end
