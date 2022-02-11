//
//  FormsView.m
//  TreasureChest
//
//  Created by xiao ming on 2019/12/5.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import "FormsView.h"

#define FormsSpaceHeight STHeight(20)       //上下：间距
#define FormsLabelHeight STHeight(20)       //label高度
#define FormsPaddingWidth STWidth(15)      //左右：占位宽度
#define FormsLeftLabelWidth STWidth(120)   //leftLabel宽度
#define FormsFontSize 15

@interface FormsView()

@property(strong, nonatomic)NSMutableArray <UILabel *> *leftTitleLabels;
@property(strong, nonatomic)NSMutableArray <UILabel *> *rightTitleLabels;

@property(strong, nonatomic)UIView *topLineView;
@property(strong, nonatomic)UIView *bottomLineView;

@property(assign, nonatomic)CGFloat totalHeight;
@property(assign, nonatomic)NSInteger count;


@end

@implementation FormsView

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count {
    if(self == [super initWithFrame:frame]){
        _count = count;
        _totalHeight = [self getDefaultHeight];
        _leftLabelWidth = FormsLeftLabelWidth;
        _spaceHeight = FormsSpaceHeight;
        _leftTitleLabels = [NSMutableArray arrayWithCapacity:0];
        _rightTitleLabels = [NSMutableArray arrayWithCapacity:0];
        self.backgroundColor = cwhite;
        self.layer.masksToBounds = true;
        [self initView];
    }
    return self;
}

#pragma mark - < public >
- (void)setLeftTitles:(NSArray<NSString *> *)leftTitles {
    _leftTitles = leftTitles;
    [self refreshLabelsText:self.leftTitleLabels titles:leftTitles];
    [self refreshLayout];
}

- (void)setRightTitles:(NSArray<NSString *> *)rightTitles {
    _rightTitles = rightTitles;
    [self refreshLabelsText:self.rightTitleLabels titles:rightTitles];
    [self refreshLayout];
}

-(void)setRightImageRes:(NSString *)rightImageRes{
    _rightImageRes = rightImageRes;
    [self refreshRightImage:rightImageRes];
    [self refreshLayout];
}

- (void)setLeftLabelsFont:(UIFont *)leftLabelsFont {
    _leftLabelsFont = leftLabelsFont;
    [self refreshLabelsFont:_leftTitleLabels font:_leftLabelsFont];
    [self refreshLayout];
}

- (void)setRightLabelsFont:(UIFont *)rightLabelsFont {
    _rightLabelsFont = rightLabelsFont;
    [self refreshLabelsFont:_rightTitleLabels font:_rightLabelsFont];
    [self refreshLayout];
}

- (void)setLeftLabelsColor:(UIColor *)leftLabelsColor {
    _leftLabelsColor = leftLabelsColor;
    [self refreshLabelsTextColor:_leftTitleLabels textColor:_leftLabelsColor];
}

- (void)setRightLabelsColor:(UIColor *)rightLabelsColor {
    _rightLabelsColor = rightLabelsColor;
    [self refreshLabelsTextColor:_rightTitleLabels textColor:_rightLabelsColor];
}

- (void)setIsTopLineHidden:(BOOL)isTopLineHidden {
    _isTopLineHidden = isTopLineHidden;
    self.topLineView.hidden = isTopLineHidden;
}

- (void)setIsBottomLineHidden:(BOOL)isBottomLineHidden {
    _isBottomLineHidden = isBottomLineHidden;
    self.bottomLineView.hidden = isBottomLineHidden;
}


- (CGFloat)formsHeight {
    return self.totalHeight;
}

- (void)showHighlightStyle {
    [self refreshLabelsTextColor:_leftTitleLabels textColor:c10];
    [self refreshLabelsFont:_leftTitleLabels font:[UIFont fontWithName:FONT_REGULAR size:STFont(FormsFontSize)]];
    
    [self refreshLabelsTextColor:_rightTitleLabels textColor:c10];
    [self refreshLabelsFont:_rightTitleLabels font:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(FormsFontSize)]];
    
    [self refreshLayout];
}

- (void)showTopHighlightStyle {
    [self refreshLabelsTextColor:_leftTitleLabels textColor:c10];
    [self refreshLabelsFont:_leftTitleLabels font:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(FormsFontSize)]];
    
    [self refreshLabelsTextColor:_rightTitleLabels textColor:c10];
    [self refreshLabelsFont:_rightTitleLabels font:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(FormsFontSize)]];
    
    [self refreshLayout];
}

#pragma mark - < 右边可点击 >
-(void)refreshRightImage:(NSString *)imageRes{
    [_rightBtn setImage:[UIImage imageNamed:imageRes] forState:UIControlStateNormal];
}

#pragma mark - < 刷新 >
- (void)refreshLabelsText:(NSArray *)labels titles:(NSArray *)titles{
    NSInteger titleCount = MIN(titles.count, self.count);
    for (int i = 0; i<titleCount; i++) {
        UILabel *oneSideLabel = labels[i];
        oneSideLabel.text = titles[i];
    }

    //以右侧为准，防止右侧的值被覆盖。
    titleCount = MAX(titleCount, self.rightTitles.count);
    for (int i = 0; i<self.count; i++) {
        if (i >= titleCount) {
            UILabel *leftLabel = self.leftTitleLabels[i];
            leftLabel.text = @"";
            UILabel *rightLabel = self.rightTitleLabels[i];
            rightLabel.text = @"";
        }
    }
}

