//
//  TabTitleScrollView.m
//  TreasureChest
//
//  Created by xiao ming on 2019/12/20.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import "TabTitleScrollView.h"
#import "STColorUtil.h"

static CGFloat maxCount = 4.5;
static NSString *backgroudColorString = @"007AFF";
static NSString *cursorViewColorString = @"ffffff";

@interface TabTitleScrollView()<UIScrollViewDelegate>

@property(strong, nonatomic)NSArray *titles;
@property(strong, nonatomic)NSMutableArray <UIButton *> *titleButtons;
@property(strong, nonatomic)UIScrollView *contentScrollView;
@property(strong, nonatomic)UIView *cursorLineView;

@property(assign, nonatomic)CGFloat cursorOriginX;
@property(assign, nonatomic)CGFloat buttonWidth;

@property(strong, nonatomic)UIColor *normalColor;
@property(strong, nonatomic)UIColor *selectedColor;

@property(assign, nonatomic)NSInteger currentIndex;

@end

@implementation TabTitleScrollView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if(self == [super initWithFrame:frame]){
        _titles = titles;
        [self initConfig];
        [self initView];
    }
    return self;
}

- (void)initConfig {
    _normalColor = [UIColor whiteColor];
    _selectedColor = [UIColor whiteColor];
    _titleButtons = [NSMutableArray arrayWithCapacity:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = CGRectGetHeight(self.frame);
    _contentScrollView.height = height;
    for (UIButton *button in _titleButtons) {
        button.height = height;
    }
    
    _cursorLineView.centerY = height - _cursorLineView.height/2.0;
}

- (void)initView {
    self.backgroundColor = [STColorUtil colorWithHexString:backgroudColorString];;
    [self initScrollView];
    [self initScrollViewContents];
    
    _cursorLineView = [[UIView alloc]init];
    _cursorLineView.frame = CGRectMake(0, 0, 20, 3);
    _cursorLineView.backgroundColor = [STColorUtil colorWithHexString:cursorViewColorString];
    [_contentScrollView addSubview:_cursorLineView];
    
    if ([_titleButtons count] > 0) {
        UIButton *firstButton = _titleButtons[0];
        _cursorLineView.center = CGPointMake(firstButton.center.x, CGRectGetMaxY(firstButton.frame)-CGRectGetHeight(_cursorLineView.frame)/2.0);
        _cursorOriginX = CGRectGetMinX(_cursorLineView.frame);
    }
}

- (void)initScrollView {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    _buttonWidth = width/MIN(_titles.count, maxCount);
    
    _contentScrollView = [[UIScrollView alloc]init];
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.delegate = self;
    _contentScrollView.frame = CGRectMake(0, 0, width, height);
    _contentScrollView.contentSize = CGSizeMake(_buttonWidth*_titles.count, CGRectGetHeight(_contentScrollView.frame));
    [self addSubview:_contentScrollView];
}

- (void)initScrollViewContents {
    CGFloat height = CGRectGetHeight(_contentScrollView.frame);
    
    for (int i = 0; i<_titles.count; i++) {
        NSString *title = _titles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(_buttonWidth*i, 0, _buttonWidth, height);
        [_contentScrollView addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButtons addObject:button];
    }
    
    [self changeTitleSelectedColor:_selectedColor normalColor:_normalColor];
}

- (void)buttonEvent:(UIButton *)button {
    if (button.isSelected) { return; }
    [self refreshButtonSelectedState:button];
    if ([self.delegate respondsToSelector:@selector(tabButtonSelectedIndex:)]) {
        [self.delegate tabButtonSelectedIndex:button.tag];
    }
}

#pragma mark - public method
- (void)offsetRatio:(CGFloat)ratio {
    CGRect cursorFrame = _cursorLineView.frame;
    cursorFrame.origin.x = _cursorOriginX + (_contentScrollView.contentSize.width * ratio);
    _cursorLineView.frame = cursorFrame;
}

///’动画/拖到‘结束后刷新
- (void)refreshSelectedWithFinalRatio:(CGFloat)ratio {
    CGFloat pageRatio = 1.0/_titles.count;
    NSInteger nextIndex = round(ratio / pageRatio);
    nextIndex = MIN(nextIndex, _titles.count-1);
    
    self.currentIndex = nextIndex;
    [self refreshButtonSelectedState:_titleButtons[nextIndex]];
    [self makeCursorLineViewVisible:ratio];
}

- (void)addViewShadow:(UIColor *)shadowColor {
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowColor = shadowColor == nil ? self.backgroundColor.CGColor : shadowColor.CGColor;
}

- (void)changeCursorLineViewColor:(UIColor *)color {
    _cursorLineView.backgroundColor = color;
}

- (void)changeBackgroundColor:(UIColor *)color {
    self.backgroundColor = color;
}

- (void)changeTitleSelectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor {
    self.normalColor = normalColor;
    self.selectedColor = selectedColor;

    if ([_titleButtons count] > 0) {
        [self refreshButtonSelectedState:_titleButtons[0]];
    }
}

#pragma mark - < private method >
- (void)refreshButtonSelectedState:(UIButton *)button {
    for (int i = 0; i<_titleButtons.count; i++) {
        UIButton *button = _titleButtons[i];
        button.selected = false;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:_normalColor forState:UIControlStateNormal];
    }
    
    button.selected = true;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button setTitleColor:_selectedColor forState:UIControlStateNormal];
}

