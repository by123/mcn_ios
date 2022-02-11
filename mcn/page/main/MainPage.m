//
//  MainPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "MainPage.h"
#import "MainViewModel.h"
#import "HomeView.h"
#import "CaptialView.h"
#import "ShopView.h"
#import "MsgView.h"
#import "MineView.h"
#import "ShelvesView.h"
#import "AccountManager.h"
#import "SettingPage.h"
#import "PartnerPage.h"
#import "BusinessPage.h"
#import "QulificationsPage.h"
#import "BankPage.h"
#import "AddressPage.h"
#import "WithdrawPage.h"
#import "MsgDetailPage.h"
#import "ProductDetailPage.h"
#import "CooperationPage.h"
#import "STDialog.h"
#import "QulificationsPage.h"
#import "QulificationsEditPage.h"
#import "CelebrityPage.h"
#import "HomeSearchPage.h"
#import "STObserverManager.h"
#import "AddProductPage.h"
#import "CapitalDetailPage.h"
#import "StaticticsPage.h"
#import "WithdrawListPage.h"
#import "PartnerMerchantPage.h"

#define TAB_HEIGHT STHeight(62)

@interface MainPage()<MainViewDelegate,STDialogDelegate,STObserverProtocol>

@property(strong, nonatomic)MainViewModel *mainVM;
@property(copy, nonatomic)NSArray *titles;
@property(copy, nonatomic)NSArray *imgSrcs;
@property(strong, nonatomic)NSMutableArray *menuBtns;
@property(assign, nonatomic)NSInteger current;
@property(strong, nonatomic)HomeView *homeView;
@property(strong, nonatomic)CaptialView *captialView;
@property(strong, nonatomic)ShopView *shopView;
@property(strong, nonatomic)MsgView *msgView;
@property(strong, nonatomic)MineView *mineView;
@property(strong, nonatomic)ShelvesView *shelvesView;
@property(strong, nonatomic)UILabel *shopLabel;
@property(strong, nonatomic)UIView *bottomView;
@property(strong, nonatomic)UIButton *shopBtn;
@property(strong, nonatomic)STDialog *authenticateDialog;
@property(assign, nonatomic)UIStatusBarStyle style;

@end

@implementation MainPage{
    RoleType roleType;
    CGFloat homeHeight;
}

+(void)show:(BaseViewController *)controller{
    MainPage *page = [[MainPage alloc]init];
    BaseNavigationController *navigationController = [[BaseNavigationController alloc]initWithRootViewController:page];
    [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.roleType == RoleType_Merchant){
        _style = UIStatusBarStyleDefault;
    }else{
        _style = UIStatusBarStyleLightContent;
    }
    roleType = userModel.roleType;
    [self initView];
    [self initAuthDialog];
    if(userModel.authenticateState == AuthenticateState_Default){
        _authenticateDialog.hidden = NO;
    }
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_UPDATE_BUSINESS delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_TAB_MSG delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_TAB_UNDERCARRIAGE delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_GO_PARTNER delegate:self];
    
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_UPDATE_BUSINESS];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_TAB_MSG];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_TAB_UNDERCARRIAGE];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_GO_PARTNER];

}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([NOTIFY_UPDATE_BUSINESS isEqualToString:key]){
        [_mainVM loginByToken];
    }else if([NOTIFY_TAB_MSG isEqualToString:key]){
        if(!IS_NS_COLLECTION_EMPTY(_menuBtns)){
            for(UIButton *button in _menuBtns){
                if([MSG_TAB_MSG isEqualToString:button.tag2]){
                    [self onMenuClicked:button];
                    break;
                }
            }
        }
    }else if([NOTIFY_TAB_UNDERCARRIAGE isEqualToString:key]){
        [_shelvesView positionTab:ShelvesType_Undercarriage];
    }else if([NOTIFY_GO_PARTNER isEqualToString:key]){
        [PartnerPage show:self type:PartnerType_All];
    }
}

