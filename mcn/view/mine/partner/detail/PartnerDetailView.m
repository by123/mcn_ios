//
//  PartnerDetailView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PartnerDetailView.h"
#import "STTimeUtil.h"
#import "AccountManager.h"
#import "PartnerDetailViewCell.h"
#import "STDefaultBtnView.h"
#import "PartnerCelebrityDetailViewCell.h"
#import "PartnerMcnDetailViewCell.h"
#import "CelebrityLayerView.h"

@interface PartnerDetailView()<UITableViewDelegate,UITableViewDataSource,STDefaultBtnViewDelegate,CelebrityLayerViewDelegate>

@property(strong, nonatomic)PartnerDetailViewModel *mViewModel;
@property(strong, nonatomic)UILabel *statuLabel;
@property(strong, nonatomic)UILabel *cooperationIdLabel;
@property(strong, nonatomic)UILabel *timeLabel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *contentView;

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;

@property(strong, nonatomic)STDefaultBtnView *confirmBtn;
@property(strong, nonatomic)CelebrityLayerView *layerView;


@end

@implementation PartnerDetailView

-(instancetype)initWithViewModel:(PartnerDetailViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initCardView];
    [self initHeaderView];
    [self initTableView];
    
    _layerView = [[CelebrityLayerView alloc]init];
    _layerView.delegate = self;
    _layerView.hidden = YES;
    [STWindowUtil addWindowView:_layerView];

}

-(void)initCardView{
    UIView *cardView = [[UIView alloc]init];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.cornerRadius = 10;
    gl.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    gl.shadowOffset = CGSizeMake(0,2);
    gl.shadowOpacity = 1;
    gl.shadowRadius = 10;
    gl.frame = CGRectMake(STWidth(30), STHeight(15), STWidth(315), STHeight(110));
    gl.startPoint = CGPointMake(1, 0.56);
    gl.endPoint = CGPointMake(0, 0.56);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:124/255.0 blue:124/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:254/255.0 green:48/255.0 blue:50/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [cardView.layer addSublayer:gl];
    [self addSubview:cardView];
    
    _statuLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [cardView addSubview:_statuLabel];
    
    _cooperationIdLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [cardView addSubview:_cooperationIdLabel];
    
    _timeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(10)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [cardView addSubview:_timeLabel];
    
    
}


-(void)initBtnView{
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(100), STWidth(345), STHeight(83))];
    btnView.backgroundColor = cwhite;
    btnView.layer.cornerRadius = 4;
    btnView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    btnView.layer.shadowOffset = CGSizeMake(0,2);
    btnView.layer.shadowOpacity = 1;
    btnView.layer.shadowRadius = 10;
    [self addSubview:btnView];
    
    
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    NSArray *titles = @[@"合作进度",@"物流信息",@"商家信息"];
    NSArray *images = @[IMAGE_PARTNER_SCHEDULE,IMAGE_PARTNER_LOGISTICAL,IMAGE_PARTNER_MERCHANT];
    if(model.roleType == RoleType_Merchant){
        if(IS_NS_STRING_EMPTY(_mViewModel.model.mcnId)){
            titles = @[@"合作进度",@"物流信息",@"主播信息"];
            images = @[IMAGE_PARTNER_SCHEDULE,IMAGE_PARTNER_LOGISTICAL,IMAGE_PARTNER_CELEBRITY];
        }else{
            titles = @[@"合作进度",@"物流信息",@"MCN机构"];
            images = @[IMAGE_PARTNER_SCHEDULE,IMAGE_PARTNER_LOGISTICAL,IMAGE_PARTNER_MCN];
        }
    }
    for(int i = 0 ; i < titles.count ; i ++){
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(STWidth(47) + STWidth(100) * i, STHeight(15), STWidth(52), STHeight(53));
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:c10 forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(12)];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGSize imageSize = button.imageView.frame.size;
        CGSize titleSize = button.titleLabel.frame.size;
        CGSize textSize = [button.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
        
        CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
        if (titleSize.width + 0.5 < frameSize.width) {
            titleSize.width = frameSize.width;
        }
        CGFloat totalHeight = (imageSize.height + titleSize.height + STHeight(5));
        button.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
        [btnView addSubview:button];
    }
}


