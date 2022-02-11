//
//  ProductDetailPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//
#import "ShopModel.h"
#import "ProductDetailPage.h"
#import "ProductDetailView.h"
#import "CooperationPage.h"
#import "STObserverManager.h"
#import "MainPage.h"
#import "AccountManager.h"
#import "STDialog.h"
#import "QulificationsPage.h"
@interface ProductDetailPage()<ProductDetailViewDelegate,STDialogDelegate>

@property(strong, nonatomic)ProductDetailView *productDetailView;
@property(strong, nonatomic)ProductDetailViewModel *viewModel;
@property(copy, nonatomic)NSString *skuId;
@property(assign, nonatomic)Boolean statuBarHidden;
@property(strong, nonatomic)STDialog *authenticateDialog;

@end

@implementation ProductDetailPage

+(void)show:(BaseViewController *)controller skuId:(NSString *)skuId{
    ProductDetailPage *page = [[ProductDetailPage alloc]init];
    page.skuId = skuId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideNavigationBar:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[ProductDetailViewModel alloc]init];
    _viewModel.skuId = _skuId;
    _viewModel.delegate = self;
    
    _productDetailView =[[ProductDetailView alloc]initWithViewModel:_viewModel];
    _productDetailView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _productDetailView.backgroundColor = cbg2;
    [self.view addSubview:_productDetailView];
    
    [_viewModel requesDetail];
    [self initAuthDialog];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_GOODS_DETAIL]){
        [_productDetailView updateView];
    }else if([respondModel.requestUrl containsString:URL_SHOPCART_ADD]){
        [STShowToast show:@"加入选品站成功!"];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onGoBack{
    [self backLastPage];
}

-(void)onGoCooperationPage{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.authenticateState == AuthenticateState_Success){
        ProductModel *productModel = _viewModel.model;
        ProductMchModel *mchModel = productModel.mchModel;
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        ShopModel *shopModel = [[ShopModel alloc]init];
        shopModel.mchId = mchModel.mchId;
        shopModel.supplierName = mchModel.mchName;
        shopModel.avatar = mchModel.picFullUrl;
        
        NSMutableArray *skuModels = [[NSMutableArray alloc]init];
        
        ShopSkuModel *skuModel = [[ShopSkuModel alloc]init];
        skuModel.skuId = productModel.skuId;
        skuModel.spuId = productModel.spuId;
        skuModel.spuName = productModel.spuName;
        skuModel.sellFlag = productModel.sellFlag;
        skuModel.sellPrice = productModel.sellPrice;
        if(!IS_NS_COLLECTION_EMPTY(productModel.picUrlList)){
            skuModel.picUrl = productModel.picUrlList[0];
        }
        skuModel.attribute = productModel.attribute;
        skuModel.allocateRatio = productModel.allocateRatio;
        
        [skuModels addObject:skuModel];
        shopModel.skuModels = skuModels;
        
        [datas addObject:shopModel];
        [CooperationPage show:self datas:datas];
    }else{
        _authenticateDialog.hidden = NO;
    }
}

-(void)onConfirmBtnClicked:(id)dialog{
    _authenticateDialog.hidden = YES;
    [QulificationsPage show:self];
}

-(void)onCancelBtnClicked:(id)dialog{
    _authenticateDialog.hidden = YES;
}


-(void)initAuthDialog{
    _authenticateDialog = [[STDialog alloc]initWithTitle:@"提醒" content:@"您还未提交资质认证,点击确定提交" subContent:MSG_EMPTY size:CGSizeMake(STWidth(315), STHeight(200))];
    _authenticateDialog.delegate = self;
    _authenticateDialog.hidden = YES;
    [_authenticateDialog showConfirmBtn:YES cancelBtn:YES];
    [_authenticateDialog setConfirmBtnStr:@"确定" cancelStr:@"取消"];
    [self.view addSubview:_authenticateDialog];
}

//
//-(void)onChangeStatuBarHidden:(Boolean)hidden{
//    _statuBarHidden = hidden;
//    [self setNeedsStatusBarAppearanceUpdate];
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    if (_statuBarHidden) {
//        NSLog(@"隐藏");
//        [self setStatuBarBackgroud:[cblack colorWithAlphaComponent:0.0f] style:UIStatusBarStyleDefault];
//        return UIStatusBarStyleLightContent;
//    }
//    NSLog(@"显示");
//
//    [self setStatuBarBackgroud:cwhite style:UIStatusBarStyleDefault];
//    return UIStatusBarStyleDefault;
//}


-(void)onGoMessageTab{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MainPage class]]) {
            MainPage *page =(MainPage *)controller;
            [self.navigationController popToViewController:page animated:YES];
            [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_TAB_MSG msg:nil];
        }
    }
}
@end

