//
//  PartnerCelebrityDetailViewCell.m
//  mcn
//
//  Created by by.huang on 2020/9/8.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "PartnerCelebrityDetailViewCell.h"

@interface PartnerCelebrityDetailViewCell()

@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UILabel *firstTitleLabel;
@property(strong, nonatomic)UILabel *firstLabel;
@property(strong, nonatomic)UILabel *reTitleLabel;
@property(strong, nonatomic)UILabel *reLabel;
@property(strong, nonatomic)UILabel *linkLabel;
@property(strong, nonatomic)UIView *lineView;

@end

@implementation PartnerCelebrityDetailViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(16), STHeight(20), STHeight(90), STHeight(90))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    _showImageView.layer.masksToBounds = YES;
    _showImageView.layer.cornerRadius = 4;
    [self.contentView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_priceLabel];
    
    
    _firstTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(7)] text:@"首" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c20 multiLine:NO];
    _firstTitleLabel.layer.masksToBounds = YES;
    _firstTitleLabel.layer.cornerRadius = 2;
    [self.contentView addSubview:_firstTitleLabel];
    
    _firstLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_firstLabel];
    
    _reTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(7)] text:@"复" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c10 multiLine:NO];
    _reTitleLabel.layer.masksToBounds = YES;
    _reTitleLabel.layer.cornerRadius = 2;
    [self.contentView addSubview:_reTitleLabel];
    
    _reLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_reLabel];
    
    _linkLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    _linkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _linkLabel.frame = CGRectMake(STWidth(15), STHeight(137), STWidth(278), STHeight(20));
    [self.contentView addSubview:_linkLabel];
    
    _linkCopyBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"复制" textColor:c44 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    _linkCopyBtn.frame = CGRectMake(STWidth(315), STHeight(127), STWidth(60), STHeight(40));
    [self.contentView addSubview:_linkCopyBtn];
    
    _lineView = [[UIView alloc]init];
    _lineView.frame = CGRectMake(STWidth(15), STHeight(177)-LineHeight, STWidth(345), LineHeight);
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
    
}

-(void)updateData:(ProductModel *)model showLinkView:(Boolean)showLinkView{
    
    if(!IS_NS_STRING_EMPTY(model.picUrl)){
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    }
    
    _nameLabel.text = [NSString stringWithFormat:@"%@%@",model.spuName,[ProductModel getAttributeValue:model.attribute]];
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:STWidth(244) font:STFont(14) fontName:FONT_REGULAR];
    _nameLabel.frame = CGRectMake(STWidth(116), STHeight(20), STWidth(244), nameSize.height);
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.sellPrice / 100];
    CGSize priceSize = [_priceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _priceLabel.frame = CGRectMake(STWidth(116), STHeight(25) + nameSize.height, priceSize.width, STHeight(17));
    
    
    _firstLabel.text = [NSString stringWithFormat:@"首单分成：¥%.2f",model.firstOrderProfit / 100];
    CGSize firstSize = [_firstLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _firstLabel.frame = CGRectMake(STWidth(134), STHeight(47) + nameSize.height, firstSize.width, STHeight(16));
    
    _reLabel.text = [NSString stringWithFormat:@"复购分成：¥%.2f",model.repeatProfit / 100];
    CGSize reSize = [_reLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _reLabel.frame = CGRectMake(STWidth(134), STHeight(66) + nameSize.height, reSize.width, STHeight(16));
    
    
    _firstTitleLabel.frame = CGRectMake(STWidth(116), STHeight(49) + nameSize.height, STHeight(12), STHeight(12));
    _reTitleLabel.frame = CGRectMake(STWidth(116), STHeight(68) + nameSize.height, STHeight(12), STHeight(12));
    
    if(showLinkView){
        _lineView.frame = CGRectMake(STWidth(15), STHeight(177)-LineHeight, STWidth(345), LineHeight);
        _linkLabel.hidden = NO;
        _linkCopyBtn.hidden = NO;
        _linkLabel.text = [NSString stringWithFormat:@"导购链接：%@",model.goodsLink];
    }else{
        _linkLabel.hidden = YES;
        _linkCopyBtn.hidden = YES;
        _lineView.frame = CGRectMake(STWidth(15), STHeight(142)-LineHeight, STWidth(345), LineHeight);
    }
}


+(NSString *)identify{
    return NSStringFromClass([PartnerCelebrityDetailViewCell class]);
}

@end

