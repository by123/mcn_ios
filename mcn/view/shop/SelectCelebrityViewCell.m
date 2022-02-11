

#import "SelectCelebrityViewCell.h"

@interface SelectCelebrityViewCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UIView *lineView;
@property(strong, nonatomic)UIImageView *selectImageView;

@end

@implementation SelectCelebrityViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STHeight(50), STHeight(50))];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(25);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_nameLabel];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(80) - LineHeight, STWidth(345), LineHeight)];
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
    
    _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(15) - STHeight(15), STHeight(33), STHeight(14), STHeight(14))];
    _selectImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_selectImageView];
}

-(void)updateData:(CelebrityModel *)model hiddenLine:(Boolean)hiddenLine{
    if(!IS_NS_STRING_EMPTY(model.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picFullUrl]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    _lineView.hidden = hiddenLine;
    
    _nameLabel.text = model.mchName;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _nameLabel.frame = CGRectMake(STWidth(25) + STHeight(50), 0, STWidth(250), STHeight(80));
    
    _selectImageView.image = [UIImage imageNamed:model.isSelect ? IMAGE_SELECT : IMAGE_NO_SELECT];

}

+(NSString *)identify{
    return NSStringFromClass([SelectCelebrityViewCell class]);
}

@end

