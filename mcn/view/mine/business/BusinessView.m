//
//  BusinessView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "BusinessView.h"

@interface BusinessView()

@property(strong, nonatomic)BusinessViewModel *mViewModel;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UIImageView *genderImageView;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *mobileLabel;
@property(strong, nonatomic)UILabel *douyinLabel;
@property(strong, nonatomic)UILabel *kuaishouLabel;

@end

@implementation BusinessView

-(instancetype)initWithViewModel:(BusinessViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), STWidth(197))];
    bgImageView.image = [UIImage imageNamed:IMAGE_BUSINESS_BG];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImageView];
    
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:cwhite backgroundColor:nil multiLine:NO];
    [bgImageView addSubview:_nameLabel];
    
    _genderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, STHeight(14), STHeight(14))];
    _genderImageView.contentMode = UIViewContentModeScaleAspectFill;
    [bgImageView addSubview:_genderImageView];
    
    _mobileLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [bgImageView addSubview:_mobileLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(20), STHeight(107), STWidth(283), LineHeight)];
    lineView.backgroundColor = c16;
    [bgImageView addSubview:lineView];
    
    _douyinLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [bgImageView addSubview:_douyinLabel];
    
    _kuaishouLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [bgImageView addSubview:_kuaishouLabel];
    
    
    UIView *headBgView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(233), STHeight(20), STHeight(70), STHeight(70))];
    headBgView.backgroundColor = cwhite;
    headBgView.layer.masksToBounds = YES;
    headBgView.layer.cornerRadius = STHeight(35);
    [bgImageView addSubview:headBgView];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(233) + STHeight(2), STHeight(22), STHeight(66), STHeight(66))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(33);
    [bgImageView addSubview:_headImageView];
}

-(void)updateView{
    
    BusinessModel *model = _mViewModel.model;
    
    _nameLabel.text = model.mchName;
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    if(nameSize.width > STWidth(150)){
        nameSize.width = STWidth(150);
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    _nameLabel.frame = CGRectMake(STWidth(20), STHeight(32), nameSize.width, STHeight(25));
    
    _genderImageView.frame = CGRectMake(STWidth(25) + nameSize.width, STHeight(38), STHeight(14), STHeight(14));
    _genderImageView.image = [UIImage imageNamed:model.sex == 0 ? IMAGE_MINE_MALE : IMAGE_MINE_FEMALE];
    
    _mobileLabel.text = model.contactPhone;
    CGSize mobileSize = [_mobileLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _mobileLabel.frame = CGRectMake(STWidth(20), STHeight(59), mobileSize.width, STHeight(21));
    
    _douyinLabel.text = IS_NS_STRING_EMPTY(model.douyinAccount) ? @"• 抖音号：无" : [NSString stringWithFormat:@"• 抖音号：%@",model.douyinAccount];
    CGSize douyinSize = [_douyinLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _douyinLabel.frame = CGRectMake(STWidth(20), STHeight(122), douyinSize.width, STHeight(21));
    
    _kuaishouLabel.text = IS_NS_STRING_EMPTY(model.kuaishouAccount) ? @"• 快手号：无" : [NSString stringWithFormat:@"• 快手号：%@",model.kuaishouAccount];
    CGSize kuaishouSize = [_kuaishouLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _kuaishouLabel.frame = CGRectMake(STWidth(20), STHeight(153), kuaishouSize.width, STHeight(21));
    
    if(!IS_NS_STRING_EMPTY(model.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picFullUrl]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
}

@end

