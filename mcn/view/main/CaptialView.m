//
//  CaptialView.m
//  mcn
//
//  Created by by.huang on 2020/8/18.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "CaptialView.h"
#import "STPageView.h"
#import "CapitalListView.h"
#import "CapitalViewModel.h"
#import "CapitalMcnView.h"
#import "CapitalMerchantView.h"
#import "AccountManager.h"
#import "TouchScrollView.h"

@interface CaptialView()<STPageViewDelegate,CapitalViewDelegate,CapitalMcnViewDelegate,CapitalMerchantViewDelegate,TouchScrollViewDelegate>

@property(strong, nonatomic)MainViewModel *mainVM;
@property(strong, nonatomic)UIView *cardView;
@property(strong, nonatomic)STPageView *pageView;
@property(strong, nonatomic)CapitalViewModel *capitalVM;
@property(strong, nonatomic)TouchScrollView *scrollView;
@property(strong, nonatomic)CapitalMcnView *mcnView;
@property(strong, nonatomic)CapitalMerchantView *merchantView;
@property(strong, nonatomic)UIView *cardTitleView;
@property(strong, nonatomic)NSMutableArray *listViews;
@property(assign, nonatomic)CGFloat dynamicHeight;

@end

@implementation CaptialView

-(instancetype)initWithViewModel:(MainViewModel *)mainVM{
    if(self == [super init]){
        _mainVM = mainVM;
        [self initView];
    }
    return self;
}

-(void)initView{
    _capitalVM = [[CapitalViewModel alloc]init];
    _capitalVM.current = 0;
    _capitalVM.delegate = self;
    
    [self initTopView];
    [self initCardView];
    
    [_capitalVM requestCapital];
}



#pragma mark 账户余额部分
-(void)initTopView{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    CGFloat homeHeight = [self getHomeHeight];
    
    _scrollView = [[TouchScrollView alloc]initWithParentView:self delegate:self];
    [_scrollView enableHeader];
    [_scrollView enableFooter];
    [self addSubview:_scrollView];
    if(userModel.roleType == RoleType_Merchant){
        _scrollView.frame = CGRectMake(0, STHeight(83), ScreenWidth, ScreenHeight - homeHeight - STHeight(62) - STHeight(83));
        
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(83))];
        titleView.backgroundColor = cwhite;
        [self addSubview:titleView];
        
        UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(83))/2, STHeight(45), STWidth(83), STHeight(28))];
        titleImageView.image = [UIImage imageNamed:IMAGE_CAPITAL_TITLE];
        titleImageView.contentMode = UIViewContentModeScaleAspectFill;
        [titleView addSubview:titleImageView];
        
        _merchantView = [[CapitalMerchantView alloc]init];
        _merchantView.delegate = self;
        _merchantView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(310));
        [_scrollView addSubview:_merchantView];
        
    }else{
        
        _scrollView.frame = CGRectMake(0, STHeight(110), ScreenWidth, ScreenHeight - homeHeight - STHeight(62) - STHeight(110));
        
        UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(25)] text:@"资金" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
        CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(25) fontName:FONT_SEMIBOLD];
        titleLabel.frame = CGRectMake(STWidth(15), STHeight(59), titleSize.width, STHeight(36));
        [self addSubview:titleLabel];
        
        _mcnView = [[CapitalMcnView alloc]init];
        _mcnView.delegate = self;
        _mcnView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(260));
        [_scrollView addSubview:_mcnView];
    }
}


-(void)onCapitalMcnViewWithdrawBtnClick{
    if(_capitalVM.model.canWithdrawNum > 0){
        [_mainVM goWithdrawPage];
    }else{
        [LCProgressHUD showMessage:@"暂无可提现金额"];
    }
}

-(void)onCapitalMerchantViewWithdrawBtnClick{
    if(_capitalVM.model.canWithdrawNum > 0){
        [_mainVM goWithdrawPage];
    }else{
        [LCProgressHUD showMessage:@"暂无可提现金额"];
    }
}

-(void)onCapitalMcnViewStatisticsBtnClick:(StaticticsType)type{
    [_mainVM goStaticticsPage:type];
}

-(void)onCapitalMerchantViewStatisticsBtnClick:(StaticticsType)type{
    [_mainVM goStaticticsPage:type];
}