-(void)initAuthDialog{
    _authenticateDialog = [[STDialog alloc]initWithTitle:@"提醒" content:@"您还未提交资质认证,点击确定提交" subContent:MSG_EMPTY size:CGSizeMake(STWidth(315), STHeight(200))];
    _authenticateDialog.delegate = self;
    _authenticateDialog.hidden = YES;
    [_authenticateDialog showConfirmBtn:YES cancelBtn:YES];
    [_authenticateDialog setConfirmBtnStr:@"确定" cancelStr:@"取消"];
    [self.view addSubview:_authenticateDialog];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenStatuBar];
}


-(void)onConfirmBtnClicked:(id)dialog{
    _authenticateDialog.hidden = YES;
    [QulificationsPage show:self];
}

-(void)onCancelBtnClicked:(id)dialog{
    _authenticateDialog.hidden = YES;
}

-(void)changeStatusBarStyle:(UIStatusBarStyle)style{
    _style = style;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _style;
}

-(void)initView{
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    
    _mainVM = [[MainViewModel alloc]init];
    _mainVM.delegate = self;
    
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    if(model.authenticateState == AuthenticateState_Success){
        if(roleType == RoleType_Merchant){
            [self.view addSubview:[self captialView]];
            [self.view addSubview:[self shelvesView]];
            _captialView.hidden = NO;
        }else{
            [self.view addSubview:[self homeView]];
            [self.view addSubview:[self captialView]];
            [self.view addSubview:[self shopView]];
            _homeView.hidden = NO;
        }
    }else{
        [self.view addSubview:[self homeView]];
        _homeView.hidden = NO;
    }
    [self.view addSubview:[self msgView]];
    [self.view addSubview:[self mineView]];
    
    [self initBottomView];
}

