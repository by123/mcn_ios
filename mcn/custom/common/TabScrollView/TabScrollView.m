//
//  TabScrollView.m
//  TreasureChest
//
//  Created by xiao ming on 2019/12/20.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import "TabScrollView.h"
#import <Masonry/Masonry.h>

@interface TabScrollView()<UIScrollViewDelegate,TabTitleScrollViewDelegate>

@property(strong, nonatomic)NSArray *views;
@property(strong, nonatomic)NSArray *titles;

@property(assign, nonatomic)NSInteger lastSelectedIndex;

@end

@implementation TabScrollView

- (instancetype)initWithFrame:(CGRect)frame contents:(NSArray *)views titles:(NSArray *)titles contentOffsetY:(CGFloat)contentOffsetY {
    _contentOffsetY = contentOffsetY;
    return [self initWithFrame:frame contents:views titles:titles];
}

- (instancetype)initWithFrame:(CGRect)frame contents:(NSArray *)views titles:(NSArray *)titles {
    if(self == [super initWithFrame:frame]){
        _titles = titles;
        _views = views;
        _lastSelectedIndex = 0;
        _titleHeight = [TabScrollView getTitleTabHeight];
        [self initView];
    }
    return self;
}

//考虑逐渐转移到这里来做布局变化，(上面的两个初始化方法可以不用传入offsetY).
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleHeght = self.titleHeight;
    _titleScrollView.height = titleHeght;
    _contentScrollView.y = titleHeght + self.contentOffsetY;
    _contentScrollView.height = CGRectGetHeight(self.frame) - _contentScrollView.y;
    _contentScrollView.contentSize = CGSizeMake(_contentScrollView.contentSize.width, _contentScrollView.height);
    for (UIView *view in _views) {
        view.height = _contentScrollView.height;
    }
}

#pragma mark - init
- (void)initView {
    CGFloat titleHeght = [TabScrollView getTitleTabHeight];
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    _titleScrollView = [[TabTitleScrollView alloc]initWithFrame:CGRectMake(0, 0, width, titleHeght) titles:self.titles];
    _titleScrollView.delegate = self;
    
    CGFloat offsetY = titleHeght + self.contentOffsetY;
    
    _contentScrollView = [[UIScrollView alloc]init];
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.frame = CGRectMake(0, offsetY, width, height-offsetY);
    _contentScrollView.contentSize = CGSizeMake(width*_views.count, CGRectGetHeight(_contentScrollView.frame));
    [self addSubview:_contentScrollView];
    
    [self initScrollViewContents];
    [self addSubview:_titleScrollView];
}

- (void)initScrollViewContents {
    CGFloat width = CGRectGetWidth(_contentScrollView.frame);
    CGFloat height = CGRectGetHeight(_contentScrollView.frame);
    
    for (int i = 0; i<_views.count; i++) {
        UIView *view = _views[i];
        view.frame = CGRectMake(width * i, 0, width, height);
        [_contentScrollView addSubview:view];
    }
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat ratio = scrollView.contentOffset.x / scrollView.contentSize.width;
    [_titleScrollView offsetRatio:ratio];
}

//拖动结束触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self refreshWhenSelected:scrollView];
}

//动画结束触发
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self refreshWhenSelected:scrollView];
}

#pragma mark - title scrollview delegate
- (void)tabButtonSelectedIndex:(NSInteger)index {
    CGPoint offset = _contentScrollView.contentOffset;
    offset.x = index * CGRectGetWidth(_contentScrollView.frame);
    [_contentScrollView setContentOffset:offset animated:true];
}

#pragma mark - public
- (id)getSelectedView {
    CGFloat ratio = _contentScrollView.contentOffset.x / _contentScrollView.contentSize.width;
    NSInteger index = round(ratio * _views.count);
    return _views[index];
}

+ (CGFloat)getTitleTabHeight {
    return 40;
}

#pragma mark - < private method >
- (void)refreshWhenSelected:(UIScrollView *)scrollView {
    CGFloat ratio = scrollView.contentOffset.x / scrollView.contentSize.width;
    [_titleScrollView refreshSelectedWithFinalRatio:ratio];
    
    NSInteger index = round(ratio * _views.count);
    if (self.lastSelectedIndex != index) {
        [self selectedCallBack:index];
    }
    self.lastSelectedIndex = index;
}

- (void)selectedCallBack:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(selectedContentView:selectedIndex:)]) {
        [self.delegate selectedContentView:_views[index] selectedIndex:index];
    }
}

@end
