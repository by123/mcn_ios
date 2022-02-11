//
//  BusinessEditPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "BusinessEditPage.h"
#import "BusinessEditView.h"
#import "STSinglePickerLayerView.h"
#import "STObserverManager.h"
#import "VerifyCodePage.h"

@interface BusinessEditPage()<BusinessEditViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STSinglePickerLayerViewDelegate,STObserverProtocol>

@property(strong, nonatomic)BusinessEditView *businessEditView;
@property(strong, nonatomic)BusinessEditViewModel *viewModel;
@property(copy, nonatomic)NSString *mchId;
@property(strong, nonatomic)STSinglePickerLayerView *photoLayerView;

@end

@implementation BusinessEditPage

+(void)show:(BaseViewController *)controller mchId:(NSString *)mchId{
    BusinessEditPage *page = [[BusinessEditPage alloc]init];
    page.mchId = mchId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"个人名片" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[BusinessEditViewModel alloc]init];
    _viewModel.mchId = _mchId;
    _viewModel.delegate = self;
    
    _businessEditView =[[BusinessEditView alloc]initWithViewModel:_viewModel];
    _businessEditView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _businessEditView.backgroundColor = cbg2;
    [self.view addSubview:_businessEditView];
    
    NSMutableArray *datas = [NSMutableArray arrayWithArray: @[@"拍照",@"相册"]];
    _photoLayerView = [[STSinglePickerLayerView alloc]initWithDatas:datas];
    _photoLayerView.hidden = YES;
    _photoLayerView.delegate = self;
    [STWindowUtil addWindowView:_photoLayerView];
    
    [_viewModel requestDetail];
    
    [[STObserverManager sharedSTObserverManager]registerSTObsever:NOTIFY_UPDATE_PHONE delegate:self];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:NOTIFY_UPDATE_PHONE];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_MCH_MY_CARD]){
        [_businessEditView updateView];
    } else if([respondModel.requestUrl isEqualToString:URL_UPLOAD_FILE_PUBLIC]){
        [STLog print:@"上传成功!"];
    }else if([respondModel.requestUrl containsString:URL_GET_FILE_PUBLIC]){
        [_businessEditView updateHeadImage:data];
    }else if([respondModel.requestUrl isEqualToString:URL_MCH_CARD_MOD]){
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_UPDATE_BUSINESS msg:nil];
        [super backLastPage];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onSelectImage{
    _photoLayerView.hidden = NO;
}

-(void)onSelectResult:(NSString *)result layerView:(UIView *)layerView position:(NSInteger)position{
    if(position == 0){
        [self openCamera];
    }else{
        [self openAlbumPhoto];
    }
}


//调用相机
- (void)openCamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        picker.editing = NO;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        [LCProgressHUD showMessage:@"请检查摄像头是否可用"];
    }
}

//调用相册
-(void)openAlbumPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = NO;
    picker.editing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [_viewModel updateLoadFile:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)backLastPage{
    [_viewModel requestEdit];
}


-(void)onGoUpdatePhonePage{
    [VerifyCodePage show:self phoneNum:_viewModel.model.contactPhone updatePhone:YES];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:NOTIFY_UPDATE_PHONE]){
        [_businessEditView updatePhone];
    }
}
@end

