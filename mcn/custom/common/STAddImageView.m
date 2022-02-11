//
//  STAddImageView.m
//  mcn
//
//  Created by by.huang on 2020/8/20.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "STAddImageView.h"
#import "STAddImageViewCell.h"


@interface STAddImageView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong, nonatomic)UICollectionView *collectionView;

@end
@implementation STAddImageView

-(instancetype)initWithImages:(nullable NSMutableArray *)imgDatas{
    if(self == [super init]){
        if(!IS_NS_COLLECTION_EMPTY(imgDatas)){
            _imageDatas = imgDatas;
        }else{
            _imageDatas = [[NSMutableArray alloc]init];
        }
        [_imageDatas addObject:[PreviewModel new]];
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.frame = CGRectMake(0, 0, ScreenWidth, STHeight(125));
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(125)) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = cwhite;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[STAddImageViewCell class] forCellWithReuseIdentifier:[STAddImageViewCell identify]];

}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(STHeight(15), STWidth(15), STHeight(20), STWidth(15));
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return STWidth(20);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageDatas.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(STHeight(90), STHeight(90));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    STAddImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[STAddImageViewCell identify] forIndexPath:indexPath];
    if(!cell){
        cell = [[STAddImageViewCell alloc]initWithFrame:CGRectMake(0, 0, STHeight(90), STHeight(90))];
    }
    cell.addBtn.tag = indexPath.row;
    [cell.addBtn addTarget:self action:@selector(onAddBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell updateData:[_imageDatas objectAtIndex:indexPath.row]];
    return cell;
}



-(void)onAddBtnClick:(id)sender{
    UIButton *button = sender;
    NSInteger position = button.tag;
    if(_delegate){
        [_delegate onAddImageViewItemClick:position view:self];
    }
}

-(void)addDatas:(PreviewModel *)model{
    [_imageDatas insertObject:model atIndex:0];
    [_collectionView reloadData];
}

-(void)setDatas:(NSMutableArray *)imgDatas{
    [_imageDatas removeAllObjects];
    [_imageDatas addObjectsFromArray:imgDatas];
    [_imageDatas addObject:[PreviewModel new]];
    [_collectionView reloadData];
}

@end