-(void)initHeaderView{
    UIButton *merchantBtn = [[UIButton alloc]init];
    merchantBtn.frame = CGRectMake(0, STHeight(198), ScreenWidth, STHeight(65));
    [merchantBtn addTarget:self action:@selector(goPartnerMerchantPage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:merchantBtn];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(16), STHeight(20), STHeight(25), STHeight(25))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(12.5);
    [merchantBtn addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [merchantBtn addSubview:_nameLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STHeight(20) - STWidth(15), STHeight(22.5), STHeight(20), STHeight(20))];
    arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [merchantBtn addSubview:arrowImageView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(65) - LineHeight, ScreenWidth, LineHeight)];
    lineView.backgroundColor = cline;
    [merchantBtn addSubview:lineView];
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(263), ScreenWidth,ContentHeight - STHeight(263) - STHeight(80))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView useDefaultProperty];
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.size = CGSizeMake(0, 0);
    _tableView.mj_header = header;
    [self addSubview:_tableView];
}

-(void)refreshNew{}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.model.skuModels count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.roleType == RoleType_Celebrity){
        if(_mViewModel.model.projectState == PartnerType_Cooperative){
            return STHeight(177);
        }else{
            return STHeight(142);
        }
    }else{
        return STHeight(200);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.roleType == RoleType_Celebrity){
        PartnerCelebrityDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PartnerCelebrityDetailViewCell identify]];
        if(!cell){
            cell = [[PartnerCelebrityDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PartnerCelebrityDetailViewCell identify]];
        }
        cell.linkCopyBtn.tag = indexPath.row;
        [cell.linkCopyBtn addTarget:self action:@selector(onLinkCopyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(!IS_NS_COLLECTION_EMPTY(_mViewModel.model.skuModels)){
            [cell updateData:[_mViewModel.model.skuModels objectAtIndex:indexPath.row] showLinkView:_mViewModel.model.projectState == PartnerType_Cooperative];
        }
        return cell;
    }else if(userModel.roleType == RoleType_Mcn){
        PartnerMcnDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PartnerMcnDetailViewCell identify]];
        if(!cell){
            cell = [[PartnerMcnDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PartnerMcnDetailViewCell identify]];
        }
        cell.celebrityBtn.tag = indexPath.row;
        [cell.celebrityBtn addTarget:self action:@selector(onCelebrityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(!IS_NS_COLLECTION_EMPTY(_mViewModel.model.skuModels)){
            [cell updateData:[_mViewModel.model.skuModels objectAtIndex:indexPath.row]];
        }
        return cell;
    }
    else{
        PartnerDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PartnerDetailViewCell identify]];
        if(!cell){
            cell = [[PartnerDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PartnerDetailViewCell identify]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(!IS_NS_COLLECTION_EMPTY(_mViewModel.model.skuModels)){
            [cell updateData:[_mViewModel.model.skuModels objectAtIndex:indexPath.row]];
        }
        return cell;
    }
}

-(void)onLinkCopyBtnClick:(id)sender{
    NSInteger tag = ((UIButton *) sender).tag;
    ProductModel *model =  [_mViewModel.model.skuModels objectAtIndex:tag];
    if(IS_NS_STRING_EMPTY(model.goodsLink)){
        [STShowToast show:@"导购链接不存在!"];
    }else{
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = model.goodsLink;
        [STShowToast show:@"导购链接复制成功!"];
    }
}

-(void)onCelebrityBtnClick:(id)sender{
    NSInteger tag = ((UIButton *) sender).tag;
    ProductModel *model =  [_mViewModel.model.skuModels objectAtIndex:tag];
    _layerView.hidden = NO;
    [_layerView updateDatas:model.celebrityModels];
}

