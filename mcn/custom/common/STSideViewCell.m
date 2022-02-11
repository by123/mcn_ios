

#import "STSideViewCell.h"



@interface STSideViewCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UIView *selectView;


@end

@implementation STSideViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _selectView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(20), STHeight(22), STHeight(16), STHeight(16))];
    _selectView.backgroundColor = c24;
    _selectView.layer.masksToBounds = YES;
    _selectView.layer.cornerRadius = STHeight(8);
    [self.contentView addSubview:_selectView];
    
    _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(20), STHeight(60) - LineHeight, STWidth(280), LineHeight)];
    lineView.backgroundColor = cline;
    [self.contentView addSubview:lineView];
}

-(void)updateData:(TitleContentModel *)model{
    if(model.isSelect){
        _selectView.backgroundColor = c16;
    }else{
        _selectView.backgroundColor = c24;
    }
    _titleLabel.text = model.title;
    CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth - STWidth(60) font:STFont(14) fontName:FONT_SEMIBOLD];
    _titleLabel.frame = CGRectMake(STWidth(45), 0, titleSize.width, STHeight(60));
    
}

+(NSString *)identify{
    return NSStringFromClass([STSideViewCell class]);
}

@end

