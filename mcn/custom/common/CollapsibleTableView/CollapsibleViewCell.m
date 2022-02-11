//
//  CollapsibleViewCell.m
//  TreasureChest
//
//  Created by xiao ming on 2019/12/19.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import "CollapsibleViewCell.h"
#import "UIView+Frame.h"

@interface CollapsibleViewCell ()

@property (strong, nonatomic) UIButton *selectButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation CollapsibleViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _selectView.centerY = self.height * 0.5;
    _titleLabel.height = self.height;
    _arrowImageView.centerY = self.height * 0.5;
    
    
    CGFloat cellWidth = self.contentView.width;
    
    // 每一级错开距离
    CGFloat marin = STWidth(15);

    CGFloat buttonLeft = STWidth(15) + self.menuItem.index * marin;
    self.selectView.x = buttonLeft;
    self.selectButton.frame = CGRectMake(0, 0, _selectView.right, self.contentView.height);
    
    self.titleLabel.x = self.selectView.right + 10;
    CGFloat restWidth = cellWidth - _titleLabel.x - _arrowImageView.width - marin;
    CGFloat titleWidth = [_titleLabel.text sizeWithMaxWidth:restWidth font:STFont(14) fontName:FONT_SEMIBOLD].width;
    self.titleLabel.width = titleWidth;
    
    CGRect arrorFrame = self.arrowImageView.frame;
    arrorFrame.origin.x = cellWidth - CGRectGetWidth(arrorFrame)- marin;
    self.arrowImageView.frame = arrorFrame;
    
    self.lineView.hidden = self.menuItem.index != 0;
}

#pragma mark - < set >
- (void)setMenuItem:(CollapsibleModel *)menuItem {
    _menuItem = menuItem;
    [self refreshCell];
}

- (void)refreshCell {
    self.titleLabel.text = [self.menuItem getShowName];
    self.selectView.backgroundColor = self.menuItem.isSelected ? c16 : c24;
    self.arrowImageView.hidden = !self.menuItem.isCanUnfold;
    self.arrowImageView.image = self.menuItem.isUnfold ? [UIImage imageNamed:@"ic_choose_dropUp"] : [UIImage imageNamed:@"ic_choose_dropDown"];
    if (self.menuItem.index > 0) {
        self.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(14)];
    }else {
        self.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)];
    }
}

#pragma mark - < 点击事件 >

- (void)selectBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(cellSelectedBtnClick:)]) {
        [self.delegate cellSelectedBtnClick:self];
    }
}

#pragma mark - < getter >

- (void)initView {
    self.selectView.frame = CGRectMake(0, 0, STWidth(18.5), STWidth(18.5));
    self.selectView.layer.cornerRadius = STWidth(18.5)/2.0;
    self.selectView.layer.masksToBounds = true;
    [self.contentView addSubview:self.selectView];
    
    self.titleLabel.frame = CGRectMake(self.selectView.right + 10, 0, STWidth(100), STHeight(20));
    [self.contentView addSubview:self.titleLabel];
    
    self.arrowImageView.frame = CGRectMake(0, 0, STWidth(11), STWidth(11));
    [self.contentView addSubview:self.arrowImageView];
    
    self.lineView.frame = CGRectMake(STWidth(15), 0, ScreenWidth - STWidth(15*2), LineHeight);
    [self.contentView addSubview:self.lineView];
    
    self.selectButton.frame = self.selectView.frame;
    [self.contentView addSubview:self.selectButton];
}

- (UIButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc] init];
        [_selectButton addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (UIView *)selectView
{
    if (!_selectView) {
        _selectView = [[UIView alloc] init];
    }
    return _selectView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)] text:@"" textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = cline;
    }
    return _lineView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_choose_dropDown"]];
    }
    return _arrowImageView;
}

@end
