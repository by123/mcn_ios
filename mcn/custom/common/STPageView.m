//
//  STPageView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "STPageView.h"
#define MAX_COUNT 5
#define SHOW_COUNT 0
@interface STPageView()<UIScrollViewDelegate>

@property(strong, nonatomic)NSMutableArray *mViews;
@property(strong, nonatomic)NSArray *mTitles;
@property(strong, nonatomic)UIScrollView *topScroll;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)NSMutableArray *buttons;
@property(assign, nonatomic)CGFloat perWidth;
@property(assign, nonatomic)CGFloat perLine;
@property(assign, nonatomic)NSInteger mCurrent;


@end

@implementation STPageView

-(instancetype)initWithFrame:(CGRect)frame views:(NSMutableArray *)views titles:(NSArray *)titles perLine:(CGFloat)perLine{
    return [self initWithFrame:frame views:views titles:titles perLine:perLine perWidth:0];
}

-(instancetype)initWithFrame:(CGRect)frame views:(NSMutableArray *)views titles:(NSArray *)titles perLine:(CGFloat)perLine perWidth:(CGFloat)perWidth{
    if(self == [super initWithFrame:frame]){
        _perLine = perLine;
        _buttons = [[NSMutableArray alloc]init];
        _mViews = views;
        _mTitles = titles;
        _mCurrent = 0;
        _selectedColor = c10;
        _normalColor = c11;
        if(perWidth > 0){
            _perWidth = perWidth;
        }else{
            _perWidth = (self.size.width / [_mTitles count]);
            if(_mTitles.count >= MAX_COUNT){
                _perWidth = self.size.width / MAX_COUNT;
            }
        }
        [self initView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame views:(NSMutableArray *)views titles:(NSArray *)titles{
    return [self initWithFrame:frame views:views titles:titles perLine:0.6f];
}

-(void)initView{
    if(IS_NS_COLLECTION_EMPTY(_mTitles) || IS_NS_COLLECTION_EMPTY(_mViews)) return;
    
    [self initContent];
    if(_mTitles.count > SHOW_COUNT){
        [self initTop];
    }
}

-(void)initTop{
    _topScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(38))];
    _topScroll.showsHorizontalScrollIndicator = NO;
    _topScroll.backgroundColor = cwhite;
    _topScroll.showsVerticalScrollIndicator = NO;
    [self addSubview:_topScroll];
    
    [_topScroll setContentSize:CGSizeMake(_perWidth * _mTitles.count,  STHeight(38))];
    
    _topView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(38))];
    _topView.backgroundColor = cwhite;
    [_topScroll addSubview:_topView];
    
    for(int i = 0 ; i < [_mTitles count] ; i ++ ){
        UIButton *btn = [[UIButton alloc]initWithFont:STFont(14) text:_mTitles[i] textColor:_normalColor backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
        btn.tag = i;
        btn.frame = CGRectMake(_perWidth * i, 0, _perWidth, STHeight(38));
        [btn addTarget:self action:@selector(OnItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_topScroll addSubview:btn];
        if(i == 0){
            btn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)];
            [btn setTitleColor:_selectedColor forState:UIControlStateNormal];
        }
        [_buttons addObject:btn];
    }
    
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(_perWidth *  (1 - _perLine)/2 , STHeight(38) - STWidth(3), _perWidth *  _perLine, STWidth(3))];
    _lineView.backgroundColor = c10;
    [_topView addSubview:_lineView];
    
}

-(void)showShadow{
    _topScroll.clipsToBounds = NO;
    _topScroll.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _topScroll.layer.shadowOffset = CGSizeMake(0,4);
    _topScroll.layer.shadowOpacity = 1;
    _topScroll.layer.shadowRadius = 10;
    
    CGRect shadowRect = CGRectMake(0, _topScroll.bounds.size.height-10/2, _topScroll.bounds.size.width, 10);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
    _topScroll.layer.shadowPath = bezierPath.CGPath;//阴影路径
}

-(void)initContent{
    CGFloat needHeight = 0;
    if(_mTitles.count > SHOW_COUNT){
        needHeight = STHeight(38);
    }
    CGFloat height = self.frame.size.height - needHeight;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, needHeight, self.size.width, height)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(self.size.width * _mTitles.count, height);
    for(int i = 0 ; i < [_mViews count] ; i ++ ){
        UIView *view = [_mViews objectAtIndex:i];
        view.frame = CGRectMake(self.size.width * i, 0, self.size.width, view.frame.size.height);
        [_scrollView addSubview:view];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat x =  scrollView.mj_offsetX;
    NSInteger current =  x / self.size.width;
    [self changeLinePosition:current];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x =  scrollView.mj_offsetX;
    CGFloat left = x / self.size.width * _perWidth;
    _lineView.frame = CGRectMake(_perWidth *  (1 - _perLine)/2 + left , STHeight(38) - STWidth(3), _perWidth * _perLine, STWidth(3));
    
}

-(void)OnItemClicked:(id)sender{
    NSInteger current = ((UIButton *)sender).tag;
    [self changeLinePosition:current];
}


-(void)changeLinePosition:(NSInteger)current{
    _mCurrent = current;
    [self changeTextColor:current];
    [_scrollView setContentOffset:CGPointMake(current * self.size.width, 0) animated:YES];
    
    if(_mTitles.count >= MAX_COUNT+1){
        if(_mTitles.count - current >= MAX_COUNT){
            [_topScroll setContentOffset:CGPointMake(current * _perWidth, 0) animated:YES];
        }
    }
    
    if(_delegate){
        [_delegate onPageViewSelect:current view:[_mViews objectAtIndex:current]];
    }
}


-(void)changeTextColor:(NSInteger)current{
    if(!IS_NS_COLLECTION_EMPTY(_buttons)){
        for(int i = 0; i < _buttons.count ; i ++){
            UIButton *tempBtn = [_buttons objectAtIndex:i];
            if(i == current){
                tempBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)];
                [tempBtn setTitleColor:_selectedColor forState:UIControlStateNormal];
            }else{
                tempBtn.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(14)];
                [tempBtn setTitleColor:_normalColor forState:UIControlStateNormal];
            }
        }
    }
}

-(void)setCurrentTab:(NSInteger)tab{
    [self changeLinePosition:tab];
    
}


-(void)changeFrame:(CGFloat)height offsetY:(CGFloat)offsetY {
    CGFloat newOffsetY = STHeight(38) + offsetY;
    self.frame = CGRectMake(0, self.frame.origin.y, self.size.width, height);
    _scrollView.frame = CGRectMake(0, newOffsetY, self.size.width, height - newOffsetY);
    for(int i = 0 ; i < [_mViews count] ; i ++ ){
        UIView *view = [_mViews objectAtIndex:i];
        view.frame = CGRectMake(self.size.width * i, 0, self.size.width, height - newOffsetY);
    }
}


-(void)fastenTopView:(CGFloat)top{
    _topScroll.mj_y = top;
}


-(id)getCurrentView{
    return [_mViews objectAtIndex:_mCurrent];
}

-(void)updateTitles:(NSMutableArray *)titles views:(NSMutableArray *)views{
    [_topScroll removeFromSuperview];
    [_scrollView removeFromSuperview];
    _mTitles = titles;
    _mViews = views;
    [self initView];
}


@end