- (void)refreshLabelsFont:(NSArray *)labels font:(UIFont *)font {
    for (int i = 0; i<labels.count; i++) {
        UILabel *label = labels[i];
        label.font = font;
    }
}

- (void)refreshLabelsTextColor:(NSArray *)labels textColor:(UIColor *)color {
    for (int i = 0; i<labels.count; i++) {
        UILabel *label = labels[i];
        label.textColor = color;
    }
}

- (void)refreshLayout {
    CGFloat viewWidth = self.width;
    CGFloat leftWidth = _leftLabelWidth;
    CGFloat rightWidth = viewWidth - leftWidth - FormsPaddingWidth * 2;
    CGFloat paddinWidth = FormsPaddingWidth;
    CGFloat spaceHeight = _spaceHeight;
    CGFloat labelHeight = FormsLabelHeight;
      
    UIView *cursorView = [[UIView alloc]init];
    [self addSubview:cursorView];
    cursorView.frame = CGRectZero;
    
    //这里以右侧为主，因为右侧通常是变化的。如果左边5个，右边3个，则最终显示3个。
    NSInteger count = _rightTitles.count == 0 ? _leftTitles.count : _rightTitles.count;
    count = MIN(self.count, count);
      
    for (int i = 0; i<count; i++) {
        UILabel *leftLabel = self.leftTitleLabels[i];
        CGFloat height = [leftLabel.text sizeWithMaxWidth:leftWidth labelFont:leftLabel.font].height;
        height = MAX(height, labelHeight);
        leftLabel.frame = CGRectMake(paddinWidth, cursorView.bottom+spaceHeight, leftWidth, height);
    
        UILabel *rightLabel = self.rightTitleLabels[i];
        height = [rightLabel.text sizeWithMaxWidth:rightWidth labelFont:rightLabel.font].height;
        height = MAX(height, labelHeight);
        rightLabel.frame = CGRectMake(leftLabel.right, leftLabel.y, rightWidth, height);
        
        if(!IS_NS_STRING_EMPTY(_rightImageRes)){
            _rightBtn.frame = CGRectMake(ScreenWidth - STWidth(15) - STHeight(14), leftLabel.y + STHeight(4), STHeight(14), STHeight(14));
            rightLabel.frame = CGRectMake(ScreenWidth - STWidth(25) - STHeight(14) - rightWidth, leftLabel.y, rightWidth, height);
        }
        
        cursorView = CGRectGetMaxY(leftLabel.frame) > CGRectGetMaxY(rightLabel.frame) ? leftLabel : rightLabel;
    }
    
    if (count > 0) {
        self.totalHeight = cursorView.bottom + spaceHeight;
    }else {
        self.totalHeight = [self getDefaultHeight];
    }

    CGRect newFrame = self.frame;
    newFrame.size.height = self.totalHeight;
    self.frame = newFrame;
}

#pragma mark - < init view >
- (void)initView {
    [self initTitleLabels];
    
    CGFloat viewWidth = self.width;
    [self addSubview:self.topLineView];
    self.topLineView.frame = CGRectMake(FormsPaddingWidth, 0, viewWidth - FormsPaddingWidth*2, LineHeight);
    [self addSubview:self.bottomLineView];
    self.bottomLineView.frame = CGRectMake(FormsPaddingWidth, [self formsHeight]-LineHeight, viewWidth - FormsPaddingWidth*2, LineHeight);
    
    self.topLineView.hidden = true;
    self.bottomLineView.hidden = true;
    
    _rightBtn = [[UIButton alloc]init];
    [self addSubview:_rightBtn];
}

- (void)initTitleLabels {
    for (int i = 0; i<self.count; i++) {
        UILabel *leftLabel = [self getLabel];
        leftLabel.textColor = c11;
        UILabel *rightLabel = [self getLabel];
        rightLabel.textColor = c10;
        rightLabel.textAlignment = NSTextAlignmentRight;
        [self.leftTitleLabels addObject:leftLabel];
        [self.rightTitleLabels addObject:rightLabel];
    }
}

- (UILabel *)getLabel {
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont fontWithName:FONT_REGULAR size:STFont(FormsFontSize)];
    [self addSubview:label];
    return label;
}

-  (UIView *)topLineView {
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc]init];
        _topLineView.backgroundColor = cline;
    }
    return _topLineView;
}

-  (UIView *)bottomLineView {
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = cline;
    }
    return _bottomLineView;
}

+ (CGFloat)getFormsHeightWithTitles:(NSArray *)titles viewWidth:(CGFloat)viewWidth {

    CGFloat leftWidth = FormsLeftLabelWidth;
    CGFloat rightWidth = viewWidth - leftWidth - FormsPaddingWidth * 2;
    CGFloat spaceHeight = FormsSpaceHeight;
    CGFloat labelHeight = FormsLabelHeight;
    UIFont *font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(FormsFontSize)];
    
    //这里以右侧为主，因为右侧通常是变化的。如果左边5个，右边3个，则最终显示3个。
    NSInteger count = titles.count;
    
    CGFloat height = 0;
    for (int i = 0; i<count; i++) {
        CGFloat titileHeight = [titles[i] sizeWithMaxWidth:rightWidth labelFont:font].height;
        height += MAX(titileHeight, labelHeight);
    }
    
    if (count > 0) {
        return height + spaceHeight * (count+1);
    }else {
        return [[FormsView class] getDefaultHeight];
    }
}

- (CGFloat)getDefaultHeight {
    return (FormsLabelHeight + FormsSpaceHeight) * self.count + FormsSpaceHeight;
}


@end
