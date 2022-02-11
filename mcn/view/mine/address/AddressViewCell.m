

//
//  AddressViewCell.m
//  mcn
//
//  Created by by.huang on 2020/8/30.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "AddressViewCell.h"

@interface AddressViewCell()

@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *phoneLabel;
@property(strong, nonatomic)UILabel *addressLabel;
@property(strong, nonatomic)UILabel *defaultLabel;
@property(strong, nonatomic)UIView *selectView;


@end

@implementation AddressViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(166))];
    view.backgroundColor = cwhite;
    view.layer.shadowOffset = CGSizeMake(0, 0);
     view.layer.shadowRadius = 13;
     view.layer.cornerRadius = 2;
     view.layer.shadowOpacity = 0.06;
     view.layer.shadowColor = c10.CGColor;
    [self.contentView addSubview:view];
    
    _selectView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(20), STWidth(15), STWidth(15))];
    _selectView.backgroundColor = c19;
    _selectView.layer.cornerRadius = STWidth(15)/2;
    _selectView.hidden = YES;
    [view addSubview:_selectView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(16)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_nameLabel];
    
    _phoneLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(16)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_phoneLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(51.5), STWidth(315), LineHeight)];
    lineView.backgroundColor = cline;
    [view addSubview:lineView];
    
    _addressLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [view addSubview:_addressLabel];
    
    _defaultLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_ADDRESSINFO_DEFALT textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c16 multiLine:NO];
    _defaultLabel.frame = CGRectMake(STWidth(15), STHeight(125), STWidth(60), STHeight(22));
    [view addSubview:_defaultLabel];
    
    UIImageView *bottomImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, STHeight(162), STWidth(345), STHeight(4))];
    bottomImgView.image = [UIImage imageNamed:IMAGE_ADDRESSINFO_BOTTOM];
    bottomImgView.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:bottomImgView];
    
    
    _deleteBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_DELETE textColor:c12 backgroundColor:cclear corner:0 borderWidth:0 borderColor:nil];
    _deleteBtn.frame = CGRectMake(STWidth(345)-STWidth(48), STHeight(127),STWidth(38), STHeight(20));
    [view addSubview:_deleteBtn];
    
    _editBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_EDIT textColor:c12 backgroundColor:cclear corner:0 borderWidth:0 borderColor:nil];
    _editBtn.frame = CGRectMake(STWidth(345)-STWidth(96), STHeight(127),STWidth(38), STHeight(20));
    [view addSubview:_editBtn];
}

-(void)updateData:(AddressInfoModel *)model type:(AddressType)type{
    _deleteBtn.hidden = (type == AddressType_Select);
    _editBtn.hidden = (type == AddressType_Select);
    
    _nameLabel.text = model.contactUser;
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16) fontName:FONT_SEMIBOLD];
    if(type == AddressType_Select){
        _selectView.hidden = NO;
        _nameLabel.frame = CGRectMake(STWidth(40), STHeight(15), nameSize.width, STHeight(22));
    }else{
        _selectView.hidden = YES;
        _nameLabel.frame = CGRectMake(STWidth(15), STHeight(15), nameSize.width, STHeight(22));
    }
    
    if(model.isSelect){
        _selectView.backgroundColor = c16;
    }else{
        _selectView.backgroundColor = c19;
    }
    _phoneLabel.text = model.contactPhone;
    CGSize phoneSize = [_phoneLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16) fontName:FONT_SEMIBOLD];
    _phoneLabel.frame = CGRectMake(STWidth(330) - phoneSize.width, STHeight(15), phoneSize.width, STHeight(22));
    
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.area,model.detailAddr];
    _addressLabel.text = address;
    CGSize addressSize = [_addressLabel.text sizeWithMaxWidth:STWidth(315) font:STFont(15) fontName:FONT_REGULAR];
    if(addressSize.height > [self singLineHeight] * 2){
        _addressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _addressLabel.numberOfLines = 2;
        _addressLabel.frame = CGRectMake(STWidth(15), STHeight(67), STWidth(315), [self singLineHeight] * 2);
    }else{
        _addressLabel.frame = CGRectMake(STWidth(15), STHeight(67), STWidth(315), addressSize.height);
    }
    
    
    
    _defaultLabel.hidden = !model.defaultFlag;
    
}

//投机取巧
-(CGFloat)singLineHeight{
    CGSize contentSize = [@"小红菇" sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    return contentSize.height;
}


+(NSString *)identify{
    return NSStringFromClass([AddressViewCell class]);
}

@end

