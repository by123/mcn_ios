//
//  HomeListViewCell.m
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "HomeListViewCell.h"
#import "STPriceLabel.h"
#import "AccountManager.h"

@interface HomeListViewCell()

@property(strong, nonatomic)UIImageView *productImageView;
@property(strong, nonatomic)STPriceLabel *priceLabel;
@property(strong, nonatomic)UILabel *productNameLabel;
@property(strong, nonatomic)UILabel *firstLabel;
@property(strong, nonatomic)UILabel *reLabel;
@property(strong, nonatomic)UIImageView *mcnImageView;
@property(strong, nonatomic)UILabel *mcnLabel;

@end

@implementation HomeListViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = cwhite;
    self.layer.cornerRadius = 4;
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,2);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 10;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 4;
    
    _productImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, STWidth(168), STHeight(168))];
    _productImageView.contentMode = UIViewContentModeScaleAspectFill;
    CAShapeLayer *imageLayer = [[CAShapeLayer alloc] init];
    imageLayer.frame = _productImageView.bounds;
    imageLayer.path = [UIBezierPath bezierPathWithRoundedRect:_productImageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)].CGPath;
    _productImageView.layer.mask = imageLayer;
    [self addSubview:_productImageView];
    
    _priceLabel = [[STPriceLabel alloc]initWithLabel:0 color:c16 unitSize:STFont(16) numberSize:STFont(20) unitFontFamily:FONT_SEMIBOLD numberFontFamily:FONT_SEMIBOLD];
    _priceLabel.frame = CGRectMake(STWidth(10), STHeight(178), _priceLabel.size.width, _priceLabel.size.height);
    [self addSubview:_priceLabel];
    
    _productNameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [self addSubview:_productNameLabel];
    
    UILabel *firstTagLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(7)] text:@"首" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c16 multiLine:NO];
    firstTagLabel.frame = CGRectMake(STWidth(10), STHeight(248), STHeight(12), STHeight(12));
    firstTagLabel.layer.masksToBounds = YES;
    firstTagLabel.layer.cornerRadius = 2;
    [self addSubview:firstTagLabel];
    
    _firstLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self addSubview:_firstLabel];
    
    UILabel *reTagLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(7)] text:@"复" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c10 multiLine:NO];
    reTagLabel.frame = CGRectMake(STWidth(10), STHeight(268), STHeight(12), STHeight(12));
    reTagLabel.layer.cornerRadius = 2;
    reTagLabel.layer.masksToBounds = YES;
    [self addSubview:reTagLabel];
    
    _reLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self addSubview:_reLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(10), STHeight(290), STWidth(148), LineHeight)];
    lineView.backgroundColor = cline;
    [self addSubview:lineView];
    
    _mcnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(10), STHeight(303), STHeight(15), STHeight(15))];
    _mcnImageView.layer.masksToBounds = YES;
    _mcnImageView.layer.cornerRadius = STHeight(15) / 2;
    _mcnImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_mcnImageView];
    
    _mcnLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_mcnLabel];
    
    _cooperationBtn = [[UIButton alloc]initWithFont:STFont(11) text:@"合作" textColor:cwhite backgroundColor:c16 corner:4 borderWidth:0 borderColor:nil];
    _cooperationBtn.frame = CGRectMake(STWidth(113), STHeight(300), STWidth(45), STHeight(22));
    [self addSubview:_cooperationBtn];
    
}

-(void)updateData:(ProductModel *)model{
    if(!IS_NS_STRING_EMPTY(model.skuPicOssUrl)){
        [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.skuPicOssUrl]];
    }
    [_priceLabel updateLabel:model.sellPrice];
    
    _productNameLabel.text = [NSString stringWithFormat:@"%@%@",model.spuName,[ProductModel getAttributeValue:model.attribute]];
    
    CGSize productNameSize = [_productNameLabel.text sizeWithMaxWidth:STWidth(142) font:STFont(12) fontName:FONT_SEMIBOLD];
    if(productNameSize.height > [self singLineHeight] * 2){
        _productNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _productNameLabel.numberOfLines = 2;
        _productNameLabel.frame = CGRectMake(STWidth(10), STHeight(202), STWidth(142), [self singLineHeight] * 2);
    }else{
        _productNameLabel.frame = CGRectMake(STWidth(10), STHeight(202), STWidth(142), productNameSize.height);
    }

    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.authenticateState != AuthenticateState_Success){
        _firstLabel.text = @"首单分成：*****";
        _reLabel.text = @"复购分成：*****";
    }else{
        _firstLabel.text = [NSString stringWithFormat:@"首单分成：¥%.2f",model.firstOrderProfit / 100];
        _reLabel.text = [NSString stringWithFormat:@"复购分成：¥%.2f",model.repeatProfit / 100];
    }
    CGSize firstSize = [_firstLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _firstLabel.frame = CGRectMake(STWidth(30), STHeight(248), firstSize.width, STHeight(16));
    
    CGSize reSize = [_reLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _reLabel.frame = CGRectMake(STWidth(30), STHeight(268), reSize.width, STHeight(16));
    
    _mcnLabel.text = model.mchName;
    _mcnLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _mcnLabel.frame = CGRectMake(STWidth(30), STHeight(303), STWidth(75), STHeight(16));
    
    if(!IS_NS_STRING_EMPTY(model.picUrl)){
        [_mcnImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    }else{
        _mcnImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
}

//投机取巧
-(CGFloat)singLineHeight{
    CGSize contentSize = [@"小红菇" sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_SEMIBOLD];
    return contentSize.height;
}

+(NSString *)identify{
    return NSStringFromClass([HomeListViewCell class]);
}
@end
