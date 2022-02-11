//
//  QulificationsEditPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "QulificationsEditPage.h"
#import "QulificationsEditView.h"
#import "PreviewPage.h"
#import "PreviewModel.h"
#import "STSinglePickerLayerView.h"
#import "MainPage.h"

@interface QulificationsEditPage()<QulificationsEditViewDelegate,STSinglePickerLayerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong, nonatomic)QulificationsEditView *qulificationsEditView;
@property(strong, nonatomic)QulificationsEditViewModel *viewModel;
@property(assign, nonatomic)RoleType roleType;
@property(strong, nonatomic)STSinglePickerLayerView *photoLayerView;
@property(assign, nonatomic)IdentifyType identifyType;
@property(assign, nonatomic)PreviewImageType previewImageType;
@property(strong, nonatomic)QulificationsModel *model;
@property(assign, nonatomic)Boolean isEdit;
@property(strong, nonatomic)NSString *imgSrc;


@end

@implementation QulificationsEditPage

+(void)show:(BaseViewController *)controller roleType:(RoleType)roleType model:(QulificationsModel *)model isEdit:(Boolean)isEdit{
    QulificationsEditPage *page = [[QulificationsEditPage alloc]init];
    page.roleType = roleType;
    page.model = model;
    page.isEdit = isEdit;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:_roleType == RoleType_Celebrity ? @"主播认证" : @"企业资质" needback:YES];
    [self initView];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_qulificationsEditView){
        [_qulificationsEditView updateViewIdentify];
        [_qulificationsEditView updateViewBusinessLicense];
    }
}

-(void)initView{
    _viewModel = [[QulificationsEditViewModel alloc]init];
    _viewModel.roleType = _roleType;
    if(_model != nil){
        _viewModel.model = _model;
    }
    _viewModel.isEdit = _isEdit;
    _viewModel.delegate = self;
    
    _qulificationsEditView =[[QulificationsEditView alloc]initWithViewModel:_viewModel];
    _qulificationsEditView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _qulificationsEditView.backgroundColor = cbg2;
    [self.view addSubview:_qulificationsEditView];
    
    NSMutableArray *datas = [NSMutableArray arrayWithArray: @[@"拍照",@"相册"]];
    _photoLayerView = [[STSinglePickerLayerView alloc]initWithDatas:datas];
    _photoLayerView.hidden = YES;
    _photoLayerView.delegate = self;
    [STWindowUtil addWindowView:_photoLayerView];
}


-(void)onGoPreviewPage:(NSMutableArray *)datas previewType:(PreviewImageType)previewType{
    [PreviewPage show:self datas:datas previewType:previewType];
}


-(void)onSelectResult:(NSString *)result layerView:(UIView *)layerView position:(NSInteger)position{
    if(position == 0){
        [self openCamera];
    }else{
        [self openAlbumPhoto];
    }
}


-(void)onOpenPhotoDialog:(PreviewImageType)previewImageType identifyType:(IdentifyType)identifyType{
    _previewImageType = previewImageType;
    _identifyType = identifyType;
    _photoLayerView.hidden = NO;
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
    [_viewModel updateLoadFile:image type:_identifyType previewType:_previewImageType];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)onRequestBegin{}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_UPLOAD_FILE]){
        [STLog print:@"上传成功!"];
        _imgSrc = data;
    }else if([respondModel.requestUrl containsString:URL_GET_FILE]){
        if(_previewImageType == PreviewImageType_Identify){
            if(_identifyType == IdentifyType_Back){
                PreviewModel *model = [PreviewModel build:data imgSrc:_imgSrc isSelect:NO position:1];
                [_viewModel.identifyDatas addObject:model];
            }else{
                PreviewModel *model = [PreviewModel build:data imgSrc:_imgSrc isSelect:NO position:0];
                [_viewModel.identifyDatas addObject:model];
            }
            [_qulificationsEditView updateViewIdentify];
        }else{
            PreviewModel *model = [PreviewModel build:data imgSrc:_imgSrc isSelect:NO];
            [_viewModel.licenseDatas addObject:model];
            [_qulificationsEditView updateViewBusinessLicense];
        }
    }else if([respondModel.requestUrl isEqualToString:URL_MCH_AUTHENTICATE]){
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MainPage class]]) {
                MainPage *page =(MainPage *)controller;
                [self.navigationController popToViewController:page animated:YES];
            }
        }
    }
}

-(void)onRequestFail:(NSString *)msg{}



@end