-(void)onCelebrityLayerCloseBtnClick{
    _layerView.hidden = YES;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


/********************** tableview ****************************/



-(void)onButtonClick:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    switch (tag) {
        case 0:
            [_mViewModel goSchdulePage];
            break;
        case 1:
            [_mViewModel goLogisticalPage];
            break;
        case 2:
            [self goNextPage];
            break;
        default:
            break;
    }
}

-(void)goPartnerMerchantPage{
    [_mViewModel goPartnerMerchantPage];
}

-(void)goNextPage{
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    if(model.roleType == RoleType_Merchant){
        if(IS_NS_STRING_EMPTY(_mViewModel.model.mcnId)){
            [_mViewModel goPartnerCelebrity];
        }else{
            [_mViewModel goPartnerMcnPage];
        }
        
    }else{
        [_mViewModel goPartnerMerchantPage];
    }
    
}

-(void)updateView{
    PartnerDetailModel *model = _mViewModel.model;
    
    _statuLabel.text = [PartnerModel getStatuStr:model.projectState];
    CGSize statuSize = [_statuLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _statuLabel.frame = CGRectMake(STWidth(49), STHeight(30), statuSize.width, STHeight(25));
    
    _cooperationIdLabel.text = [NSString stringWithFormat:@"合作编号：%@",model.cooperationId];
    CGSize cooperationIdSize = [_cooperationIdLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    _cooperationIdLabel.frame = CGRectMake(STWidth(49), STHeight(60), cooperationIdSize.width, STHeight(20));
    
    _timeLabel.text = [STTimeUtil generateDate:model.createTime format:MSG_DATE_FORMAT_ALL];
    CGSize timeSize = [_timeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(10) fontName:FONT_REGULAR];
    _timeLabel.frame = CGRectMake(ScreenWidth - STWidth(42) - timeSize.width, STHeight(36), timeSize.width, STHeight(14));
    
    
    if(!IS_NS_STRING_EMPTY(model.avatar)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    
    _nameLabel.text = model.supplierName;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _nameLabel.frame = CGRectMake(STWidth(51), STHeight(22), STWidth(270), STHeight(21));
    
    [_tableView reloadData];
    
    //显示功能按钮
    [self initBtnView];
    //显示底部按钮
    [self showBottomBtn];
    
}

-(void)showBottomBtn{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(_mViewModel.model.projectState == PartnerType_WaitSend && userModel.roleType == RoleType_Merchant){
        STDefaultBtnView *confirmBtn = [[STDefaultBtnView alloc]initWithTitle:@"确认发货"];
        confirmBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
        confirmBtn.delegate = self;
        [confirmBtn setActive:YES];
        [self addSubview:confirmBtn];
    }else if(_mViewModel.model.projectState == PartnerType_WaitConfirm && ([userModel.mchId isEqualToString: _mViewModel.model.mchId])){
        [self initBottomView];
    }
}

-(void)initBottomView{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    bottomView.layer.backgroundColor = cwhite.CGColor;
    bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0,2);
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowRadius = 10;
    [self addSubview:bottomView];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"取消合作" textColor:c20 backgroundColor:cwhite corner:4 borderWidth:LineHeight borderColor:c20];
    cancelBtn.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(165), STHeight(50));
    [cancelBtn addTarget:self action:@selector(onCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"确认合作" textColor:cwhite backgroundColor:c20 corner:4 borderWidth:0 borderColor:nil];
    confirmBtn.frame = CGRectMake(STWidth(195), STHeight(15), STWidth(165), STHeight(50));
    [confirmBtn addTarget:self action:@selector(onConfirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:confirmBtn];
}


-(void)onCancelBtnClick{
    [_mViewModel cancelCooperate];
}

-(void)onConfirmBtnClick{
    [_mViewModel confirmCooperate];
    
}

-(void)onDefaultBtnClick{
    [_mViewModel goDeliveryPage];
}

@end