-(void)initBottomView{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,  ScreenHeight-TAB_HEIGHT-homeHeight, ScreenWidth, TAB_HEIGHT + homeHeight)];
    _bottomView.backgroundColor = cwhite;
    _bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0,2);
    _bottomView.layer.shadowOpacity = 1;
    _bottomView.layer.shadowRadius = 10;
    [self.view addSubview:_bottomView];
    
    _menuBtns = [[NSMutableArray alloc]init];
    
    _titles = @[MSG_TAB_HOME,MSG_TAB_CAPITAL,MSG_EMPTY,MSG_TAB_MSG,MSG_TAB_MINE];
    _imgSrcs = @[IMAGE_HOME_NORMAL,IMAGE_HOME_PRESSED,
                 IMAGE_CAPITAL_NORMAL,IMAGE_CAPITAL_PRESSED,
                 MSG_EMPTY,MSG_EMPTY,
                 IMAGE_MSG_NORMAL,IMAGE_MSG_PRESSED,
                 IMAGE_MINE_NORMAL,IMAGE_MINE_PRESSED];
    
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    if(model.authenticateState == AuthenticateState_Success){
        if(roleType == RoleType_Merchant){
            _titles = @[MSG_TAB_CAPITAL,MSG_TAB_SHELVES,MSG_TAB_MSG,MSG_TAB_MINE];
            _imgSrcs = @[IMAGE_CAPITAL_NORMAL,IMAGE_CAPITAL_PRESSED,
                         IMAGE_SHELVES,IMAGE_SHELVES_PRESSED,
                         IMAGE_MSG_NORMAL,IMAGE_MSG_PRESSED,
                         IMAGE_MINE_NORMAL,IMAGE_MINE_PRESSED];
        }else{
            //选品站按钮
            _shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(145),ScreenHeight-homeHeight-STHeight(95),STWidth(86) , STHeight(70))];
            _shopBtn.tag = 2;
            _shopBtn.tag2 = MSG_TAB_SHOP;
            [_shopBtn addTarget:self action:@selector(onMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_shopBtn setImage:[UIImage imageNamed:IMAGE_SHOP_PRESSED] forState:UIControlStateNormal];
            [self.view addSubview:_shopBtn];
            
            _shopLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_TAB_SHOP textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
            _shopLabel.frame = CGRectMake(STWidth(145),ScreenHeight-homeHeight-STHeight(23), STWidth(86), STHeight(16));
            [self.view addSubview:_shopLabel];
        }
    }else{
        _titles = @[MSG_TAB_HOME,MSG_TAB_MSG,MSG_TAB_MINE];
        _imgSrcs = @[IMAGE_HOME_NORMAL,IMAGE_HOME_PRESSED,
                     IMAGE_MSG_NORMAL,IMAGE_MSG_PRESSED,
                     IMAGE_MINE_NORMAL,IMAGE_MINE_PRESSED];
    }
    
    
    for(int i = 0 ; i < _titles.count ; i ++){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i * ScreenWidth/_titles.count,0,ScreenWidth/ _titles.count , TAB_HEIGHT)];
        button.tag = i;
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:(i == 0 ? c16 : c10) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:STFont(11)];
        if(i == 0){
            button.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(11)];
            if(!IS_NS_STRING_EMPTY(_imgSrcs[1])){
                [button setImage:[UIImage imageNamed:_imgSrcs[1]] forState:UIControlStateNormal];
            }
        }else{
            button.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(11)];
            if(!IS_NS_STRING_EMPTY(_imgSrcs[i * 2])){
                [button setImage:[UIImage imageNamed:_imgSrcs[i * 2]] forState:UIControlStateNormal];
            }
        }
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height+STHeight(12) ,-button.imageView.frame.size.width, 0.0,0.0)];
        button.tag2 = _titles[i];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-STHeight(14), 0.0,0.0, -button.titleLabel.bounds.size.width)];
        UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
        if(model.authenticateState == AuthenticateState_Success){
            if(roleType == RoleType_Merchant){
                [button addTarget:self action:@selector(onMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                if(i != 2){
                    [button addTarget:self action:@selector(onMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }else{
            [button addTarget:self action:@selector(onMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        [_bottomView addSubview:button];
        [_menuBtns addObject:button];
    }
}

-(void)onMenuClicked:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    if(tag == _current) return;
    if(!IS_NS_COLLECTION_EMPTY(_menuBtns)){
        if(roleType == RoleType_Merchant){
            _captialView.hidden = YES;
            _shelvesView.hidden = YES;
            
            UIButton *selectBtn = (UIButton *)sender;
            selectBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(11)];
            [selectBtn setTitleColor:c16 forState:UIControlStateNormal];
            [selectBtn setImage:[UIImage imageNamed:_imgSrcs[tag * 2 + 1]] forState:UIControlStateNormal];
            
            UIButton *currentBtn = (UIButton *)_menuBtns[_current];
            [currentBtn setTitleColor:c10 forState:UIControlStateNormal];
            currentBtn.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(11)];
            [currentBtn setImage:[UIImage imageNamed:_imgSrcs[_current * 2]] forState:UIControlStateNormal];
        }else{
            UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
            if(model.authenticateState == AuthenticateState_Success){
                if(tag == 2){
                    _shopLabel.textColor = c16;
                    _shopLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(11)];
                }else{
                    _shopLabel.textColor = c10;
                    _shopLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(11)];
                    UIButton *selectBtn = (UIButton *)sender;
                    selectBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(11)];
                    [selectBtn setTitleColor:c16 forState:UIControlStateNormal];
                    [selectBtn setImage:[UIImage imageNamed:_imgSrcs[tag * 2 + 1]] forState:UIControlStateNormal];
                }
            }else{
                UIButton *selectBtn = (UIButton *)sender;
                selectBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(11)];
                [selectBtn setTitleColor:c16 forState:UIControlStateNormal];
                [selectBtn setImage:[UIImage imageNamed:_imgSrcs[tag * 2 + 1]] forState:UIControlStateNormal];
                
            }
            
            UIButton *currentBtn = (UIButton *)_menuBtns[_current];
            [currentBtn setTitleColor:c10 forState:UIControlStateNormal];
            currentBtn.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(11)];
            [currentBtn setImage:[UIImage imageNamed:_imgSrcs[_current * 2]] forState:UIControlStateNormal];
            
            _homeView.hidden = YES;
            _captialView.hidden = YES;
            _shopView.hidden = YES;
        }
        
        _msgView.hidden = YES;
        _mineView.hidden = YES;
        
        NSString *tags = ((UIButton *)sender).tag2;
        if([tags isEqualToString:MSG_TAB_HOME]){
            _homeView.hidden = NO;
            [self changeStatusBarStyle:UIStatusBarStyleLightContent];
        }else if([tags isEqualToString:MSG_TAB_CAPITAL]){
            _captialView.hidden = NO;
            [self changeStatusBarStyle:UIStatusBarStyleDefault];
        }else if([tags isEqualToString:MSG_TAB_SHOP]){
            _shopView.hidden = NO;
            [_shopView refreshNew];
            [self changeStatusBarStyle:UIStatusBarStyleLightContent];
        }else if([tags isEqualToString:MSG_TAB_MSG]){
            _msgView.hidden = NO;
            [_msgView refreshNew];
            [self changeStatusBarStyle:UIStatusBarStyleDefault];
        }else if([tags isEqualToString:MSG_TAB_MINE]){
            _mineView.hidden = NO;
            [self changeStatusBarStyle:UIStatusBarStyleLightContent];
        }else if([tags isEqualToString:MSG_TAB_SHELVES]){
            _shelvesView.hidden = NO;
            [self changeStatusBarStyle:UIStatusBarStyleDefault];
        }
        _current = tag;
    }
}

