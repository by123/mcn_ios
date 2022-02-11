

#import "CapitalListViewCell.h"
#import "STTimeUtil.h"
#import "ProductModel.h"

@interface CapitalListViewCell()

@property(strong, nonatomic)UILabel *typeLabel;
@property(strong, nonatomic)UILabel *timeLabel;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UILabel *priceTagLabel;
@property(strong, nonatomic)UIView *lineView;

@end

@implementation CapitalListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _typeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_typeLabel];
    
    _timeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_timeLabel];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_priceLabel];
    
    _priceTagLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_priceTagLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(15) - STHeight(16),STHeight(25), STHeight(16), STHeight(16))];
    arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:arrowImageView];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(135), STWidth(345), LineHeight)];
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
}

-(void)updateData:(CapitalListModel *)model hiddenLine:(Boolean)hiddenLine{
    
    if(model.profitType == ProfitType_Withdraw){
        _lineView.frame = CGRectMake(STWidth(15), STHeight(115), STWidth(345), LineHeight);
    }else{
        _lineView.frame = CGRectMake(STWidth(15), STHeight(135), STWidth(345), LineHeight);
    }
    
    NSString *typeStr = MSG_EMPTY;
    NSString *nameStr =[NSString stringWithFormat:@"%@%@",model.spuName,[ProductModel getAttributeValue:model.attribute]];
    NSString *priceTagStr = MSG_EMPTY;
    if(model.profitType == ProfitType_Withdraw){
        typeStr = @"提现";
        nameStr = [NSString stringWithFormat:@"收款账户：%@",model.bankId];
        _priceTagLabel.hidden = YES;
    }else if(model.profitType  == ProfitType_GuideBuy){
        typeStr = @"导购订单";
        priceTagStr = @"合作收入";
        _priceTagLabel.hidden = NO;
    }else if(model.profitType == ProfitType_NatureBuy){
        typeStr = @"自然购买";
        priceTagStr = @"自然收入";
        _priceTagLabel.hidden = NO;
    }
    _typeLabel.text = typeStr;
    CGSize typeSize = [_typeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _typeLabel.frame = CGRectMake(STWidth(15), STHeight(20), typeSize.width, STHeight(21));
    
    
    _timeLabel.text = [STTimeUtil generateDate:model.orderTime format:MSG_DATE_FORMAT_ALL];
    CGSize timeSize = [_timeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _timeLabel.frame = CGRectMake(STWidth(15), STHeight(42), timeSize.width, STHeight(21));
    
    
    _nameLabel.text = nameStr;
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:STWidth(254) font:STFont(15) fontName:FONT_REGULAR];
      if(nameSize.height > [self singLineHeight] * 2){
          _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
          _nameLabel.numberOfLines = 2;
          _nameLabel.frame = CGRectMake(STWidth(15), STHeight(73), STWidth(254), [self singLineHeight] * 2);
      }else{
          _nameLabel.frame = CGRectMake(STWidth(15), STHeight(73), STWidth(254), nameSize.height);
      }
    
    
    
    _priceLabel.text = [NSString stringWithFormat:@"%@%.2f",(model.direction == 0) ? @"+" : @"-",model.profit/100];
    CGSize priceSize = [_priceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _priceLabel.frame = CGRectMake(ScreenWidth -  STWidth(15) - priceSize.width, STHeight(71), priceSize.width, STHeight(21));
    _priceLabel.textColor = (model.direction == 0) ? c36 : c11;
    
    _priceTagLabel.text = priceTagStr;
    CGSize priceTagSize = [_priceTagLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _priceTagLabel.frame = CGRectMake(ScreenWidth -  STWidth(15) - priceTagSize.width, STHeight(94), priceTagSize.width, STHeight(21));
    
    _lineView.hidden = hiddenLine;
}

//投机取巧
-(CGFloat)singLineHeight{
    CGSize contentSize = [@"小红菇" sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    return contentSize.height;
}


+(NSString *)identify{
    return NSStringFromClass([CapitalListViewCell class]);
}

@end

