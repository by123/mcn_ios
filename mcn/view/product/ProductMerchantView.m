//
//  ProductMerchantScrollView.m
//  mcn
//
//  Created by by.huang on 2020/9/2.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "ProductMerchantView.h"

@interface ProductMerchantView()

@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *contentLabel;

@end

@implementation ProductMerchantView

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = cwhite;
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [self addSubview:_nameLabel];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STHeight(62) - STWidth(15), STHeight(19), STHeight(62), STHeight(62))];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(31);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_headImageView];
    
    [self addSubview:LINEVIEW(STHeight(100), STWidth(345))];
    
    _contentLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:YES];
    [self addSubview:_contentLabel];
}

-(void)updateView:(ProductModel *)model{
    _nameLabel.text = model.mchModel.mchName;
    _nameLabel.frame = CGRectMake(STWidth(15), 0, STWidth(268), STHeight(100));
    
    if(!IS_NS_STRING_EMPTY(model.mchModel.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.mchModel.picFullUrl]];
    }
    
    _contentLabel.text = model.mchModel.authModel.remark;
    CGSize contentSize = [_contentLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _contentLabel.frame = CGRectMake(STWidth(15), STHeight(115), STWidth(345), contentSize.height);
    
    if(_delegate){
        [_delegate onProductMerchantViewLoaded:STHeight(115) + contentSize.height + STHeight(20)];
    }
}

@end