- (HomeView *)homeView{
    if(_homeView == nil){
        _homeView = [[HomeView alloc]initWithViewModel:_mainVM];
        _homeView.backgroundColor = cwhite;
        if (@available(iOS 11.0, *)) {
            _homeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - HomeIndicatorHeight - TAB_HEIGHT);
        } else {
            _homeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - TAB_HEIGHT);
        }
        _homeView.hidden= YES;
    }
    return _homeView;
}



- (CaptialView *)captialView{
    if(_captialView == nil){
        _captialView = [[CaptialView alloc]initWithViewModel:_mainVM];
        _captialView.backgroundColor = cwhite;
        if (@available(iOS 11.0, *)) {
            _captialView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - HomeIndicatorHeight - TAB_HEIGHT);
        } else {
            _captialView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - TAB_HEIGHT);
        }
        _captialView.hidden = YES;
    }
    return _captialView;
}

-(ShopView *)shopView{
    if(_shopView == nil){
        _shopView = [[ShopView alloc]initWithViewModel:_mainVM];
        _shopView.backgroundColor = cwhite;
        if (@available(iOS 11.0, *)) {
            _shopView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - HomeIndicatorHeight - TAB_HEIGHT);
        } else {
            _shopView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - TAB_HEIGHT);
        }
        _shopView.hidden = YES;
    }
    return _shopView;
}

-(MsgView *)msgView{
    if(_msgView == nil){
        _msgView = [[MsgView alloc]initWithViewModel:_mainVM];
        _msgView.backgroundColor = cwhite;
        if (@available(iOS 11.0, *)) {
            _msgView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - HomeIndicatorHeight - TAB_HEIGHT);
        } else {
            _msgView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - TAB_HEIGHT);
        }
        _msgView.hidden = YES;
    }
    return _msgView;
}

- (MineView *)mineView{
    if(_mineView == nil){
        _mineView = [[MineView alloc]initWithViewModel:_mainVM];
        _mineView.backgroundColor = cwhite;
        if (@available(iOS 11.0, *)) {
            _mineView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - HomeIndicatorHeight - TAB_HEIGHT);
        } else {
            _mineView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - TAB_HEIGHT);
        }
        _mineView.hidden = YES;
    }
    return _mineView;
}

