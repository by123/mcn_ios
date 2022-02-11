//
//  AddressView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddressView.h"
#import "AddressViewCell.h"
#import "STDialog.h"
#import "STObserverManager.h"

@interface AddressView()<UITableViewDelegate,UITableViewDataSource,STDialogDelegate>

@property(strong, nonatomic)AddressViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)STDialog *dialog;

@end

@implementation AddressView{
    NSInteger deleteIndex;
}

-(instancetype)initWithViewModel:(AddressViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initTableView];
    [self addSubview:[self dialog]];
}


-(STDialog *)dialog{
    if(_dialog == nil){
        _dialog = [[STDialog alloc]initWithTitle:@"删除地址" content:@"确定删除收货地址吗？" subContent:MSG_EMPTY size:CGSizeMake(STWidth(300), STHeight(160))];
        _dialog.hidden = YES;
        [_dialog showConfirmBtn:YES cancelBtn:YES];
        _dialog.delegate = self;
    }
    return _dialog;
}

-(void)onConfirmBtnClicked:(id)dialog{
    _dialog.hidden = YES;
    AddressInfoModel *model = [_mViewModel.datas objectAtIndex:deleteIndex];
    [_mViewModel deleteAddress:model.addressId];
}

-(void)onCancelBtnClicked:(id)dialog{
    _dialog.hidden = YES;
}



/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = cbg2;
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
    return STHeight(181);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddressViewCell identify]];
    if(!cell){
        cell = [[AddressViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[AddressViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:cbg2];
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(onDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;
    [cell.editBtn addTarget:self action:@selector(onEditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] type:_mViewModel.type];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel.type == AddressType_Select){
        AddressInfoModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_SELECT_ADDRESS msg:model];
        [_mViewModel goBackLastPage];
    }
    
}


-(void)refreshNew{
    [_mViewModel requestAddress:YES];
    
}

-(void)uploadMore{
    [_mViewModel requestAddress:NO];
}

-(void)onRequestNoDatas:(Boolean)isFirst{
    self.hidden = isFirst;
    if(isFirst){
        NSLog(@"无数据页面");
    }else{
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

-(void)updateView{
    self.hidden = NO;;
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

-(void)onDeleteBtnClick:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    deleteIndex = tag;
    _dialog.hidden = NO;
}

-(void)onEditBtnClick:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    [_mViewModel goAddAddressPage:[_mViewModel.datas objectAtIndex:tag]];
}


/********************** tableview ****************************/


@end

