//
//  HomeSearchView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "HomeSearchView.h"
#import "HomeListViewCell.h"
#import "ShopModel.h"

@interface HomeSearchView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong, nonatomic)HomeSearchViewModel *mViewModel;
@property(strong, nonatomic)UITextField *searchTF;
@property(strong, nonatomic)UICollectionView *collectionView;

@end

@implementation HomeSearchView

-(instancetype)initWithViewModel:(HomeSearchViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(70))];
    view.backgroundColor = cwhite;
    [self addSubview:view];
    
    _searchTF = [[UITextField alloc]initWithFont:STFont(14) textColor:c10 backgroundColor:c03 corner:4 borderWidth:0 borderColor:nil padding:STWidth(40)];
    [_searchTF setPlaceholder:@"搜索你想要的" color:c05 fontSize:STFont(14)];
    _searchTF.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(40));
    _searchTF.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _searchTF.layer.shadowOffset = CGSizeMake(0,2);
    _searchTF.layer.shadowOpacity = 1;
    [_searchTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _searchTF.layer.shadowRadius = 10;
    [self addSubview:_searchTF];
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(10), STHeight(20), STHeight(20))];
    searchImageView.image = [UIImage imageNamed:IMAGE_SEARCH];
    searchImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_searchTF addSubview:searchImageView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, STHeight(70), ScreenWidth, ContentHeight - STHeight(70)) collectionViewLayout:layout];
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
    return UIEdgeInsetsMake(5, 15, 5, 15);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _mViewModel.datas.count / 2;
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
    ProductModel *model = [_mViewModel.datas objectAtIndex:indexPath.section * 2 + indexPath.row];
    [cell updateData:model];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = [_mViewModel.datas objectAtIndex:indexPath.section * 2 + indexPath.row];
    [_mViewModel goProductDetailPage:model.skuId];
    
}



-(void)updateView{
    [_collectionView reloadData];
    [_collectionView.mj_header endRefreshing];
    [_collectionView.mj_footer endRefreshing];
}


-(void)refreshNew{
    [_mViewModel requestGoodsList:YES];
    
}

-(void)uploadMore{
    [_mViewModel requestGoodsList:NO];
}


-(void)onRequestNoDatas:(Boolean)isFirst{
    if(isFirst){
        NSLog(@"无数据页面");
    }else{
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}



/********************** tableview ****************************/


-(void)onCooperationBtnClick:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    ProductModel *productModel = [_mViewModel.datas objectAtIndex:tag];
    
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
    [_mViewModel goCooperationPage:datas];}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(_searchTF.isFirstResponder){
        [_searchTF resignFirstResponder];
    }
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_searchTF resignFirstResponder];
}

- (void)textFieldDidChange:(UITextField *)textField{
    _mViewModel.key = textField.text;
    [_mViewModel requestGoodsList:YES];
}
@end

