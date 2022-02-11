//
//  ShopView.m
//  mcn
//
//  Created by by.huang on 2020/8/18.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "ShopView.h"
#import "ShopViewCell.h"
#import "ShopViewModel.h"
#import "UIButton+Extension.h"

#define BottomDefaultH STHeight(104)
#define BottomMoveH STHeight(70)

@interface ShopView()<UITableViewDelegate,UITableViewDataSource,ShopViewDelegate>

@property(strong, nonatomic)MainViewModel *mainVM;
@property(strong, nonatomic)UIView *bottomView;
@property(strong, nonatomic)UIButton *manageBtn;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)ShopViewModel *mViewModel;
@property(strong, nonatomic)UIButton *allBtn;
@property(strong, nonatomic)UILabel *totalLabel;
@property(strong, nonatomic)UIButton *cooperateBtn;
//是否全选
@property(assign, nonatomic)Boolean isAllSelect;
//按钮是否吸底
@property(assign, nonatomic)Boolean isBottom;
//是否删除状态
@property(assign, nonatomic)Boolean isDelete;
@property(strong, nonatomic)UIView *noDataView;

@end

@implementation ShopView{
    CGFloat tabHeight;
}

-(instancetype)initWithViewModel:(MainViewModel *)mainVM{
    if(self == [super init]){
        _mainVM = mainVM;
        _mViewModel = [[ShopViewModel alloc]init];
        _mViewModel.delegate = self;
        
        [self initView];
        [_mViewModel reqeustList];
    }
    return self;
}

-(void)initView{
    
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    
    tabHeight = homeHeight + STHeight(62);
    
    UIImageView *topBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(157))];
    topBgView.image = [UIImage imageNamed:IMAGE_SHOP_BG];
    topBgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:topBgView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(25)] text:@"选品站" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(25) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(59), titleSize.width, STHeight(36));
    [self addSubview:titleLabel];
    
    _manageBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"管理" textColor:cwhite backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    _manageBtn.frame = CGRectMake(ScreenWidth - STWidth(70), STHeight(65), STWidth(70), STHeight(25));
    [_manageBtn addTarget:self action:@selector(onManageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_manageBtn];
    
    [self initTableView];
    [self initBottomView];
    [self initNoDataView];
}

-(void)initNoDataView{
    _noDataView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(118), STWidth(345), STHeight(332))];
    _noDataView.backgroundColor = cwhite;
    _noDataView.layer.cornerRadius = 4;
    _noDataView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _noDataView.layer.shadowOffset = CGSizeMake(0,2);
    _noDataView.layer.shadowOpacity = 1;
    _noDataView.layer.shadowRadius = 10;
    _noDataView.hidden = YES;
    [self addSubview:_noDataView];
    
    UIImageView *noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake((STWidth(345) - STHeight(160))/2, STHeight(64), STHeight(160), STHeight(160))];
    noDataImageView.image = [UIImage imageNamed:IMAGE_NO_DATA];
    noDataImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_noDataView addSubview:noDataImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:@"您的选品站为空哦~" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    nameLabel.frame = CGRectMake(0, STHeight(234), STWidth(345), STHeight(21));
    [_noDataView addSubview:nameLabel];
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(114), ScreenWidth, ScreenHeight - STHeight(114) - BottomDefaultH - tabHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = c15;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView useDefaultProperty];
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    
    [self addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopModel *shopModel = [_mViewModel.datas objectAtIndex:indexPath.row];
    return STHeight(75) + shopModel.skuModels.count * STHeight(136);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShopViewCell identify]];
    if(!cell){
        cell = [[ShopViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ShopViewCell identify]];
    }
    cell.detailBtn.tag = indexPath.row;
    [cell.detailBtn addTarget:self action:@selector(goMerchantDetailPage:) forControlEvents:UIControlEventTouchUpInside];
    cell.allSelectBtn.tag = indexPath.row;
    [cell.allSelectBtn addTarget:self action:@selector(onItemAllClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor clearColor];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:_mViewModel position:indexPath.row];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)updateView{
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [self updateTotalCount];
}


-(void)refreshNew{
    [_mViewModel reqeustList];
}


