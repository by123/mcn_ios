//
//  DeliveryPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "DeliveryPage.h"
#import "DeliveryView.h"
#import "STObserverManager.h"
#import "PartnerPage.h"

@interface DeliveryPage()<DeliveryViewDelegate>

@property(strong, nonatomic)DeliveryView *deliveryView;
@property(strong, nonatomic)DeliveryViewModel *viewModel;
@property(copy, nonatomic)NSString *cooperationId;
@property(strong, nonatomic)AddressInfoModel *addressModel;

@end

@implementation DeliveryPage

+(void)show:(BaseViewController *)controller model:(AddressInfoModel *)addressModel{
    DeliveryPage *page = [[DeliveryPage alloc]init];
    page.addressModel = addressModel;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"发货" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[DeliveryViewModel alloc]init];
    _viewModel.model.addressId = _addressModel.addressId;
    _viewModel.model.cooperationId = _addressModel.cooperationId;
    _viewModel.addressModel = _addressModel;
    _viewModel.delegate = self;
    
    _deliveryView =[[DeliveryView alloc]initWithViewModel:_viewModel];
    _deliveryView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _deliveryView.backgroundColor = cwhite;
    [self.view addSubview:_deliveryView];
    
    [_viewModel getExpressList];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_DELIVERY_SUBMIT]){
        [STShowToast show:@"发货成功！"];
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_UPDATE_PARTNER msg:nil];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[PartnerPage class]]) {
                PartnerPage *page =(PartnerPage *)controller;
                [self.navigationController popToViewController:page animated:YES];
            }
        }
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onGetExpressList{
    [_deliveryView updateExpressView];
}


@end

