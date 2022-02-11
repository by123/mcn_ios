//
//  CelebrityListView.m
//  mcn
//
//  Created by by.huang on 2020/8/31.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "CelebrityListView.h"
#import "CelebrityListViewCell.h"
#import "CelebrityListViewCell2.h"
#import "CelebrityListViewModel.h"

@interface CelebrityListView()<UITableViewDelegate,UITableViewDataSource,CelebrityListViewDelegate>

@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)CelebrityListViewModel *celebrityListVM;
@property(strong, nonatomic)CelebrityViewModel *celebrityVM;
@property(strong,nonatomic)UIView *noDataView;

@end

@implementation CelebrityListView

-(instancetype)initWithType:(int)type vm:(CelebrityViewModel *)celebrityVM{
    if(self == [super init]){
        _celebrityListVM = [[CelebrityListViewModel alloc]init];
        _celebrityListVM.celebrityVM = celebrityVM;
        _celebrityListVM.inviteType = type;
        _celebrityListVM.delegate = self;
        [self initView];
        if(_celebrityListVM.inviteType == 0){
            [_celebrityListVM requestList:YES];
        }else{
            [_celebrityListVM reqeustInviteList:YES];
        }
    }
    return self;
}

-(void)initView{
    self.backgroundColor = c16;
    [self initTableView];
    [self initNoDataView];
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
    
    UILabel *nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:_celebrityListVM.inviteType == 0 ?  @"暂无成员" : @"暂无邀请的主播" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    nameLabel.frame = CGRectMake(0, STHeight(330), ScreenWidth, STHeight(21));
    [_noDataView addSubview:nameLabel];
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
    return [_celebrityListVM.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _celebrityListVM.inviteType == 1 ?  STHeight(130) : STHeight(148);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(_celebrityListVM.inviteType == 0){
        CelebrityListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CelebrityListViewCell identify]];
        if(!cell){
            cell = [[CelebrityListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CelebrityListViewCell identify]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //        cell.removeBtn.tag = indexPath.row;
        //        [cell.removeBtn addTarget:self action:@selector(onRemoveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if(!IS_NS_COLLECTION_EMPTY(_celebrityListVM.datas)){
            [cell updateData:[_celebrityListVM.datas objectAtIndex:indexPath.row] type:_celebrityListVM.inviteType];
        }
        return cell;
//    }else{
//        CelebrityListViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:[CelebrityListViewCell2 identify]];
//        if(!cell){
//            cell = [[CelebrityListViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CelebrityListViewCell2 identify]];
//        }
//        cell.agreeBtn.tag = indexPath.row;
//        [cell.agreeBtn addTarget:self action:@selector(onAgreeBtn:) forControlEvents:UIControlEventTouchUpInside];
//        cell.rejectBtn.tag = indexPath.row;
//        [cell.rejectBtn addTarget:self action:@selector(onRejectBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        if(!IS_NS_COLLECTION_EMPTY(_celebrityListVM.datas)){
//            [cell updateData:[_celebrityListVM.datas objectAtIndex:indexPath.row]];
//        }
//        return cell;
//    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CelebrityModel *model = [_celebrityListVM.datas objectAtIndex:indexPath.row];
    [_celebrityListVM.celebrityVM goCelebrityDetailPage:(_celebrityListVM.inviteType == 0) ? model.mchId:model.destMchId type:_celebrityListVM.inviteType operateState:model.operateState celebrityId:model.celebrityId];
}


-(void)updateView{
    _noDataView.hidden = YES;
    _tableView.hidden = NO;
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}


-(void)refreshNew{
    if(_celebrityListVM.inviteType == 0){
        [_celebrityListVM requestList:YES];
    }else{
        [_celebrityListVM reqeustInviteList:YES];
    }
    
}

-(void)uploadMore{
    if(_celebrityListVM.inviteType == 0){
        [_celebrityListVM requestList:NO];
    }else{
        [_celebrityListVM reqeustInviteList:NO];
    }
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_MCHINVITE_CELEBRITY_LIST]){
        [self updateView];
    }else if([respondModel.requestUrl isEqualToString:URL_MCH_CELEBRITY_LIST]){
        [self updateView];
    }
    else if([respondModel.requestUrl isEqualToString:URL_MCHINVITE_REMOVE]){
        [self refreshNew];
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

//-(void)onRemoveBtnClick:(id)sender{
//    NSInteger position = ((UIButton *)sender).tag;
//    CelebrityModel *model = [_celebrityListVM.datas objectAtIndex:position];
//    [_celebrityListVM removeCelebrity:model.celebrityId];
//}

-(void)onAgreeBtn:(id)sender{
    
}

-(void)onRejectBtn:(id)sender{
    
}


@end