- (void)makeCursorLineViewVisible:(CGFloat)finalRatio {
    //判断’游标‘是否超出屏幕
    CGFloat visibleRatio = floor(maxCount) / _titles.count;//maxCount / _titles.count;//
    CGFloat currentRatio = _contentScrollView.contentOffset.x / _contentScrollView.contentSize.width;
    
    CGPoint offset = _contentScrollView.contentOffset;
    CGFloat pageWidth = CGRectGetWidth(_contentScrollView.frame) / maxCount;
    CGFloat maxOffsetX = _contentScrollView.contentSize.width - CGRectGetWidth(_contentScrollView.frame);
    
    if (finalRatio >= (visibleRatio + currentRatio)) {
        offset.x += pageWidth;
        offset.x = MIN(offset.x, maxOffsetX);
    }
    if (finalRatio < currentRatio) {
        offset.x -= pageWidth;
        offset.x = MAX(offset.x, 0);
    }
    
    [_contentScrollView setContentOffset:offset animated:true];
}

- (int)roundWithType:(BOOL)isUp value:(CGFloat)value {
    int tmp = (int)(value * 100) % 100;
    if (isUp) {
        return (tmp != 0) ? ceil(value) : (int)value;
    }
    return (tmp != 0) ? floor(value) : (int)value;;
}

- (void)newMethod:(NSInteger)nextIndex {
    //判断’游标‘是否超出屏幕
    CGFloat pageRatio = 1.0/_titles.count;
    CGPoint offset = _contentScrollView.contentOffset;
    CGFloat contentSizeWidth = _contentScrollView.contentSize.width;
    CGFloat scrollViewWidth = CGRectGetWidth(_contentScrollView.frame);
    CGFloat pageWidth = CGRectGetWidth(_contentScrollView.frame) / maxCount;

    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = contentSizeWidth - scrollViewWidth;
    
    CGFloat visibleRightRatio = floor(maxCount) / _titles.count;
    CGFloat visibleLeftRatio = offset.x / contentSizeWidth;
    
    int visibleMinIndex = [self roundWithType:true value:visibleLeftRatio/pageRatio];
    int visibleMaxIndex = [self roundWithType:false value:visibleRightRatio/pageRatio];
    
    CGFloat currentIndex = self.currentIndex;
    
//    offset.x += (nextIndex - currentIndex)*pa
        
    
    //计算区间
    CGFloat minRatio = _contentScrollView.contentOffset.x / _contentScrollView.contentSize.width;
    
    
    
    
//    if (finalRatio >= (visibleRatio + currentRatio)) {
//        offset.x += pageWidth;
//        offset.x = MIN(offset.x, maxOffsetX);
//    }xwkj
    
//    if (finalRatio < currentRatio) {
//        offset.x -= pageWidth;
//        offset.x = MAX(offset.x, 0);
//    }
    
    [_contentScrollView setContentOffset:offset animated:true];
}

@end