-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_SHOPCART_LIST]){
        _isAllSelect = NO;
        [_allBtn setImage:[UIImage imageNamed:IMAGE_NO_SELECT] forState:UIControlStateNormal];
        if(IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
            _noDataView.hidden = NO;
            _tableView.hidden = YES;
        }else{
            _noDataView.hidden = YES;
            _tableView.hidden = NO;
            [self updateView];
            
        }
    }else if([respondModel.requestUrl containsString:URL_SHOPCART_REMOVE]){
        [STShowToast show:@"删除成功!"];
        [self refreshNew];
    }else if([respondModel.requestUrl isEqualToString:URL_SHOPCART_BATCH_REMOVE]){
        [STShowToast show:@"删除成功!"];
        [self refreshNew];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


/********************** tableview ****************************/


-(void)initBottomView{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - BottomDefaultH - tabHeight, ScreenWidth, BottomDefaultH)];
    _bottomView.backgroundColor = cwhite;
    _bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0,2);
    _bottomView.layer.shadowOpacity = 1;
    _bottomView.layer.shadowRadius = 10;
    [self addSubview:_bottomView];
    
    _allBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"全选" textColor:c10 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    [_allBtn setImage:[UIImage imageNamed:IMAGE_NO_SELECT] forState:UIControlStateNormal];
    _allBtn.frame = CGRectMake(STWidth(15), STHeight(27), STWidth(50), STHeight(20));
    [_allBtn addTarget:self action:@selector(onAllBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_allBtn];
    
    [_allBtn imageLayout:ImageLayoutLeft centerPadding:STWidth(5)];
    
    _totalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)] text:@"合计：\n0件商品" textAlignment:NSTextAlignmentRight textColor:c10 backgroundColor:nil multiLine:YES];
    CGSize totalSize = [_totalLabel.text sizeWithMaxWidth:STWidth(100) font:STFont(14) fontName:FONT_SEMIBOLD];
    _totalLabel.frame = CGRectMake(ScreenWidth - STWidth(226), STHeight(16), STWidth(100), totalSize.height);
    [_bottomView addSubview:_totalLabel];
    
    _cooperateBtn = [[UIButton alloc]initWithFont:STFont(15) text:@"合作" textColor:cwhite backgroundColor:c16 corner:4 borderWidth:0 borderColor:nil];
    _cooperateBtn.frame = CGRectMake(STWidth(260), STHeight(15), STWidth(100), STHeight(40));
    [_cooperateBtn addTarget:self action:@selector(onCooperateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_cooperateBtn];
}


-(void)onCooperateBtnClick{
    if(_isDelete){
        [self deleteMulProduct];
    }else{
        [self goCoopertaionPage];
    }
}

-(void)deleteMulProduct{
    int count = 0;
    NSMutableArray *tempDatas = [[NSMutableArray alloc]init];
    for(ShopModel *model in _mViewModel.datas){
        [tempDatas addObject:model];
    }
    NSMutableArray *skuIds = [[NSMutableArray alloc]init];
    for(ShopModel *shopModel in tempDatas){
        if(shopModel.isAllSelect){
            for(ShopSkuModel *skuModel in shopModel.skuModels){
                [skuIds addObject:skuModel.skuId];
                count ++;
            }
        }else{
            for(ShopSkuModel *skuModel in shopModel.skuModels){
                if(skuModel.isSelect){
                    count ++;
                    [skuIds addObject:skuModel.skuId];
                }
            }
        }
    }
    if(count == 0){
        [LCProgressHUD showMessage:@"请选择一个商品进行操作"];
        return;
    }
    [_mViewModel deleteMulSku:skuIds];
}

-(void)goCoopertaionPage{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for(ShopModel *shopModel in _mViewModel.datas){
        if(shopModel.isAllSelect){
            [datas addObject:[shopModel copy]];
        }else{
            NSMutableArray *skuModels = [[NSMutableArray alloc]init];
            for(ShopSkuModel *skuModel in shopModel.skuModels){
                if(skuModel.isSelect){
                    [skuModels addObject:skuModel];
                }
            }
            if(!IS_NS_COLLECTION_EMPTY(skuModels)){
                ShopModel *newModel = [shopModel copy];
                newModel.skuModels = skuModels;
                [datas addObject:newModel];
            }
        }
    }
    if(IS_NS_COLLECTION_EMPTY(datas)){
        [LCProgressHUD showMessage:@"请选择一个商品进行操作"];
        return;
    }
    [_mainVM goCooperationPage:datas];
}

-(Boolean)hasCheckOne{
    Boolean hasCheckOne = NO;
    
    return hasCheckOne;
}


