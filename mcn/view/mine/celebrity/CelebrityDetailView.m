//
//  CelebrityDetailView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "CelebrityDetailView.h"

@interface CelebrityDetailView()

@property(strong, nonatomic)CelebrityDetailViewModel *mViewModel;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *mobileLabel;
@property(strong, nonatomic)UILabel *profitLabel;
@property(strong, nonatomic)UIImageView *genderImageView;
@property(strong, nonatomic)UIButton *removeBtn;
@property(strong, nonatomic)UIButton *agreeBtn;
@property(strong, nonatomic)UIButton *rejectBtn;
@property(strong, nonatomic)UIView *lineView;
@property(strong, nonatomic)UILabel *profitTitleLabel;


@end

@implementation CelebrityDetailView

-(instancetype)initWithViewModel:(CelebrityDetailViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *cardView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(122))];
    cardView.backgroundColor = cwhite;
    cardView.layer.cornerRadius = 4;
    cardView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    cardView.layer.shadowOffset = CGSizeMake(0,2);
    cardView.layer.shadowOpacity = 1;
    cardView.layer.shadowRadius = 10;
    [self addSubview:cardView];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(30), STHeight(62), STHeight(62))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(31);
    _headImageView.layer.borderColor = c03.CGColor;
    _headImageView.layer.borderWidth = 0.5;
    [cardView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [cardView addSubview:_nameLabel];
    
    _mobileLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [cardView addSubview:_mobileLabel];
    
    _genderImageView = [[UIImageView alloc]init];
    _genderImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cardView addSubview:_genderImageView];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(216), STHeight(55), LineHeight, STHeight(15))];
    _lineView.backgroundColor = cline;
    _lineView.hidden = YES;
    [cardView addSubview:_lineView];
    
    _profitLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(20)] text:@"0%" textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    _profitLabel.hidden = YES;
    [cardView addSubview:_profitLabel];
    
    _profitTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:@"分成比例" textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    CGSize profitTitleSize = [_profitTitleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    _profitTitleLabel.frame = CGRectMake(STWidth(247) ,STHeight(64), profitTitleSize.width, STHeight(20));
    _profitTitleLabel.hidden = YES;
    [cardView addSubview:_profitTitleLabel];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80))];
    bottomView.backgroundColor = cwhite;
    bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0,2);
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowRadius = 10;
    [self addSubview:bottomView];
    
//    if(_mViewModel.type == 1){
        _removeBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"移除" textColor:c20 backgroundColor:nil corner:4 borderWidth:LineHeight borderColor:c20];
        _removeBtn.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(50));
        [_removeBtn addTarget:self action:@selector(onRemoveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:_removeBtn];
//    }else{
//        _rejectBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"拒绝" textColor:c20 backgroundColor:nil corner:4 borderWidth:LineHeight borderColor:c20];
//        _rejectBtn.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(165), STHeight(50));
//        [_rejectBtn addTarget:self action:@selector(onRejectBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [bottomView addSubview:_rejectBtn];
//
//        _agreeBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"同意" textColor:cwhite backgroundColor:c20 corner:4 borderWidth:0 borderColor:nil];
//        _agreeBtn.frame = CGRectMake(STWidth(195), STHeight(15), STWidth(165), STHeight(50));
//        [_agreeBtn addTarget:self action:@selector(onAgreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [bottomView addSubview:_agreeBtn];
//
//    }
    
}

-(void)updateView{
    CelebrityModel *model = _mViewModel.model;
    
    _nameLabel.text = model.mchName;
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    if(nameSize.width > STWidth(100)){
        nameSize.width = STWidth(100);
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    _nameLabel.frame = CGRectMake(STWidth(92), STHeight(38), nameSize.width, STHeight(21));
    
    _mobileLabel.text = model.contactPhone;
    CGSize mobileSize = [_mobileLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    _mobileLabel.frame = CGRectMake(STWidth(92), STHeight(64), mobileSize.width, STHeight(20));
    
    CelebrityAuthModel *authModel = [CelebrityAuthModel mj_objectWithKeyValues:model.authenticateDataRespVo];
    _profitLabel.text = [NSString stringWithFormat:@"%d%%",authModel.allocateRatio];
    CGSize profitSize = [_profitLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(20) fontName:FONT_SEMIBOLD];
    _profitLabel.frame = CGRectMake(STWidth(247), STHeight(38), profitSize.width, STHeight(24));
    
    
    _genderImageView.frame = CGRectMake(STWidth(97) + nameSize.width , STHeight(42), STHeight(14), STHeight(14));
    if(model.sex == 0){
        _genderImageView.image = [UIImage imageNamed:IMAGE_GENDER_MALE];
    }else if(model.sex == 1){
        _genderImageView.image = [UIImage imageNamed:IMAGE_GENDER_FEMALE];
    }
    
    if(!IS_NS_STRING_EMPTY(model.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picFullUrl]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    
    if(_mViewModel.type == 0){
        _lineView.hidden = NO;
        _profitLabel.hidden = NO;
        _profitTitleLabel.hidden = NO;
    }
}

-(void)onRemoveBtnClick{
    if(_mViewModel.type == 0){
        [_mViewModel removeCelebrity];
    }else{
        [_mViewModel removeCelebrityInvite];
    }
}

-(void)onRejectBtnClick{
    
}

-(void)onAgreeBtnClick{
    
}

@end

