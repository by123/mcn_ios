//
//  MCNAdScrollView.m
//  mcn
//
//  Created by by.huang on 2020/8/18.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "MCNAdScrollView.h"


#define AD_WIDTH STWidth(345)
#define AD_HEIGHT STHeight(120)

@interface MCNAdScrollView()<UIScrollViewDelegate>

@property(copy, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UIPageControl *pageControl;
@property(assign, nonatomic)Boolean needLoad;
@property(assign, nonatomic)Boolean isAuto;
@property(assign, nonatomic)Boolean isPause;

@end

@implementation MCNAdScrollView{
    int current;
}

-(instancetype)initWithImages:(NSMutableArray *)datas needLoad:(Boolean)needLoad isAuto:(Boolean)isAuto{
    if(self == [super init]){
        _datas = datas;
        _needLoad = needLoad;
        _isAuto = isAuto;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake((ScreenWidth - AD_WIDTH)/2, 0, AD_WIDTH, AD_HEIGHT + STHeight(20));
    [self scrollView];
    [self pageControl];
    [self initImages];
    if(_isAuto){
        [self autoScroll];
    }
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onViewClick)]];
}

-(void)autoScroll{
    if(!_isPause){
        if(current  + 1 >= _datas.count){
            current = 0;
        }else{
            current ++;
        }
        [self performSelector:@selector(onAutoScroll) withObject:nil afterDelay:5.0f];
    }else{
        //如果不操作，10秒后重新启动自动翻页
        WS(weakSelf)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.isPause = NO;
            [weakSelf autoScroll];
        });
    }
}

-(void)onAutoScroll{
    WS(weakSelf)
    [UIView animateWithDuration:0.3f animations:^{
        if (self->current == 0) {
            weakSelf.scrollView.contentOffset = CGPointMake(weakSelf.datas.count * AD_WIDTH, 0);
            weakSelf.pageControl.currentPage = weakSelf.datas.count;
        } else if (self->current == (weakSelf.datas.count + 1)* AD_WIDTH) {
            weakSelf.scrollView.contentOffset = CGPointMake(AD_WIDTH, 0);
            weakSelf.pageControl.currentPage = 0;
        } else {
            weakSelf.scrollView.contentOffset = CGPointMake(AD_WIDTH * self->current, 0);
            weakSelf.pageControl.currentPage = weakSelf.scrollView.contentOffset.x / AD_WIDTH - 1;
        }
    }];
    [self autoScroll];
}

-(void)initImages{
    /// 在UIScrollView的最前面添加一张图片
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AD_WIDTH, _scrollView.frame.size.height)];
    /// 图片名是最后一张图片
    firstImageView.layer.masksToBounds = YES;
    firstImageView.layer.cornerRadius = 4;
    firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    BannerModel *model = _datas.lastObject;
    if(_needLoad){
        [firstImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    }else{
        firstImageView.image = [UIImage imageNamed:model.picUrl];
    }
    [_scrollView addSubview:firstImageView];
    
    /// 添加图片
    for (NSInteger index = 0; index < _datas.count; index ++) {
        /// UIScrollView上的每一张图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((index + 1) * AD_WIDTH, 0, AD_WIDTH, _scrollView.frame.size.height)];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 4;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        BannerModel *model = _datas[index];
        if(_needLoad){
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
        }else{
            imageView.image = [UIImage imageNamed:model.picUrl];
        }
        [_scrollView addSubview:imageView];
        _scrollView.contentSize = CGSizeMake((index + 2) * _scrollView.bounds.size.width, 0);
    }
    
    
    /// 在UIScrollView的最后面添加一张图片
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_datas.count + 1) * AD_WIDTH, 0, AD_WIDTH, _scrollView.frame.size.height)];
    lastImageView.layer.masksToBounds = YES;
    lastImageView.contentMode = UIViewContentModeScaleAspectFill;
    lastImageView.layer.cornerRadius = 4;
    /// 图片名是第一张图片
    BannerModel *firstModel = _datas.firstObject;
    if(_needLoad){
        [lastImageView sd_setImageWithURL:[NSURL URLWithString:firstModel.picUrl]];
    }else{
        lastImageView.image = [UIImage imageNamed:firstModel.picUrl];
    }
    [_scrollView addSubview:lastImageView];
    
    /// 设置UIScrollView的偏移量
    _scrollView.contentSize = CGSizeMake((_datas.count + 2) * _scrollView.bounds.size.width, 0);
    
    /// 设置UIScrollView的起始偏移距离（将第一张图片跳过）
    _scrollView.contentOffset = CGPointMake(AD_WIDTH, 0);
    
    /// 图片总数
    _pageControl.numberOfPages = _datas.count;
    _pageControl.currentPage = 0;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _isPause = YES;
    /// 当UIScrollView滑动到第一位停止时，将UIScrollView的偏移位置改变
    if (_scrollView.contentOffset.x == 0) {
        _scrollView.contentOffset = CGPointMake(_datas.count * AD_WIDTH, 0);
        _pageControl.currentPage = _datas.count;
        /// 当UIScrollView滑动到最后一位停止时，将UIScrollView的偏移位置改变
    } else if (_scrollView.contentOffset.x == (_datas.count + 1)* AD_WIDTH) {
        _scrollView.contentOffset = CGPointMake(AD_WIDTH, 0);
        _pageControl.currentPage = 0;
    } else {
        _pageControl.currentPage = scrollView.contentOffset.x / AD_WIDTH - 1;
    }
    if(_delegate){
        [STLog print:[NSString stringWithFormat:@"%f",_scrollView.contentOffset.x]];
        [_delegate onMCNAdScrollViewDidChange:self position:_pageControl.currentPage];
    }
}


-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((ScreenWidth - AD_WIDTH )/2, 0, AD_WIDTH, AD_HEIGHT)];
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

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(AD_WIDTH - _datas.count * STWidth(15), AD_HEIGHT, _datas.count * STWidth(15), STHeight(20))];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = c03;
        _pageControl.currentPageIndicatorTintColor = c41;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

-(void)onViewClick{
    if(_delegate){
        [_delegate onMCNItemClick:current];
    }
}

@end