-(ShelvesView *)shelvesView{
    if(_shelvesView == nil){
        _shelvesView = [[ShelvesView alloc]initWithViewModel:_mainVM];
        _shelvesView.backgroundColor = cwhite;
        if (@available(iOS 11.0, *)) {
            _shelvesView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - HomeIndicatorHeight - TAB_HEIGHT);
        } else {
            _shelvesView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - TAB_HEIGHT);
        }
        _shelvesView.hidden= YES;
    }
    return _shelvesView;
}


-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_LOGIN_BY_TOKEN]){
        [_mineView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}



//跳转
-(void)onGoSettingPage{
    [SettingPage show:self];
}

-(void)onGoPartnerPage:(PartnerType)type{
    [PartnerPage show:self type:type];
}

-(void)onGoBusinessPage:(NSString *)mchId isEdit:(Boolean)isEdit{
    [BusinessPage show:self mchId:mchId isEdit:isEdit];
}

-(void)onGoPartnerMerchantPage:(NSString *)mchId{
    [PartnerMerchantPage show:self mchId:mchId];
}

-(void)onGoCelebrityPage{
    [CelebrityPage show:self];
}

-(void)onGoQualificationsPage{
    [QulificationsPage show:self];
}

-(void)onGoQualificationsEditPage:(QulificationsModel *)qulificationModel{
    [QulificationsEditPage show:self roleType:qulificationModel.mchType model:qulificationModel isEdit:YES];
}

-(void)onGoBankPage{
    [BankPage show:self isSelect:NO];
}

-(void)onGoAddressPage{
    [AddressPage show:self type:AddressType_Add addressId:nil];
}

-(void)onGoWithdrawPage{
    [WithdrawPage show:self];
}

-(void)onGoMsgDetailPage:(NSString *)msgId{
    [MsgDetailPage show:self msgId:msgId];
}

-(void)onGoProductPage:(NSString *)skuId{
    [ProductDetailPage show:self skuId:skuId];
}

-(void)onGoCooperationPage:(NSMutableArray *)datas{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.authenticateState == AuthenticateState_Success){
        [CooperationPage show:self datas:datas];
    }else{
        _authenticateDialog.hidden = NO;
    }
}

-(void)onGoHomeSearchPage{
    [HomeSearchPage show:self];
}

-(void)onGoAddProductPage{
    [AddProductPage show:self];
}

-(void)onGoCapitalDetailPage:(NSString *)listId{
    [CapitalDetailPage show:self orderId:listId];
}

-(void)onGoStaticticsPage:(StaticticsType)type{
    [StaticticsPage show:self type:type];
}

-(void)onGoWithdrawListPage{
    [WithdrawListPage show:self];
}

//


-(void)onHiddenBottomView:(Boolean)hidden{
    WS(weakSelf)
    if(hidden){
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.bottomView.frame = CGRectMake(0,  ScreenHeight, ScreenWidth, TAB_HEIGHT + homeHeight);
            if(self->roleType != RoleType_Merchant){
                weakSelf.shopBtn.frame = CGRectMake(STWidth(145),ScreenHeight,STWidth(86) , STHeight(70));
                weakSelf.shopLabel.frame = CGRectMake(STWidth(145),ScreenHeight, STWidth(86), STHeight(16));
                weakSelf.shopView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            }
            
        }];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.bottomView.frame = CGRectMake(0,  ScreenHeight-TAB_HEIGHT-homeHeight, ScreenWidth, TAB_HEIGHT + homeHeight);
            if(self->roleType != RoleType_Merchant){
                weakSelf.shopBtn.frame = CGRectMake(STWidth(145),ScreenHeight-homeHeight-STHeight(95),STWidth(86) , STHeight(70));
                weakSelf.shopLabel.frame = CGRectMake(STWidth(145),ScreenHeight-homeHeight-STHeight(23), STWidth(86), STHeight(16));
                if (@available(iOS 11.0, *)) {
                    weakSelf.shopView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - HomeIndicatorHeight - TAB_HEIGHT);
                } else {
                    weakSelf.shopView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - TAB_HEIGHT);
                }
            }
        }];
    }
}

@end

