

#import "StatisticsCooperateItemItemCell.h"


@interface StatisticsCooperateItemItemCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *totalLabel;

@end

@implementation StatisticsCooperateItemItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STHeight(25), STHeight(25))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(12.5);
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_nameLabel];
    
    _totalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_totalLabel];
}

-(void)updateData:(CooperateCelebrityModel *)model{
    if(!IS_NS_STRING_EMPTY(model.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picFullUrl]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    
    _nameLabel.text = model.anchorName;
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _nameLabel.frame = CGRectMake(STWidth(50), STHeight(15), nameSize.width, STHeight(25));
    
    _totalLabel.text = [NSString stringWithFormat:@"%.2f",model.value / 100];
    CGSize totalSize = [_totalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _totalLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - totalSize.width, STHeight(15), totalSize.width, STHeight(25));

}

+(NSString *)identify{
    return NSStringFromClass([StatisticsCooperateItemItemCell class]);
}

@end

