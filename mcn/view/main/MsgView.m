//
//  MsgView.m
//  mcn
//
//  Created by by.huang on 2020/8/18.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "MsgView.h"
#import "MsgViewModel.h"
#import "MsgViewCell.h"
#import "STDialog.h"

@interface MsgView()<UITableViewDelegate,UITableViewDataSource,MsgViewDelegate,STDialogDelegate>
@property(strong, nonatomic)MainViewModel *mainVM;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)MsgViewModel *msgVM;
@property(strong, nonatomic)STDialog *dialog;
@property(strong, nonatomic)MsgModel *delModel;
@property(strong, nonatomic)UIView *noDataView;


@end

@implementation MsgView

-(instancetype)initWithViewModel:(MainViewModel *)mainVM{
    if(self == [super init]){
        _mainVM = mainVM;
        _msgVM = [[MsgViewModel alloc]init];
        _msgVM.delegate = self;
        [self initView];
        [self initNoDataView];
        [_msgVM reqeustMsgList:YES];
    }
    return self;
}

-(void)initView{
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(25)] text:@"消息中心" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(25) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(59), titleSize.width, STHeight(36));
    [self addSubview:titleLabel];
    
    [self initTableView];
    
    _dialog = [[STDialog alloc]initWithTitle:@"删除消息" content:@"确认删除该条消息吗？" subContent:nil size:CGSizeMake(STWidth(315), STHeight(200))];
    _dialog.delegate = self;
    [_dialog showConfirmBtn:YES cancelBtn:YES];
    [_dialog setConfirmBtnStr:@"确认" cancelStr:@"取消"];
    _dialog.hidden = YES;
    [STWindowUtil addWindowView:_dialog];
}

-(void)initNoDataView{
    _noDataView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(180), STWidth(345), STHeight(332))];
    _noDataView.backgroundColor = cwhite;
    _noDataView.hidden = YES;
    [self addSubview:_noDataView];
    
    UIImageView *noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake((STWidth(345) - STHeight(160))/2, STHeight(64), STHeight(160), STHeight(160))];
    noDataImageView.image = [UIImage imageNamed:IMAGE_NO_DATA];
    noDataImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_noDataView addSubview:noDataImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:@"暂无消息" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    nameLabel.frame = CGRectMake(0, STHeight(234), STWidth(345), STHeight(21));
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(110), ScreenWidth, ScreenHeight - STHeight(110) - STHeight(62) - homeHeight)];
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
    return [_msgVM.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(165);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MsgViewCell identify]];
    if(!cell){
        cell = [[MsgViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MsgViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delBtn.tag = indexPath.row;
    [cell.delBtn addTarget:self action:@selector(onDelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap =[[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onItemClick:)];
    tap.numberOfTouchesRequired = 1;
    [cell.msgView addGestureRecognizer:tap];
    tap.view.tag = indexPath.row;
    if(!IS_NS_COLLECTION_EMPTY(_msgVM.datas)){
        [cell updateData:[_msgVM.datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgModel *model = [_msgVM.datas objectAtIndex:indexPath.row];
    model.readState = 1;
    [_tableView reloadData];
    [_msgVM readMsg:model.msgId];
    [_mainVM goMsgDetailPage:model.msgId];
    
}

-(void)onItemClick:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *recognizer = sender;
    UIView *view = (UIView *)recognizer.view;
    MsgModel *model = [_msgVM.datas objectAtIndex:view.tag];
    model.readState = 1;
    [_tableView reloadData];
    [_msgVM readMsg:model.msgId];
    [_mainVM goMsgDetailPage:model.msgId];
}


-(void)updateView{
    _noDataView.hidden = YES;
    _tableView.hidden = NO;
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}


-(void)refreshNew{
    [_msgVM reqeustMsgList:YES];
    
}

-(void)uploadMore{
    [_msgVM reqeustMsgList:NO];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_MESSAGE_LIST]){
        [self updateView];
    }else if([respondModel.requestUrl containsString:URL_MESSAGE_DEL]){
        [_msgVM reqeustMsgList:YES];
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
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

-(void)onDelBtnClick:(id)sender{
    UIButton *button = sender;
    NSInteger tag = button.tag;
    _delModel = [_msgVM.datas objectAtIndex:tag];
    _dialog.hidden = NO;
}

-(void)onConfirmBtnClicked:(id)dialog{
    [_msgVM delMsg:_delModel.msgId];
    _dialog.hidden = YES;
}

-(void)onCancelBtnClicked:(id)dialog{
    _dialog.hidden = YES;
}





@end
