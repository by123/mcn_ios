//
//  PartnerMcnView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PartnerMcnView.h"
#import "PartnerMcnViewCell.h"

@interface PartnerMcnView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)PartnerMcnViewModel *mViewModel;
@property(strong, nonatomic)UIView *topView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *descriptLabel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *listView;
@property(strong, nonatomic)UIScrollView *scrollView;


@end

@implementation PartnerMcnView

-(instancetype)initWithViewModel:(PartnerMcnViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = cwhite;
    [_scrollView addSubview:_topView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [_topView addSubview:_nameLabel];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STHeight(62) - STWidth(15), STHeight(15), STHeight(62), STHeight(62))];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(31);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_topView addSubview:_headImageView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(97) - LineHeight, STWidth(345), LineHeight)];
    lineView.backgroundColor = cline;
    [_topView addSubview:lineView];
    
    _descriptLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    [_topView addSubview:_descriptLabel];
 
    [self initListView];
}

-(void)updateView{
    AuthUserModel *model = _mViewModel.model;
    
    _nameLabel.text = model.mchName;
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _nameLabel.frame = CGRectMake(STWidth(15), STHeight(34), nameSize.width, STHeight(25));
    
    if(!IS_NS_STRING_EMPTY(model.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picFullUrl]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    
    _descriptLabel.text= model.baseModel.remark;
    CGSize descriptSize = [_descriptLabel.text sizeWithMaxWidth:STWidth(345) font:STFont(14) fontName:FONT_REGULAR];
    _descriptLabel.frame = CGRectMake(STWidth(15), STHeight(112), STWidth(345), descriptSize.height);
    
    _topView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(132) + descriptSize.height);
    
    _tableView.frame = CGRectMake(0, STHeight(50), ScreenWidth, STHeight(137) * _mViewModel.datas.count);
    _listView.frame = CGRectMake(0, STHeight(147) + descriptSize.height, ScreenWidth, STHeight(50) + STHeight(137) * _mViewModel.datas.count);
    [_tableView reloadData];
    
    [_scrollView setContentSize:CGSizeMake(ScreenWidth, STHeight(147) + descriptSize.height + STHeight(50) + STHeight(137) * _mViewModel.datas.count)];
    
}


/********************** tableview ****************************/
-(void)initListView{

    
    _listView = [[UIView alloc]init];
    _listView.backgroundColor = cwhite;
    [_scrollView addSubview:_listView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:@"旗下主播" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(20), titleSize.width, STHeight(25));
    [_listView addSubview:titleLabel];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [_tableView useDefaultProperty];
    
    [_listView addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(137);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PartnerMcnViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PartnerMcnViewCell identify]];
    if(!cell){
        cell = [[PartnerMcnViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PartnerMcnViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


/********************** tableview ****************************/


@end
