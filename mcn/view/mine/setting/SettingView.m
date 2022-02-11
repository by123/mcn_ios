//
//  SettingView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "SettingView.h"
#import "SettingViewCell.h"

@interface SettingView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)SettingViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation SettingView

-(instancetype)initWithViewModel:(SettingViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initTableView];
    
    UIButton *changeAccountBtn = [[UIButton alloc]initWithFont:STFont(15) text:MSG_SETTING_CHANGEACCOUNT textColor:c10 backgroundColor:cwhite corner:0 borderWidth:0 borderColor:nil];
    changeAccountBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)];
    changeAccountBtn.frame = CGRectMake(0, STHeight(15) + _mViewModel.datas.count * STHeight(50), ScreenWidth, STHeight(50));
    [changeAccountBtn addTarget:self action:@selector(onChangeAccountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:changeAccountBtn];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFont:STFont(15) text:MSG_SETTING_LOUGOUT textColor:c10 backgroundColor:cwhite corner:0 borderWidth:0 borderColor:nil];
    logoutBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)];
    logoutBtn.frame = CGRectMake(0, STHeight(80) + _mViewModel.datas.count * STHeight(50), ScreenWidth, STHeight(50));
    [logoutBtn addTarget:self action:@selector(onLogoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:logoutBtn];
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _mViewModel.datas.count *STHeight(50))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView useDefaultProperty];
    
    [self addSubview:_tableView];
}


-(void)onLogoutBtnClick{
    if(_mViewModel){
        [_mViewModel logout];
    }
}

-(void)onChangeAccountBtnClick{
    if(_mViewModel){
        [_mViewModel goChangeAccountPage];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SettingViewCell identify]];
    if(!cell){
        cell = [[SettingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SettingViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        if(_mViewModel.datas.count - 1 == indexPath.row){
            [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] lineHidden:YES];
        }else{
            [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] lineHidden:NO];
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel){
        [_mViewModel goNextPage:indexPath.row];
    }
}


-(void)updateView{
    [_tableView reloadData];
}


/********************** tableview ****************************/


@end

