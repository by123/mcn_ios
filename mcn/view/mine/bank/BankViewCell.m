

#import "BankViewCell.h"


@interface BankViewCell()

@property(strong, nonatomic)UIView *cardView;
@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *accountLabel;
@property(strong, nonatomic)UILabel *typeLabel;
@property(strong, nonatomic)UILabel *idLabel;

@end

@implementation BankViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _cardView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(114))];
    _cardView.layer.masksToBounds = YES;
    _cardView.layer.cornerRadius = 4;
    [self.contentView addSubview:_cardView];
    
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(20), STHeight(20), STHeight(40), STHeight(40))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_cardView addSubview:_showImageView];
    
    _accountLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [_cardView addSubview:_accountLabel];
    
    _typeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [_cardView addSubview:_typeLabel];
    
    _idLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [_cardView addSubview:_idLabel];
    
    _delBtn = [[UIButton alloc]initWithFont:STFont(12) text:@"删除" textColor:cwhite backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    _delBtn.frame = CGRectMake(STWidth(280), STHeight(75), STWidth(65), STHeight(22));
    [_cardView addSubview:_delBtn];
}

-(void)updateData:(BankModel *)model{
    
    NSString *accountStr;
    NSString *typeStr;
    if(model.isPublic == BankType_Bank_Public){
        accountStr = model.bankName;
        typeStr = @"对公账户";
        _cardView.backgroundColor = c43;
        _showImageView.image = [UIImage imageNamed:IMAGE_BANK_PUBLIC];
    }else if(model.isPublic == BankType_Bank_Personal){
        accountStr = model.bankName;
        typeStr = @"个人账户";
        _cardView.backgroundColor = c14;
        _showImageView.image = [UIImage imageNamed:IMAGE_BANK_PERSONAL];
    }
    else{
        accountStr = @"支付宝";
        typeStr = model.isPublic == BankType_Alipay_Personal ? @"个人账户" : @"对公账户";
        _showImageView.image = [UIImage imageNamed:IMAGE_BANK_ALIPAY];
        _cardView.backgroundColor = c42;
    }
    
    _accountLabel.text = accountStr;
    CGSize accountSize = [_accountLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _accountLabel.frame = CGRectMake(STWidth(65), STHeight(20), accountSize.width, STHeight(21));
    
    _typeLabel.text = typeStr;
    CGSize typeSize = [_typeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _typeLabel.frame = CGRectMake(STWidth(65), STHeight(43), typeSize.width, STHeight(17));
    
    _idLabel.text = model.bankId;
    CGSize idSize = [_idLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _idLabel.frame = CGRectMake(STWidth(20), STHeight(77), idSize.width, STHeight(17));
    
}

+(NSString *)identify{
    return NSStringFromClass([BankViewCell class]);
}

@end

