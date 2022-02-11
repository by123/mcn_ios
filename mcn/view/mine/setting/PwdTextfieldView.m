//
//  PwdTextfieldView.m
//  cigarette
//
//  Created by xiao ming on 2019/12/16.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "PwdTextfieldView.h"

@interface PwdTextfieldView()
@property(strong, nonatomic)NSString *title;
@property(strong, nonatomic)NSString *placehold;

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UITextField *textField;
@property(strong, nonatomic)UIButton *hideButton;
@property(strong, nonatomic)UIButton *clearButton;

@end

@implementation PwdTextfieldView

- (instancetype)initWithTitle:(NSString *)title placehold:(NSString *)placehold {
    if(self == [super init]){
        _title = title;
        _placehold = placehold;
        [self initView];
        self.backgroundColor = cwhite;
    }
    return self;
}

- (void)initView {
    _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:_title textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(STWidth(15));
        make.width.equalTo(@120);
        make.height.equalTo(@STHeight(20));
    }];
    
    _clearButton = [[UIButton alloc]initWithFont:STFont(16) text:@"" textColor:c10 backgroundColor:cclear corner:0 borderWidth:0 borderColor:nil];
    [_clearButton setImage:[UIImage imageNamed:IMAGE_PSW_CLEAR] forState:UIControlStateNormal];
    [_clearButton addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clearButton];
    [_clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(STWidth(-15));
        make.width.height.equalTo(@STWidth(30));
    }];
    
    _hideButton = [[UIButton alloc]initWithFont:STFont(16) text:@"" textColor:c10 backgroundColor:cclear corner:0 borderWidth:0 borderColor:nil];
    [_hideButton setImage:[UIImage imageNamed:IMAGE_PSW_HIDDEN] forState:UIControlStateNormal];
    [_hideButton setImage:[UIImage imageNamed:IMAGE_PSW_VISIBLE] forState:UIControlStateSelected];
    [_hideButton addTarget:self action:@selector(hideBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hideButton];
    [_hideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_clearButton.mas_left).offset(STWidth(-3));
        make.width.height.equalTo(@STWidth(30));
    }];
    
    _textField = [[UITextField alloc]init];
    _textField.placeholder = _placehold;
    _textField.text = @"";
    _textField.textColor = c10;
    _textField.secureTextEntry = true;
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.font = [UIFont fontWithName:FONT_REGULAR size:STFont(16)];
    [_textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right);
        make.centerY.equalTo(self);
        make.right.equalTo(_hideButton.mas_left);
        make.height.equalTo(@40);
    }];
}

#pragma mark - button event
- (void)clearBtnClick {
    _textField.text = @"";
}

- (void)hideBtnClick {
    _textField.secureTextEntry = _hideButton.isSelected;
    _hideButton.selected = !_hideButton.selected;
}

#pragma mark - text didchange
- (void)textDidChange:(UITextField*)textField {
    self.text = textField.text;
}

@end
