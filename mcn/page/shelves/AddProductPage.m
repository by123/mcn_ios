//
//  AddProductPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddProductPage.h"
#import "AddProductView.h"
#import "PreviewPage.h"
#import "STSinglePickerLayerView.h"
#import "STObserverManager.h"

@interface AddProductPage()<AddProductViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STSinglePickerLayerViewDelegate>

@property(strong, nonatomic)AddProductView *addProductView;
@property(strong, nonatomic)AddProductViewModel *viewModel;
@property(strong, nonatomic)STSinglePickerLayerView *photoLayerView;
@property(assign, nonatomic)PreviewImageType previewImageType;
@property(copy, nonatomic)NSString *imgSrc;

@end

@implementation AddProductPage

+(void)show:(BaseViewController *)controller{
    AddProductPage *page = [[AddProductPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"产品上传" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_addProductView){
        [_addProductView updatePhotoView];
        [_addProductView updateDetailView];
    }
}

-(void)initView{
    _viewModel = [[AddProductViewModel alloc]init];
    _viewModel.delegate = self;
    
    _addProductView =[[AddProductView alloc]initWithViewModel:_viewModel];
    _addProductView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _addProductView.backgroundColor = cbg2;
    [self.view addSubview:_addProductView];
    
    NSMutableArray *datas = [NSMutableArray arrayWithArray: @[@"拍照",@"相册"]];
    _photoLayerView = [[STSinglePickerLayerView alloc]initWithDatas:datas];
    _photoLayerView.hidden = YES;
    _photoLayerView.delegate = self;
    [STWindowUtil addWindowView:_photoLayerView];
    
    [_viewModel getProfitPercent];
    [_viewModel getProductType];

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
    [_viewModel updateLoadFile:image previewType:_previewImageType];
    [picker dismissViewControllerAnimated:YES completion:nil];
}



-(void)onSelectResult:(NSString *)result layerView:(UIView *)layerView position:(NSInteger)position{
    if(position == 0){
        [self openCamera];
    }else{
        [self openAlbumPhoto];
    }
}

-(void)onGoPreviewPage:(NSMutableArray *)datas previewType:(PreviewImageType)previewType{
    [PreviewPage show:self datas:datas previewType:previewType];
}

-(void)onOpenPhotoDialog:(PreviewImageType)previewImageType{
    _previewImageType = previewImageType;
    _photoLayerView.hidden = NO;
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_UPLOAD_FILE_PUBLIC]){
        [STLog print:@"上传成功!"];
        _imgSrc = data;
    }else if([respondModel.requestUrl containsString:URL_GET_FILE_PUBLIC]){
        if(_previewImageType == PreviewImageType_Photo){
            PreviewModel *model = [PreviewModel build:data imgSrc:_imgSrc isSelect:NO];
            [_viewModel.photosImgDatas addObject:model];
            [_addProductView updatePhotoView];
        }else{
            PreviewModel *model = [PreviewModel build:data imgSrc:_imgSrc isSelect:NO];
            [_viewModel.detailImgDatas addObject:model];
            [_addProductView updateDetailView];
        }
    }else if([respondModel.requestUrl isEqualToString:URL_GOODS_ADD]){
        [LCProgressHUD showMessage:@"产品上传成功!"];
        [[STObserverManager sharedSTObserverManager]sendMessage:NOTIFY_TAB_UNDERCARRIAGE msg:nil];
        [self backLastPage];
    }else if([respondModel.requestUrl isEqualToString:URL_GOODS_CATEGORY]){
        [_addProductView updateType];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onUpdateConfig{
    [_addProductView updateConfig];
}


@end

