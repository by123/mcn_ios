//
//  PreviewView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PreviewView.h"
#import "PreviewViewCell.h"

@interface PreviewView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong, nonatomic)PreviewViewModel *mViewModel;
@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UICollectionView *collectionView;

@end

@implementation PreviewView

-(instancetype)initWithViewModel:(PreviewViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(44), 0, STWidth(287), ContentHeight - STHeight(150))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_showImageView];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        PreviewModel *model = _mViewModel.datas[0];
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(150), ScreenWidth, STHeight(150)) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[PreviewViewCell class] forCellWithReuseIdentifier:[PreviewViewCell identify]];
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(STHeight(30), STWidth(44), STHeight(30), STWidth(15));
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return STWidth(15);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _mViewModel.datas.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(STHeight(90), STHeight(90));
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PreviewViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PreviewViewCell identify] forIndexPath:indexPath];
    if(!cell){
        cell = [[PreviewViewCell alloc]initWithFrame:CGRectMake(0, 0, STHeight(90), STHeight(90))];
    }
    [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for(PreviewModel *model in _mViewModel.datas){
        model.isSelect = NO;
    }
    PreviewModel *model =  [_mViewModel.datas objectAtIndex:indexPath.row];
    model.isSelect = YES;
    [self updateView];
}

-(void)updateView{
    for(PreviewModel *model in _mViewModel.datas){
        if(model.isSelect){
            [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
        }
    }
    [_collectionView reloadData];
}

@end

