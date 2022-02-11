

#import "WithdrawListViewCell.h"
#import "STTimeUtil.h"

@interface WithdrawListViewCell()

@property(strong, nonatomic)UILabel *timeLabel;
@property(strong, nonatomic)UILabel *statuLabel;
@property(strong, nonatomic)UILabel *idLabel;
@property(strong, nonatomic)UILabel *withdrawLabel;
@property(strong, nonatomic)UILabel *feeLabel;
@property(strong, nonatomic)UILabel *taxLabel;
@property(strong, nonatomic)UILabel *actualLabel;
@property(strong, nonatomic)UILabel *getTimeLabel;

@end

@implementation WithdrawListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(15), ScreenWidth, STHeight(295))];
    view.backgroundColor = cwhite;
    [self.contentView addSubview:view];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(60) - LineHeight, STWidth(345), LineHeight)];
    lineView.backgroundColor = cline;
    [view addSubview:lineView];
    
    NSArray *titles = @[@"收款账户",@"提现金额",@"手续费",@"税费",@"实际到账",@"到账时间"];
    for(int i = 0 ; i < titles.count; i++){
        UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:titles[i] textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
        CGSize nameSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
        titleLabel.frame = CGRectMake(STWidth(15), STHeight(80) + STHeight(35) * i, nameSize.width, STHeight(20));
        [view addSubview:titleLabel];
    }
    
    _timeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_timeLabel];
    
    _statuLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_statuLabel];
    
    _idLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_idLabel];
    
    _withdrawLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_withdrawLabel];
    
    _feeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_feeLabel];
    
    _taxLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_taxLabel];
    
    _actualLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_actualLabel];
    
    _getTimeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_getTimeLabel];
}

-(void)updateData:(WithdrawModel *)model{
    
    _timeLabel.text = [STTimeUtil generateDate:model.createTime format:MSG_DATE_FORMAT_ALL];
    CGSize timeSize = [_timeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _timeLabel.frame = CGRectMake(STWidth(15), STHeight(20), timeSize.width, STHeight(20));
    
    _statuLabel.text = [WithdrawModel getWithdrawState:model.withdrawState];
    CGSize statuSize = [_statuLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _statuLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - statuSize.width, STHeight(20), statuSize.width, STHeight(20));
    
    
    _idLabel.text = model.bankId;
    CGSize idSize = [_idLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _idLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - idSize.width, STHeight(80), idSize.width, STHeight(20));
    
    _withdrawLabel.text = [NSString stringWithFormat:@"%.2f元",model.totalMoney / 100];
    CGSize withdrawSize = [_withdrawLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _withdrawLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - withdrawSize.width, STHeight(115), withdrawSize.width, STHeight(20));
    
    _feeLabel.text = [NSString stringWithFormat:@"%.2f元",model.auxiliaryExpenses / 100];
    CGSize feeSize = [_feeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _feeLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - feeSize.width, STHeight(150), feeSize.width, STHeight(20));
    
    _taxLabel.text = [NSString stringWithFormat:@"%.2f元",model.taxMoney / 100];
    CGSize taxSize = [_taxLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _taxLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - taxSize.width, STHeight(185), taxSize.width, STHeight(20));
    
    _actualLabel.text = [NSString stringWithFormat:@"%.2f元",model.withdrawMoney / 100];
    CGSize actualSize = [_actualLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _actualLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - actualSize.width, STHeight(220), actualSize.width, STHeight(20));
    
    if(model.withdrawState != 2){
        _getTimeLabel.text = @"处理中";
    }else{
        _getTimeLabel.text = [STTimeUtil generateDate:model.payDate format:MSG_DATE_FORMAT_ALL];
    }
    CGSize getTimeSize = [_getTimeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _getTimeLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - getTimeSize.width, STHeight(255), getTimeSize.width, STHeight(20));
    
}

+(NSString *)identify{
    return NSStringFromClass([WithdrawListViewCell class]);
}

@end

