//
//  MCNImageScrollView.m
//  mcn
//
//  Created by by.huang on 2020/9/1.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "MCNImageScrollView.h"

@interface MCNImageScrollView()<UIScrollViewDelegate>

@property(copy, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UIView *pageView;
@property(strong, nonatomic)UILabel *pageLabel;

@end

@implementation MCNImageScrollView{
    int current;
}

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
}


-(void)initImages{
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _scrollView.frame.size.height)];
    firstImageView.layer.masksToBounds = YES;
    firstImageView.layer.cornerRadius = 4;
    firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:_datas.lastObject]];
    [_scrollView addSubview:firstImageView];
    
    for (NSInteger index = 0; index < _datas.count; index ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((index + 1) * ScreenWidth, 0, ScreenWidth, ScreenWidth)];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 4;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:_datas[index]]];
        [_scrollView addSubview:imageView];
        _scrollView.contentSize = CGSizeMake((index + 2) * _scrollView.bounds.size.width, 0);
    }
    
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_datas.count + 1) * ScreenWidth, 0, ScreenWidth, ScreenWidth)];
    lastImageView.layer.masksToBounds = YES;
    lastImageView.contentMode = UIViewContentModeScaleAspectFill;
    lastImageView.layer.cornerRadius = 4;
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:_datas.firstObject]];
    [_scrollView addSubview:lastImageView];
    
    _scrollView.contentSize = CGSizeMake((_datas.count + 2) * _scrollView.bounds.size.width, 0);
    _scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
}

-(void)addPageView{
    UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(55), STHeight(340), STWidth(40), STHeight(20))];
    pageView.backgroundColor = [c10 colorWithAlphaComponent:0.4f];
    pageView.layer.masksToBounds = YES;
    pageView.layer.cornerRadius = STHeight(10);
    [self addSubview:pageView];
    
    _pageLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:IS_NS_COLLECTION_EMPTY(_datas) ? @"0/0" : [NSString stringWithFormat:@"1/%ld",_datas.count] textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    _pageLabel.frame = CGRectMake(0, 0, STWidth(40), STHeight(20));
    [pageView addSubview:_pageLabel];
    
    [self changeTextColor];
}


-(void)changeTextColor{
    NSRange range = [_pageLabel.text rangeOfString:@"/" options:NSBackwardsSearch];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:_pageLabel.text];
    NSRange range1= NSMakeRange(0, range.location);
    [hintString addAttribute:NSForegroundColorAttributeName value:cwhite range:range1];
    
    NSRange range2= NSMakeRange(range.location, _pageLabel.text.length - range.location);
    [hintString addAttribute:NSForegroundColorAttributeName value:c11 range:range2];
    _pageLabel.attributedText=hintString;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_scrollView.contentOffset.x == 0) {
        _scrollView.contentOffset = CGPointMake(_datas.count * ScreenWidth, 0);
        _pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",_datas.count,_datas.count];
    } else if (_scrollView.contentOffset.x == (_datas.count + 1)* ScreenWidth) {
        _scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
        _pageLabel.text = [NSString stringWithFormat:@"1/%ld",_datas.count];
    } else {
        _pageLabel.text = [NSString stringWithFormat:@"%d/%ld",(int)(scrollView.contentOffset.x / ScreenWidth),_datas.count];
    }
    [self changeTextColor];
}


-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.clipsToBounds = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;;
}


-(void)updateDatas:(NSMutableArray *)datas{
    _datas = datas;
    [self scrollView];
    [self initImages];
    [self addPageView];
}

@end

