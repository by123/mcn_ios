//
//  ShelvesListView.m
//  mcn
//
//  Created by by.huang on 2020/8/21.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "ShelvesListView.h"
#import "ShelvesViewModel.h"
#import "ShelvesListViewCell.h"
#import "STDialog.h"

@interface ShelvesListView()<UITableViewDelegate, UITableViewDataSource,ShelvesViewDelegate,STDialogDelegate>

@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)ShelvesViewModel *mViewModel;
@property(strong, nonatomic)UIView *noDataView;
@property(strong, nonatomic)STDialog *dialog;
@property(copy, nonatomic)NSString *skuId;

@end

@implementation ShelvesListView

-(instancetype)initWithType:(ShelvesType)shelvesType{
    if(self == [super init]){
        _mViewModel = [[ShelvesViewModel alloc]init];
        _mViewModel.shelvesType = shelvesType;
        _mViewModel.delegate = self;
        [self initView];
        [_mViewModel requestShelvesList:YES];
    }
    return self;
}

-(void)initView{
    [self initTableView];
    [self initNoDataView];
    
    _dialog = [[STDialog alloc]initWithTitle:@"下架提醒" content:@"您确认要下架该商品吗？" subContent:nil size:CGSizeMake(STWidth(315), STHeight(200))];
    _dialog.hidden = YES;
    _dialog.delegate = self;
    [_dialog showConfirmBtn:YES cancelBtn:YES];
    [_dialog setConfirmBtnStr:@"确定" cancelStr:@"取消"];
    [STWindowUtil addWindowView:_dialog];
}

-(void)initNoDataView{
    _noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(38))];
    _noDataView.hidden = YES;
    _noDataView.backgroundColor = cwhite;
    [self addSubview:_noDataView];
    
    UIImageView *noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STHeight(160))/2, STHeight(140), STHeight(160), STHeight(160))];
    noDataImageView.image = [UIImage imageNamed:IMAGE_NO_DATA];
    noDataImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_noDataView addSubview:noDataImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:@"暂无商品" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    nameLabel.frame = CGRectMake(0, STHeight(315), ScreenWidth, STHeight(21));
    [_noDataView addSubview:nameLabel];
}



/********************** tableview ****************************/
-(void)initTableView{
    
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    
    CGFloat titleHeight = STHeight(107);
    CGFloat otherHeight = titleHeight + STHeight(62) + homeHeight;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - STHeight(38) - otherHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView useDefaultProperty];
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
    _tableView.mj_footer = footer;
    
    [self addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(158);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShelvesListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShelvesListViewCell identify]];
    if(!cell){
        cell = [[ShelvesListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ShelvesListViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.shelvesBtn.tag = indexPath.row;
    [cell.shelvesBtn addTarget:self action:@selector(onShelvesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap =[[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onItemClick:)];
    tap.numberOfTouchesRequired = 1;
    [cell.shelvesView addGestureRecognizer:tap];
    tap.view.tag = indexPath.row;
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] type: _mViewModel.shelvesType];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)updateView{
    _noDataView.hidden = YES;
    _tableView.hidden = NO;
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}


-(void)refreshNew{
    [_mViewModel requestShelvesList:YES];
    
}

-(void)uploadMore{
    [_mViewModel requestShelvesList:NO];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_GOODS_LIST]){
        [self updateView];
    }else if([respondModel.requestUrl isEqualToString:URL_GOODS_ONSHELF]){
        [_mViewModel requestShelvesList:YES];
    }else if([respondModel.requestUrl isEqualToString:URL_GOODS_OFFSHELF]){
        [_mViewModel requestShelvesList:YES];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onRequestNoDatas:(Boolean)isFirst{
    if(isFirst){
        NSLog(@"无数据页面");
        _noDataView.hidden = NO;
        _tableView.hidden = YES;
    }else{
        _noDataView.hidden = YES;
        _tableView.hidden = NO;
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

-(void)onShelvesBtnClick:(id)sender{
    UIButton *button = sender;
    NSInteger tag = button.tag;
    ShelvesModel *model = [_mViewModel.datas objectAtIndex:tag];
    if( _mViewModel.shelvesType == ShelvesType_Grouding){
        _skuId = model.skuId;
        _dialog.hidden = NO;
    }else{
        [_mViewModel onShelf:model.skuId];
    }
}

-(void)onConfirmBtnClicked:(id)dialog{
    [_mViewModel offShelf:_skuId];
    _dialog.hidden = YES;
}

-(void)onCancelBtnClicked:(id)dialog{
    _dialog.hidden = YES;
}

-(void)onItemClick:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *recognizer = sender;
    UIView *view = (UIView *)recognizer.view;
    //    [LCProgressHUD showMessage:[NSString stringWithFormat:@"点击跳转：%ld",view.tag]];
    //    ShelvesModel *model = [_mViewModel.datas objectAtIndex:view.tag];
}
@end
