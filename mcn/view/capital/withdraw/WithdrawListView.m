//
//  WithdrawListView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "WithdrawListView.h"
#import "WithdrawListViewCell.h"

@interface WithdrawListView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)WithdrawListViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation WithdrawListView

-(instancetype)initWithViewModel:(WithdrawListViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initTableView];
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
    return STHeight(310);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WithdrawListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WithdrawListViewCell identify]];
    if(!cell){
        cell = [[WithdrawListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WithdrawListViewCell identify]];
    }
    cell.backgroundColor = cbg2;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)updateView{
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}


-(void)refreshNew{
    [_mViewModel reqeustList:YES];
    
}

-(void)uploadMore{
    [_mViewModel reqeustList:NO];
}

-(void)onRequestNoDatas:(Boolean)isFirst{
    if(isFirst){
        NSLog(@"无数据页面");
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    }else{
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}


/********************** tableview ****************************/

@end

