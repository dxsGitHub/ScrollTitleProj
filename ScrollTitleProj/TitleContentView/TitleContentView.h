//
//  TitleContentView.h
//  collectionView
//
//  Created by dxs on 2017/4/13.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^SelectItemBlock)(NSInteger index);

@class TitleContentView;

@protocol TitleContentViewDelegate <NSObject>

- (void)itemDidClickReactionWithDictionary:(NSDictionary *)dictionary;

@end


@interface TitleContentView : NSObject<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) SelectItemBlock selectItemBlock;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) id<TitleContentViewDelegate>delegate;

- (void)titleContentViewWithFrame:(CGRect)frame contentView:(UIView *)view sourceArray:(NSArray *)array;

- (void)didSelectNextItem;

- (void)didSelectPrefixItem;

@end
