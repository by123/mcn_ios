

#import "StatisticsCelebrityCell.h"


@interface StatisticsCelebrityCell()

@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *totalLabel;
@property(strong, nonatomic)UIView *lineView;

@end

@implementation StatisticsCelebrityCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
   _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
   [self.contentView addSubview:_nameLabel];
   
   _totalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c45 backgroundColor:nil multiLine:NO];
   [self.contentView addSubview:_totalLabel];
   
   _lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(60) - LineHeight, STWidth(345), LineHeight)];
   _lineView.backgroundColor = cline;
   [self.contentView addSubview:_lineView];
}

-(void)updateData:(StatisticsCelebrityModel *)model hiddenLine:(Boolean)hiddenLine{
  _nameLabel.text = model.anchorName;
  CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
  _nameLabel.frame = CGRectMake(STWidth(15), 0, nameSize.width, STHeight(60));
  
  _totalLabel.text = [NSString stringWithFormat:@"%.2f",model.value / 100];
  CGSize totalSize = [_totalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
  _totalLabel.frame = CGRectMake(ScreenWidth - totalSize.width - STWidth(15), 0, totalSize.width, STHeight(60));
  
  _lineView.hidden = hiddenLine;
    
}

+(NSString *)identify{
    return NSStringFromClass([StatisticsCelebrityCell class]);
}

@end

