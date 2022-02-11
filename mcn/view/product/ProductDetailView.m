//
//  ProductDetailView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "ProductDetailView.h"
#import "MCNImageScrollView.h"
#import "STPageTopView.h"
#import "STNavigationView.h"
#import "ProductImageView.h"
#import "ProductMerchantView.h"
#import "AccountManager.h"

@interface ProductDetailView()<UIScrollViewDelegate,STNavigationViewDelegate,STPageTopViewDelegate,ProductImageViewDelegate,ProductMerchantViewDelegate>

@property(strong, nonatomic)STNavigationView *navigationView;
@property(strong, nonatomic)UIView *statuBarView;
@property(strong, nonatomic)ProductDetailViewModel *mViewModel;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UIView *topView;
@property(strong, nonatomic)MCNImageScrollView *adView;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *firstTitleLabel;
@property(strong, nonatomic)UILabel *firstLabel;
@property(strong, nonatomic)UILabel *reTitleLabel;
@property(strong, nonatomic)UILabel *reLabel;
@property(strong, nonatomic)UIButton *msgBtn;
@property(strong, nonatomic)UIButton *addBtn;
@property(strong, nonatomic)UIButton *partnerBtn;
@property(strong, nonatomic)ProductImageView *productImageView;
@property(strong, nonatomic)ProductMerchantView *merchantView;
@property(strong, nonatomic)STPageTopView *pageTopView;
@property(assign, nonatomic)int index;

@end

@implementation ProductDetailView{
    CGFloat dynamicHeight;
    CGFloat imgHeight;
    CGFloat addHeight;
    CGFloat productImageY;
    CGFloat merchantY;
}

-(instancetype)initWithViewModel:(ProductDetailViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        addHeight = ScreenWidth;
        [self initView];
    }
    return self;
}

-(void)initView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self addSubview:_scrollView];
    
    _statuBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, StatuNavHeight)];
    _statuBarView.backgroundColor = cwhite;
    [self addSubview:_statuBarView];
    
    _navigationView = [[STNavigationView alloc]initWithTitle:@"产品详情" needBack:YES];
    _navigationView.delegate = self;
    [self addSubview:_navigationView];
    
    _pageTopView = [[STPageTopView alloc]initWithTitles:@[@"产品信息",@"商家信息"] middleWidth:STWidth(40) perWidth:STWidth(62)];
    _pageTopView.backgroundColor = cwhite;
    _pageTopView.delegate = self;
    _pageTopView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, STHeight(50));
    [self addSubview:_pageTopView];
    
    _navigationView.alpha = 0;
    _statuBarView.alpha = 0;
    _pageTopView.alpha = 0;
    
    [self initTopView];
    [self initBody];
    [self initBottomView];
}

-(void)initTopView{
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = cwhite;
    [_scrollView addSubview:_topView];
    
    _adView = [[MCNImageScrollView alloc]init];
    _adView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
    [_topView addSubview:_adView];
    
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:IMAGE_PRODUCT_BACK] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(STWidth(15), STHeight(60), STHeight(30), STHeight(30));
    [backBtn addTarget:self action:@selector(onBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:backBtn];
    
    _priceLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(20)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    [_topView addSubview:_priceLabel];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [_topView addSubview:_nameLabel];
    
    
    _firstTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(7)] text:@"首" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c20 multiLine:NO];
    _firstTitleLabel.layer.masksToBounds = YES;
    _firstTitleLabel.layer.cornerRadius = 2;
    [_topView addSubview:_firstTitleLabel];
    
    _firstLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [_topView addSubview:_firstLabel];
    
    _reTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(7)] text:@"复" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c10 multiLine:NO];
    _reTitleLabel.layer.masksToBounds = YES;
    _reTitleLabel.layer.cornerRadius = 2;
    [_topView addSubview:_reTitleLabel];
    
    _reLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [_topView addSubview:_reLabel];
    
}

