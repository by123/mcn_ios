
//
//  QulificationsEditViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QulificationsEditViewModel.h"
#import "STNetUtil.h"
#import "PreviewModel.h"
@interface QulificationsEditViewModel()


@end

@implementation QulificationsEditViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _licenseDatas = [[NSMutableArray alloc]init];
        _identifyDatas =  [[NSMutableArray alloc]init];
        _model = [[QulificationsModel alloc]init];
    }
    return self;
}

-(void)commitAuthenticate{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *backUrl;
    NSString *headUrl;
    for(PreviewModel *model in _identifyDatas){
        if(model.position == 0){
            headUrl = model.imgSrc;
        }else if(model.position == 1){
            backUrl = model.imgSrc;
        }
    }
    NSMutableArray *licenseUrls = [[NSMutableArray alloc]init];
    for(PreviewModel *model in _licenseDatas){
        [licenseUrls addObject:model.imgSrc];
    }
    dic[@"idcardBackUrl"] = backUrl;
    dic[@"idcardHeadUrl"] = headUrl;
    dic[@"mchType"] = @(_roleType);
    dic[@"name"] = _model.name;
    dic[@"number"] = _model.number;
    dic[@"orgNumberUrlList"] = licenseUrls;
    dic[@"remark"] = _model.remark;
    WS(weakSelf)
    [STNetUtil post:URL_MCH_AUTHENTICATE content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)updateLoadFile:(UIImage *)image type:(IdentifyType)type previewType:(PreviewImageType)previewType{
    WS(weakSelf)
    [STNetUtil upload:image url:URL_UPLOAD_FILE success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
            [weakSelf getFileUrl:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)getFileUrl:(NSString *)fileName{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"fileName"] = fileName;
    WS(weakSelf)
    [STNetUtil get:URL_GET_FILE parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)goPreviewPage:(NSMutableArray *)datas previewType:(PreviewImageType)previewType{
    if(_delegate){
        [_delegate onGoPreviewPage:datas previewType:previewType];
    }
}

-(void)openPhotoDialog:(PreviewImageType)previewImageType identifyType:(IdentifyType)identifyType{
    if(_delegate){
        [_delegate onOpenPhotoDialog:previewImageType identifyType:identifyType];
    }
}


@end



