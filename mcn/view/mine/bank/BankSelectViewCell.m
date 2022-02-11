

#import "BankSelectViewCell.h"


@interface BankSelectViewCell()

@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *typeLabel;
@property(strong, nonatomic)UIImageView *selectImageView;

@end

@implementation BankSelectViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    UIView *cardView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(20), STWidth(345), STHeight(100))];
    cardView.backgroundColor = cwhite;
    cardView.layer.cornerRadius = 4;
    cardView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    cardView.layer.shadowOffset = CGSizeMake(0,2);
    cardView.layer.shadowOpacity = 1;
    cardView.layer.shadowRadius = 10;
    [self.contentView addSubview:cardView];
    
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(20), STHeight(33), STHeight(24), STHeight(24))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cardView addSubview:_showImageView];
    
    _typeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(16)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [cardView addSubview:_typeLabel];
    
    _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(310), STHeight(37), STHeight(15), STHeight(15))];
    _selectImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cardView addSubview:_selectImageView];
    
}

-(void)updateData:(TitleContentModel *)model{
    
    _showImageView.image = [UIImage imageNamed:model.title];
    
    _typeLabel.text = model.content;
    CGSize typeSize = [_typeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16) fontName:FONT_SEMIBOLD];
    _typeLabel.frame = CGRectMake(STWidth(53), 0, typeSize.width, STHeight(90));
    
    _selectImageView.image = [UIImage imageNamed:model.isSelect ? IMAGE_SELECT : IMAGE_NO_SELECT2];
}

+(NSString *)identify{
    return NSStringFromClass([BankSelectViewCell class]);
}

@end

