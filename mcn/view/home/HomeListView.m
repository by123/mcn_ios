
//
//  HomeListView.m
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "HomeListView.h"
#import "HomeListViewCell.h"
#import "HomeListViewModel.h"
#import "ShopModel.h"

@interface HomeListView()<UICollectionViewDelegate,UICollectionViewDataSource,HomeListViewModelDelegate>

@property(strong, nonatomic)UICollectionView *collectionView;
@property(strong, nonatomic)HomeListViewModel *homeListVM;
@property(strong, nonatomic)MainViewModel *mainVM;
@property(strong, nonatomic)UIView *noDataView;


@end

@implementation HomeListView


-(instancetype)initWithType:(NSString *)goodClass vm:(MainViewModel *)mainVM{
    if(self == [super init]){
        _mainVM = mainVM;
        _homeListVM = [[HomeListViewModel alloc]init];
        _homeListVM.goodClass = goodClass;
        _homeListVM.delegate = self;
        [self initView];
        [self initNoDataView];
        [_homeListVM requestGoodsList:YES];
    }
    return self;
}

-(void)initNoDataView{
    CGFloat homeHeight = 0;
      if (@available(iOS 11.0, *)) {
          homeHeight = HomeIndicatorHeight;
      } else {
          homeHeight = 0;
      }
      
    
    _noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - STHeight(240) - STHeight(62) - homeHeight)];
    _noDataView.hidden = YES;
    _noDataView.backgroundColor = cwhite;
    [self addSubview:_noDataView];
    
    UIImageView *noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STHeight(160))/2, STHeight(100), STHeight(160), STHeight(160))];
    noDataImageView.image = [UIImage imageNamed:IMAGE_NO_DATA];
    noDataImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_noDataView addSubview:noDataImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:@"暂无商品" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    nameLabel.frame = CGRectMake(0, STHeight(275), ScreenWidth, STHeight(21));
    [_noDataView addSubview:nameLabel];
}


-(void)initView{
    
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - STHeight(240) - STHeight(62) - homeHeight) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = cwhite;
    [self addSubview:_collectionView];
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _collectionView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
    _collectionView.mj_footer = footer;
    
    [_collectionView registerClass:[HomeListViewCell class] forCellWithReuseIdentifier:[HomeListViewCell identify]];
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(STHeight(10), STWidth(15), 0, STWidth(15));
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _homeListVM.datas.count / 2 + 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(STWidth(168), STHeight(330));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HomeListViewCell identify] forIndexPath:indexPath];
    if(!cell){
        cell = [[HomeListViewCell alloc]initWithFrame:CGRectMake(0, 0, STWidth(168), STHeight(330))];
    }
    cell.cooperationBtn.tag = indexPath.section * 2 + indexPath.row;
    [cell.cooperationBtn addTarget:self action:@selector(onCooperationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if(indexPath.section * 2 + indexPath.row >= _homeListVM.datas.count){
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
        ProductModel *model = [_homeListVM.datas objectAtIndex:indexPath.section * 2 + indexPath.row];
        [cell updateData:model];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = [_homeListVM.datas objectAtIndex:indexPath.section * 2 + indexPath.row];
    [_mainVM goProductPage:model.skuId];
}



-(void)updateView{
    _noDataView.hidden = YES;
    _collectionView.hidden = NO;
    [_collectionView reloadData];
    [_collectionView.mj_header endRefreshing];
    [_collectionView.mj_footer endRefreshing];
}


-(void)refreshNew{
    [_homeListVM requestGoodsList:YES];
    
}

-(void)uploadMore{
    [_homeListVM requestGoodsList:NO];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_GOODS_HOME_LIST]){
        [self updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onRequestNoDatas:(Boolean)isFirst{
    if(isFirst){
        _noDataView.hidden = NO;
        _collectionView.hidden = YES;
        NSLog(@"无数据页面");
    }else{
        _noDataView.hidden = YES;
        _collectionView.hidden = NO;
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}



/********************** tableview ****************************/


-(void)onCooperationBtnClick:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    ProductModel *productModel = [_homeListVM.datas objectAtIndex:tag];
    
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    ShopModel *shopModel = [[ShopModel alloc]init];
    //    shopModel.mchId = productModel.mchId;
    shopModel.supplierName = productModel.mchName;
    shopModel.avatar = productModel.picUrl;
    
    NSMutableArray *skuModels = [[NSMutableArray alloc]init];
    
    ShopSkuModel *skuModel = [[ShopSkuModel alloc]init];
    skuModel.skuId = productModel.skuId;
    skuModel.spuId = productModel.spuId;
    skuModel.spuName = productModel.spuName;
    skuModel.sellFlag = productModel.sellFlag;
    skuModel.sellPrice = productModel.sellPrice;
    skuModel.picUrl = productModel.skuPicOssUrl;
    skuModel.attribute = productModel.attribute;
    skuModel.allocateRatio = productModel.allocateRatio;
    
    [skuModels addObject:skuModel];
    shopModel.skuModels = skuModels;
    
    [datas addObject:shopModel];
    [_mainVM goCooperationPage:datas];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(_delegate){
        [_delegate scrollViewDidScroll:scrollView];
    }
}


@end
