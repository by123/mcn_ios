

#import "PartnerProductViewCell.h"

@interface PartnerProductViewCell()

@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *priceLabel;

@end

@implementation PartnerProductViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(17.5), STHeight(90), STHeight(90))];
    _showImageView.layer.masksToBounds = YES;
    _showImageView.layer.cornerRadius = 4;
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_priceLabel];
}

-(void)updateData:(ProductModel *)model{
 
    if(!IS_NS_STRING_EMPTY(model.picUrl)){
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    }
    
    _nameLabel.text = [NSString stringWithFormat:@"%@%@",model.spuName,[ProductModel getAttributeValue:model.attribute]];
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:STWidth(215) font:STFont(14) fontName:FONT_REGULAR];
    if(nameSize.height > [self singLineHeight] * 3){
        nameSize.height = [self singLineHeight] * 3;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameLabel.numberOfLines = 3;
        _nameLabel.frame = CGRectMake(STWidth(115), STHeight(17.5), STWidth(215), [self singLineHeight] * 3);
    }else{
        _nameLabel.frame = CGRectMake(STWidth(115), STHeight(17.5), STWidth(215), nameSize.height);
    }
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.sellPrice/100];
    CGSize priceSize = [_priceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _priceLabel.frame = CGRectMake(STWidth(115), STHeight(86.5), priceSize.width, STHeight(21));
}

//投机取巧
-(CGFloat)singLineHeight{
    CGSize contentSize = [@"小红菇" sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    return contentSize.height;
}





+(NSString *)identify{
    return NSStringFromClass([PartnerProductViewCell class]);
}

@end