#pragma mark 收支明细部分
-(void)initCardView{
    
    CGFloat homeHeight = [self getHomeHeight];
    CGFloat cardTop = [self getCardViewTop];
    
    _cardView = [[UIView alloc]initWithFrame:CGRectMake(0, cardTop , ScreenWidth, ScreenHeight - STHeight(62) - cardTop - homeHeight)];
    _cardView.backgroundColor = cwhite;
    //    _cardView.layer.cornerRadius = 20;
    _cardView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _cardView.layer.shadowOffset = CGSizeMake(0,2);
    _cardView.layer.shadowOpacity = 1;
    _cardView.layer.shadowRadius = 10;
    [_scrollView addSubview:_cardView];
    
    
    //
    _dynamicHeight = _cardView.size.height - STHeight(88);
    _listViews = [[NSMutableArray alloc]init];
    
    CapitalListView *view = [[CapitalListView alloc]initWithType:-1 height:_dynamicHeight view:self mainVm:_mainVM];
    [_listViews addObject:view];
    [view refreshNew];
    
    CapitalListView *view1 = [[CapitalListView alloc]initWithType:0 height:_dynamicHeight view:self mainVm:_mainVM];
    [_listViews addObject:view1];
    
    CapitalListView *view2 = [[CapitalListView alloc]initWithType:1 height:_dynamicHeight view:self mainVm:_mainVM];
    [_listViews addObject:view2];
    
    
    NSArray *titles = @[@"全部",@"收入",@"支出"];
    
    _pageView = [[STPageView alloc]initWithFrame:CGRectMake(0, STHeight(50), ScreenWidth, _cardView.size.height - STHeight(50)) views:_listViews titles:titles perLine:0.3f perWidth:STWidth(50)];
    _pageView.delegate = self;
    [_cardView addSubview:_pageView];
    
    
    //
    _cardTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(60))];
    _cardTitleView.backgroundColor = cwhite;
    _cardTitleView.layer.cornerRadius = 20;
    [_cardView addSubview:_cardTitleView];
    
    UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(25), STWidth(4), STHeight(16))];
    tagView.backgroundColor = c16;
    [_cardTitleView addSubview:tagView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:@"收支明细" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(25), STHeight(20), titleSize.width, STHeight(25));
    [_cardTitleView addSubview:titleLabel];
    
}


-(void)updateInfoView{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.roleType == RoleType_Merchant){
        [_merchantView updateView:_capitalVM.model];
    }else{
        [_mcnView updateView:_capitalVM.model];
    }
    CapitalListView *view =  [_listViews objectAtIndex:_capitalVM.current];
    [view updateTotal:_capitalVM.model];
}

-(void)updateListView{
    CapitalListView *view = [_listViews objectAtIndex:_capitalVM.current];
    _cardView.frame = CGRectMake(0, [self getCardViewTop] ,ScreenWidth,STHeight(150) + [view getListViewHeight]);
    [_pageView changeFrame:STHeight(100) + [view getListViewHeight] offsetY:0];
    [_scrollView setContentSize:CGSizeMake(ScreenWidth, [self getCardViewTop]  + [view getListViewHeight] + STHeight(150))];
    
}



-(void)onPageViewSelect:(NSInteger)position view:(id)view{
    _capitalVM.current = position;
    CapitalListView *listView = [_listViews objectAtIndex:_capitalVM.current];
    [_capitalVM requestCapital];
    [listView refreshNew];
}


-(void)onScrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = self.scrollView.mj_offsetY;
    CGFloat cardViewTop = [self getCardViewTop];
    if(offsetY > cardViewTop){
        [_pageView fastenTopView:offsetY - cardViewTop];
        _cardTitleView.frame = CGRectMake(0, offsetY - cardViewTop, ScreenWidth, STHeight(60));
    }else{
        [_pageView fastenTopView:0];
        _cardTitleView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(60));
        
    }
}



#pragma mark 网络数据

-(void)refreshNew{
    [_capitalVM requestCapital];
    if(!IS_NS_COLLECTION_EMPTY(_listViews)){
        CapitalListView *view =  [_listViews objectAtIndex:_capitalVM.current];
        [view refreshNew];
    }
}

-(void)uploadMore{
    if(!IS_NS_COLLECTION_EMPTY(_listViews)){
        CapitalListView *view =  [_listViews objectAtIndex:_capitalVM.current];
        [view uploadMore];
    }
}

-(void)onRequestBegin{}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_BALANCE]){
        [self updateInfoView];
    }else if([respondModel.requestUrl isEqualToString:URL_CAPITAL_LIST]){
        [_scrollView.mj_header endRefreshing];
        [_scrollView.mj_footer endRefreshing];
        [self updateListView];
    }
    
}

-(void)onRequestFail:(NSString *)msg{}


-(void)onRequestNoDatas:(Boolean)isFirst{
    if(isFirst){
        NSLog(@"无数据页面");
        [_scrollView.mj_header endRefreshing];
        [_scrollView.mj_footer endRefreshing];
        
    }else{
        [_scrollView.mj_header endRefreshing];
        [_scrollView.mj_footer endRefreshingWithNoMoreData];
    }
    [self updateInfoView];
    [self updateListView];
}



#pragma mark 高度获取
-(CGFloat)getCardViewTop{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    CGFloat cardTop = STHeight(229);
    if(userModel.roleType == RoleType_Merchant){
        cardTop = STHeight(266);
    }
    return cardTop;;
}

-(CGFloat)getHomeHeight{
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    return homeHeight;;
}


@end
