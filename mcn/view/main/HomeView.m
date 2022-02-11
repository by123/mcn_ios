//
//  HomeView.m
//  mcn
//
//  Created by by.huang on 2020/8/18.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "HomeView.h"
#import "MCNAdScrollView.h"
#import "STPageView.h"
#import "HomeListView.h"
#import "HomeViewModel.h"

@interface HomeView()<MCNAdScrollViewDelegate,STPageViewDelegate,HomeListViewDelegate,HomeViewDelegate,UITextFieldDelegate>

@property(strong, nonatomic)MainViewModel *mainVM;
@property(strong, nonatomic)MCNAdScrollView *adView;
@property(strong, nonatomic)UITextField *searchTF;
@property(strong, nonatomic)STPageView *pageView;
@property(strong, nonatomic)HomeViewModel *homeVM;
@property(assign, nonatomic)NSInteger adPosition;

@end

@implementation HomeView

-(instancetype)initWithViewModel:(MainViewModel *)mainVM{
    if(self == [super init]){
        _mainVM = mainVM;
        _homeVM = [[HomeViewModel alloc]init];
        _homeVM.delegate = self;
        [self initView];
        [_homeVM requestBanner];
        [_homeVM requestGoodsCategory];
    }
    return self;
}

-(void)initView{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(240))];
    topView.backgroundColor = cwhite;
    [self addSubview:topView];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(157))];
    bgImageView.image = [UIImage imageNamed:IMAGE_HOME_BG];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImageView];
    
    _searchTF = [[UITextField alloc]initWithFont:STFont(14) textColor:c10 backgroundColor:cwhite corner:4 borderWidth:0 borderColor:nil padding:STWidth(40)];
    [_searchTF setPlaceholder:@"搜索你想要的" color:c05 fontSize:STFont(14)];
    _searchTF.frame = CGRectMake(STWidth(15), STHeight(50), STWidth(345), STHeight(40));
    _searchTF.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _searchTF.layer.shadowOffset = CGSizeMake(0,2);
    _searchTF.layer.shadowOpacity = 1;
    _searchTF.delegate = self;
    _searchTF.layer.shadowRadius = 10;
    [self addSubview:_searchTF];
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(10), STHeight(20), STHeight(20))];
    searchImageView.image = [UIImage imageNamed:IMAGE_SEARCH];
    searchImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_searchTF addSubview:searchImageView];
    
    
    NSArray *titles = @[];
    
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    
    NSMutableArray *views = [[NSMutableArray alloc]init];
    
    _pageView = [[STPageView alloc]initWithFrame:CGRectMake(0, STHeight(240), ScreenWidth, ScreenHeight - STHeight(240) - STHeight(62) - homeHeight) views:views titles:titles perLine:0.3f perWidth:STWidth(70)];
    _pageView.delegate = self;
    [self addSubview:_pageView];
    
}

-(void)onMCNAdScrollViewDidChange:(id)view position:(NSInteger)position{
    _adPosition = position;
    [self resign];
}

-(void)onMCNItemClick:(NSInteger)position{
    if(!IS_NS_COLLECTION_EMPTY(_homeVM.bannerDatas)){
        BannerModel *model = [_homeVM.bannerDatas objectAtIndex:position];
        [_mainVM goProductPage:model.skuId];
    }
}

-(void)onPageViewSelect:(NSInteger)position view:(id)view{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resign];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self resign];
}


-(void)resign{
    if([_searchTF isFirstResponder]){
        [_searchTF resignFirstResponder];
    }
}


-(void)onRequestBegin{}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_GOODS_CATEGORY]){
        if(!IS_NS_COLLECTION_EMPTY(_homeVM.categoryDatas)){
            NSMutableArray *titles = [[NSMutableArray alloc]init];
            NSMutableArray *views = [[NSMutableArray alloc]init];
            [titles addObject:@"全部"];
            HomeListView *allView = [self addListViews:nil];
            [views addObject:allView];
            
            for(CategoryModel *model in _homeVM.categoryDatas){
                [titles addObject:model.goodsClass];
                HomeListView *view = [self addListViews:model.goodsClass];
                [views addObject:view];
            }
            CGFloat homeHeight = 0;
            if (@available(iOS 11.0, *)) {
                homeHeight = HomeIndicatorHeight;
            } else {
                homeHeight = 0;
            }
            
            [_pageView updateTitles:titles views:views];
            [_pageView showShadow];
        }
    }
}

-(HomeListView *)addListViews:(NSString *)goodClass{
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    HomeListView *view = [[HomeListView alloc]initWithType:goodClass vm:_mainVM];
    view.delegate = self;
    view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - STHeight(240) - STHeight(62) - homeHeight);
    view.backgroundColor = cbg;
    return view;
}

-(void)onRequestFail:(NSString *)msg{}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [_mainVM goHomeSearchPage];
    [textField resignFirstResponder];
}

-(void)onUpdateBanner{
    _adView = [[MCNAdScrollView alloc]initWithImages:_homeVM.bannerDatas needLoad:YES isAuto:YES];
    _adView.frame = CGRectMake(0, STHeight(100), ScreenWidth, STHeight(140));
    _adView.delegate = self;
    _adView.layer.masksToBounds = YES;
    _adView.layer.cornerRadius = 4;
    _adView.clipsToBounds = YES;
    [self addSubview:_adView];
}
@end