-(void)initBody{
    _productImageView = [[ProductImageView alloc]init];
    _productImageView.delegate = self;
    [_scrollView addSubview:_productImageView];
    
    _merchantView = [[ProductMerchantView alloc]init];
    _merchantView.delegate = self;
    [_scrollView addSubview:_merchantView];
}

-(void)initBottomView{
    
    CGFloat homeHight = 0;
    if (@available(iOS 11.0, *)) {
           homeHight = HomeIndicatorHeight;
       } else {
           homeHight = 0;
       }
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, ScreenHeight - STHeight(80) - homeHight, ScreenWidth, STHeight(80)+ homeHight);
    bottomView.layer.backgroundColor = cwhite.CGColor;
    bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0,2);
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowRadius = 10;
    [self addSubview:bottomView];
    
    _msgBtn = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(15),STHeight(15),STWidth(35),STHeight(50))];
    [_msgBtn setTitle:@"消息" forState:UIControlStateNormal];
    [_msgBtn setTitleColor:c10 forState:UIControlStateNormal];
    _msgBtn.titleLabel.font = [UIFont systemFontOfSize:STFont(10)];
    [_msgBtn setImage:[UIImage imageNamed:IMAGE_PRODUCT_MSG] forState:UIControlStateNormal];
    _msgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_msgBtn setTitleEdgeInsets:UIEdgeInsetsMake(_msgBtn.imageView.frame.size.height+STHeight(6) ,-_msgBtn.imageView.frame.size.width, 0,0)];
    [_msgBtn setImageEdgeInsets:UIEdgeInsetsMake(-STHeight(8), 0,0, -_msgBtn.titleLabel.bounds.size.width)];
    [_msgBtn addTarget:self action:@selector(onMsgBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_msgBtn];
    
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.authenticateState == AuthenticateState_Success){
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(62),STHeight(15),STWidth(52),STHeight(50))];
        [_addBtn setTitle:@"加入选品站" forState:UIControlStateNormal];
        [_addBtn setTitleColor:c10 forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:STFont(10)];
        [_addBtn setImage:[UIImage imageNamed:IMAGE_PRODUCT_ADD] forState:UIControlStateNormal];
        _addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_addBtn setTitleEdgeInsets:UIEdgeInsetsMake(_addBtn.imageView.frame.size.height+STHeight(6) ,-_addBtn.imageView.frame.size.width, 0,0)];
        [_addBtn setImageEdgeInsets:UIEdgeInsetsMake(-STHeight(10), STWidth(9),0, -_addBtn.titleLabel.bounds.size.width)];
        [_addBtn addTarget:self action:@selector(onAddBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:_addBtn];
    }
    
    
    UIView *view = [[UIView alloc]init];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(STWidth(170), STHeight(15), STWidth(190), STHeight(50));
    gl.startPoint = CGPointMake(1, 0.56);
    gl.endPoint = CGPointMake(0, 0.56);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:123/255.0 blue:115/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:254/255.0 green:49/255.0 blue:53/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 4;
    [view.layer addSublayer:gl];
    [bottomView addSubview:view];
    
    _partnerBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"立即合作" textColor:cwhite backgroundColor:nil corner:4 borderWidth:0 borderColor:nil];
    _partnerBtn.frame = CGRectMake(STWidth(170), STHeight(15), STWidth(190), STHeight(50));
    [_partnerBtn addTarget:self action:@selector(onParterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_partnerBtn];
}


-(void)onMCNItemClick:(NSInteger)position{}

-(void)onMCNAdScrollViewDidChange:(id)view position:(NSInteger)position{}