-(void)onManageBtnClick{
    _isDelete = !_isDelete;
    if(_isDelete){
        [_manageBtn setTitle:@"完成" forState:UIControlStateNormal];
        _totalLabel.hidden = YES;
        [_cooperateBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_cooperateBtn setTitleColor:c20 forState:UIControlStateNormal];
        _cooperateBtn.backgroundColor = cwhite;
        _cooperateBtn.layer.borderWidth = 1;
        _cooperateBtn.layer.borderColor = c20.CGColor;
        
    }else{
        [_manageBtn setTitle:@"管理" forState:UIControlStateNormal];
        _totalLabel.hidden = NO;
        [_cooperateBtn setTitle:@"合作" forState:UIControlStateNormal];
        [_cooperateBtn setTitleColor:cwhite forState:UIControlStateNormal];
        _cooperateBtn.backgroundColor = c16;
        _cooperateBtn.layer.borderWidth = 0;
        _cooperateBtn.layer.borderColor = c16.CGColor;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    WS(weakSelf)
    if(y > ScreenHeight / 3){
        if(!_isBottom){
            _isBottom = YES;
            //            _tableView.size = CGSizeMake(ScreenWidth, ScreenHeight - STHeight(114) - BottomMoveH);
            [UIView animateWithDuration:0.3f animations:^{
                weakSelf.bottomView.frame = CGRectMake(0, ScreenHeight - BottomMoveH, ScreenWidth, BottomMoveH);
            }];
            [_mainVM hiddenBottomView:YES];
        }
    }else{
        if(_isBottom){
            _isBottom = NO;
            //            _tableView.size = CGSizeMake(ScreenWidth, ScreenHeight - STHeight(114) - BottomDefaultH - tabHeight);
            [UIView animateWithDuration:0.3f animations:^{
                weakSelf.bottomView.frame = CGRectMake(0, ScreenHeight - BottomDefaultH - self->tabHeight, ScreenWidth, BottomDefaultH);
            }];
            [_mainVM hiddenBottomView:NO];
        }
    }
}

-(void)onAllBtnClick{
    [_allBtn setImage:[UIImage imageNamed:_isAllSelect ? IMAGE_NO_SELECT : IMAGE_SELECT] forState:UIControlStateNormal];
    _isAllSelect = !_isAllSelect;
    for(ShopModel *shopModel in _mViewModel.datas){
        shopModel.isAllSelect = _isAllSelect;
        for(ShopSkuModel *skuModel in shopModel.skuModels){
            skuModel.isSelect = _isAllSelect;
        }
    }
    [self updateView];
    
}


-(void)onItemAllClick:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    ShopModel *shopModel = [_mViewModel.datas objectAtIndex:tag];
    shopModel.isAllSelect = !shopModel.isAllSelect;
    for(ShopSkuModel *skuModel in shopModel.skuModels){
        skuModel.isSelect = shopModel.isAllSelect;
    }
    //所有选择检查
    _isAllSelect = YES;
    for(ShopModel *shopModel in _mViewModel.datas){
        if(!shopModel.isAllSelect){
            _isAllSelect = NO;
            break;
        }
    }
    [_allBtn setImage:[UIImage imageNamed:_isAllSelect ? IMAGE_SELECT : IMAGE_NO_SELECT] forState:UIControlStateNormal];
    [self updateView];
    
}

-(void)goMerchantDetailPage:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    ShopModel *shopModel = [_mViewModel.datas objectAtIndex:tag];
    [_mainVM goPartnerMerchantPage:shopModel.mchId];
}


-(void)onUpdateTableView:(NSInteger)position tag:(NSInteger)tag{
    ShopModel *shopModel = [_mViewModel.datas objectAtIndex:position];
    ShopSkuModel *model = [shopModel.skuModels objectAtIndex:tag];
    model.isSelect = !model.isSelect;
    if(!model.isSelect){
        shopModel.isAllSelect = NO;
    }else{
        Boolean isAllSelect = YES;
        for(ShopSkuModel *skuModel in shopModel.skuModels){
            if(!skuModel.isSelect){
                isAllSelect = NO;
                break;
            }
        }
        shopModel.isAllSelect = isAllSelect;
    }
    //所有选择检查
    _isAllSelect = YES;
    for(ShopModel *shopModel in _mViewModel.datas){
        if(!shopModel.isAllSelect){
            _isAllSelect = NO;
            break;
        }
    }
    [_allBtn setImage:[UIImage imageNamed:_isAllSelect ? IMAGE_SELECT : IMAGE_NO_SELECT] forState:UIControlStateNormal];
    [self updateView];
}

-(void)updateTotalCount{
    int count = 0;
    for(ShopModel *shopModel in _mViewModel.datas){
        for(ShopSkuModel *skuModel in shopModel.skuModels){
            if(skuModel.isSelect){
                count++;
            }
        }
    }
    _totalLabel.text = [NSString stringWithFormat:@"合计：\n%d件商品",count];
    CGSize totalSize = [_totalLabel.text sizeWithMaxWidth:STWidth(100) font:STFont(14) fontName:FONT_SEMIBOLD];
    _totalLabel.frame = CGRectMake(ScreenWidth - STWidth(226), STHeight(16), STWidth(100), totalSize.height);}

@end


