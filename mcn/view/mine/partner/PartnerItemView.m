//
//  PartnerItemView.m
//  mcn
//
//  Created by by.huang on 2020/9/6.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "PartnerItemView.h"
#import "PartnerItemViewModel.h"
#import "PartnerItemViewCell.h"

@interface PartnerItemView()<PartnerItemViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)PartnerItemViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)PartnerViewModel *vm;
@property(strong, nonatomic)UIView *noDataView;


@end

@implementation PartnerItemView

-(instancetype)initWithType:(PartnerType)parterType vm:(PartnerViewModel *)vm{
    if(self == [super init]){
        _vm = vm;
        _mViewModel = [[PartnerItemViewModel alloc]init];
        _mViewModel.partnerType = parterType;
        _mViewModel.delegate = self;
        [self initView];
        [_mViewModel requestList:YES];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(38));
    self.backgroundColor = cbg2;
    [self initTableView];
    [self initNoDataView];
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(38))];
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

-(void)initNoDataView{
    _noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(38))];
    _noDataView.hidden = YES;
    _noDataView.backgroundColor = cwhite;
    [self addSubview:_noDataView];
    
    UIImageView *noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STHeight(160))/2, STHeight(140), STHeight(160), STHeight(160))];
    noDataImageView.image = [UIImage imageNamed:IMAGE_NO_DATA];
    noDataImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_noDataView addSubview:noDataImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:@"暂无合作" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    nameLabel.frame = CGRectMake(0, STHeight(330), ScreenWidth, STHeight(21));
    [_noDataView addSubview:nameLabel];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PartnerModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    return STHeight(100) + STHeight(125) * model.skuModels.count + STHeight(15);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PartnerItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PartnerItemViewCell identify]];
    if(!cell){
        cell = [[PartnerItemViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PartnerItemViewCell identify]];
    }
    cell.merchantBtn.tag = indexPath.row;
    [cell.merchantBtn addTarget:self action:@selector(onMerchantBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundColor = cbg2;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] vm:_vm];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel){
        PartnerModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
        [_vm goPartnerDetailPage:model.cooperationId];
    }
}


-(void)updateView{
    _noDataView.hidden = YES;
       _tableView.hidden = NO;
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}


-(void)refreshNew{
    [_mViewModel requestList:YES];
    
}

-(void)uploadMore{
    [_mViewModel requestList:NO];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_PROJECT_LIST]){
        [self updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onRequestNoDatas:(Boolean)isFirst{
    if(isFirst){
        NSLog(@"无数据页面");
        _noDataView.hidden = NO;
        _tableView.hidden = YES;
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    }else{
        _noDataView.hidden = YES;
        _tableView.hidden = NO;
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [_tableView reloadData];
}

/********************** tableview ****************************/


-(void)onMerchantBtnClick:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    PartnerModel *model = _mViewModel.datas[tag];
    [_vm goPartnerMerchantPage:model.supplierId];
}




@end
