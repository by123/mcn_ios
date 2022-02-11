//
//  BankSelectView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "BankSelectView.h"
#import "AccountManager.h"
#import "BankSelectViewCell.h"

@interface BankSelectView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)BankSelectViewModel *mViewModel;
@property(strong, nonatomic)UserModel *userModel;
@property(strong, nonatomic)UITableView *tableView;
@property(assign, nonatomic)NSInteger current;

@end

@implementation BankSelectView

-(instancetype)initWithViewModel:(BankSelectViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        _userModel = [[AccountManager sharedAccountManager] getUserModel];
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(20)] text:@"请选择需要添加的\n账户类别" textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:STWidth(163) font:STFont(20) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(163), titleSize.height);
    [self addSubview:titleLabel];
    [self initTableView];
    [self initBottomView];
}



/********************** tableview ****************************/
-(void)initTableView{
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(90), ScreenWidth, ContentHeight -STHeight(170)-homeHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    return STHeight(110);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankSelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BankSelectViewCell identify]];
    if(!cell){
        cell = [[BankSelectViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[BankSelectViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _current = indexPath.row;
    for(TitleContentModel *model in _mViewModel.datas){
        model.isSelect = NO;
    }
    TitleContentModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    model.isSelect = YES;
    [_tableView reloadData];
}


-(void)updateView{
    [_tableView reloadData];
}


/********************** tableview ****************************/


-(void)initBottomView{
    
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0,ContentHeight - STHeight(80) - homeHeight,ScreenWidth,STHeight(80)+homeHeight);
    bottomView.backgroundColor = cwhite;
    bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0,2);
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowRadius = 10;
    [self addSubview:bottomView];
    
    UIButton *addBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"添加收款账户" textColor:c20 backgroundColor:nil corner:4 borderWidth:LineHeight borderColor:c20];
    addBtn.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(50));
    [addBtn addTarget:self action:@selector(onAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addBtn];
}

-(void)onAddBtnClick{
    [_mViewModel goAddPage:_current];
}
@end

