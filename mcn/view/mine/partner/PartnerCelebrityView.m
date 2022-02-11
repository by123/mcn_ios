//
//  PartnerCelebrityView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PartnerCelebrityView.h"

@interface PartnerCelebrityView()

@property(strong, nonatomic)PartnerCelebrityViewModel *mViewModel;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *descriptLabel;

@end

@implementation PartnerCelebrityView

-(instancetype)initWithViewModel:(PartnerCelebrityViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_nameLabel];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STHeight(62) - STWidth(15), STHeight(15), STHeight(62), STHeight(62))];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(31);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_headImageView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(97) - LineHeight, STWidth(345), LineHeight)];
    lineView.backgroundColor = cline;
    [self addSubview:lineView];
    
    _descriptLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    [self addSubview:_descriptLabel];
    
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
}

@end
