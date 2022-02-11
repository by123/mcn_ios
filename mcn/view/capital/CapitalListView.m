
//
//  CapitalListView.m
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "CapitalListView.h"
#import "CapitalListViewCell.h"
#import "CapitalListViewModel.h"

@interface CapitalListView()<UITableViewDelegate,UITableViewDataSource,CapitalListViewDelegate>

@property(strong, nonatomic)UITableView *tableView;
@property(assign, nonatomic)CGFloat height;
@property(strong, nonatomic)CapitalListViewModel *mViewModel;
@property(strong, nonatomic)CaptialView *rootView;
@property(assign, nonatomic)int type;
@property(strong, nonatomic)UILabel *incomeTitleLabel;
@property(strong, nonatomic)UILabel *incomeLabel;
@property(strong, nonatomic)UILabel *sellTitleLabel;
@property(strong, nonatomic)UILabel *sellLabel;
@property(strong, nonatomic)MainViewModel *mainView;


@end

@implementation CapitalListView

-(instancetype)initWithType:(int)type height:(CGFloat)height view:(CaptialView *)rootView mainVm:(MainViewModel *)mainVm{
    if(self == [super init]){
        _mainView = mainVm;
        _rootView = rootView;
        _type = type;
        _height = height;
        [self initView];
    }
    return self;
}

-(void)initView{
    _mViewModel = [[CapitalListViewModel alloc]init];
    _mViewModel.type = _type;
    _mViewModel.delegate = self;
    
    
    _incomeTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:@"总收入" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_incomeTitleLabel];
    
    _incomeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c45 backgroundColor:nil multiLine:NO];
    [self addSubview:_incomeLabel];
    
    _sellTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:@"总支出" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_sellTitleLabel];
    
    _sellLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self addSubview:_sellLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(60) - LineHeight, STWidth(345), LineHeight)];
    lineView.backgroundColor = cline;
    [self addSubview:lineView];
    
    [self initTableView];
}


-(void)updateTotal:(CapitalModel *)model{
    CGSize incomeTitleSize = [_incomeTitleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _incomeTitleLabel.frame = CGRectMake(STWidth(15), 0, incomeTitleSize.width, STHeight(60));
    
    _incomeLabel.text = [NSString stringWithFormat:@"+%.2f",model.totalIncome2 / 100];
    CGSize incomeSize = [_incomeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _incomeLabel.frame = CGRectMake(STWidth(20) + incomeTitleSize.width, 0, incomeSize.width, STHeight(60));
    
    CGSize sellTitleSize = [_sellTitleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _sellTitleLabel.frame = CGRectMake(STWidth(50) + incomeTitleSize.width + incomeSize.width, 0, sellTitleSize.width, STHeight(60));
    
    _sellLabel.text = [NSString stringWithFormat:@"-%.2f",model.totalPay / 100];
    CGSize sellSize = [_sellLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _sellLabel.frame = CGRectMake(STWidth(55) + + incomeTitleSize.width + incomeSize.width +sellTitleSize.width , 0, sellSize.width, STHeight(60));
    
}

/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [_tableView useDefaultProperty];
    
    [self addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CapitalListModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    if(model.profitType == ProfitType_Withdraw){
        return STHeight(115);
    }
    return STHeight(135);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CapitalListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CapitalListViewCell identify]];
    if(!cell){
        cell = [[CapitalListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CapitalListViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] hiddenLine:_mViewModel.datas.count - 1 == indexPath.row];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CapitalListModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    if(model.profitType == ProfitType_Withdraw){
        [_mainView goWithdrawListPage];
    }else{
        [_mainView goCapitalDetailPage:model.listId];
    }
}



/********************** tableview ****************************/

-(void)refreshNew{
    [_mViewModel requestList:YES];
    
}

-(void)uploadMore{
    [_mViewModel requestList:NO];
}

-(void)onRequestBegin{
    [_rootView onRequestBegin];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_CAPITAL_LIST]){
        [_rootView onRequestSuccess:respondModel data:data];
        [self updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [_rootView onRequestFail:msg];
}

-(void)onRequestNoDatas:(Boolean)isFirst{
    [_rootView onRequestNoDatas:isFirst];
    [self updateView];
}

-(void)updateView{
    _tableView.frame = CGRectMake(0, STHeight(60), ScreenWidth, [self getListViewHeight]);
    [_tableView reloadData];
}


-(CGFloat)getListViewHeight{
    CGFloat height = STHeight(60);
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        for(CapitalListModel *model in _mViewModel.datas){
            if(model.profitType == ProfitType_Withdraw){
                height += STHeight(115);
            }
            height += STHeight(135);
        }
    }
    return height;
}
@end