-(void)updateView{
    
    ProductModel *model = _mViewModel.model;
    
    [_adView updateDatas:model.picUrlList];
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.sellPrice/100];
    CGSize priceSize = [_priceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(20) fontName:FONT_SEMIBOLD];
    _priceLabel.frame = CGRectMake(STWidth(15), addHeight + STHeight(15), priceSize.width, STHeight(35));
    
    addHeight += STHeight(50);
    
    _nameLabel.text = [NSString stringWithFormat:@"%@%@",model.spuName,[ProductModel getAttributeValue:model.attribute]];
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:STWidth(345) font:STFont(15) fontName:FONT_SEMIBOLD];
    _nameLabel.frame = CGRectMake(STWidth(15), addHeight + STHeight(5), STWidth(345), nameSize.height);
    
    addHeight += (STHeight(5) + nameSize.height);
    
    _firstTitleLabel.frame = CGRectMake(STWidth(15), addHeight + STHeight(11), STHeight(12), STHeight(12));
    
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.authenticateState == AuthenticateState_Success){
        _firstLabel.text = [NSString stringWithFormat:@"首单分成:¥%.2f",model.firstOrderProfit / 100];
        _reLabel.text = [NSString stringWithFormat:@"复购分成:¥%.2f",model.repeatProfit / 100];
    }else{
        _firstLabel.text = @"首单分成：*****";
        _reLabel.text = @"复购分成：*****";
    }
    CGSize firstSize = [_firstLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _firstLabel.frame = CGRectMake(STWidth(20) + STHeight(12), addHeight + STHeight(8), firstSize.width, STHeight(17));
    
    _reTitleLabel.frame = CGRectMake(STWidth(40) + STHeight(12) + firstSize.width, addHeight + STHeight(11), STHeight(12), STHeight(12));
    
    CGSize reSize = [_reLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _reLabel.frame = CGRectMake(STWidth(45) + STHeight(24) + firstSize.width, addHeight + STHeight(8), reSize.width, STHeight(17));
    
    
    addHeight += STHeight(45);
    
    
    _topView.frame = CGRectMake(0, 0, ScreenWidth, addHeight);
    dynamicHeight = addHeight + STHeight(15) - StatuNavHeight - STHeight(50);
    
    [_productImageView updateView:model.goodsDetailList];
    
    
}

-(void)onProductImageLoaded:(CGFloat)height{
    productImageY = addHeight + STHeight(15) - StatuNavHeight - STHeight(50);
    _productImageView.frame = CGRectMake(0, addHeight + STHeight(15), ScreenWidth, height);
    addHeight += (STHeight(15) + height);
    [_merchantView updateView:_mViewModel.model];
}

-(void)onProductMerchantViewLoaded:(CGFloat)height{
     merchantY =  addHeight + STHeight(15) - StatuNavHeight - STHeight(50);
    _merchantView.frame = CGRectMake(0, addHeight + STHeight(15), ScreenWidth, height);
    CGFloat homeHight = 0;
    if (@available(iOS 11.0, *)) {
           homeHight = HomeIndicatorHeight;
       } else {
           homeHight = 0;
       }
    [_scrollView setContentSize:CGSizeMake(ScreenWidth, addHeight + height +  STHeight(100) + homeHight)];
}


-(void)onPageTopViewItemClick:(NSInteger)position{
    if(position == 0){
        [_scrollView setContentOffset:CGPointMake(0, productImageY)];
    }else if(position == 1){
        [_scrollView setContentOffset:CGPointMake(0, merchantY)];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if(y > dynamicHeight){
        _navigationView.alpha = 1;
        _statuBarView.alpha = 1;
        _pageTopView.alpha = 1;
//        if(y >= merchantY){
//            [_pageTopView changeItem:1];
//        }else{
//            [_pageTopView changeItem:0];
//        }
    }else{
        CGFloat alpha = y / dynamicHeight;
        _navigationView.alpha = alpha;
        _statuBarView.alpha = alpha;
        _pageTopView.alpha = alpha;

    }
}

//出现navigationbar返回
-(void)OnBackBtnClicked{
    [_mViewModel goBack];
}

-(void)onRightBtnClicked{}

//未出现navigationbar返回
-(void)onBackBtnClick{
    [_mViewModel goBack];
}

-(void)onMsgBtnClicked{
    [_mViewModel goMessageTab];
}

//加入选品站
-(void)onAddBtnClicked{
    [_mViewModel addProductCart];
}

-(void)onParterBtnClick{
    [_mViewModel goCooperationPage];
}

@end

