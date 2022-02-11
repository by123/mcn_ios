
//
//  AddProductViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddProductViewModel.h"
#import "STNetUtil.h"

@interface AddProductViewModel()


@end

@implementation AddProductViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _photosImgDatas = [[NSMutableArray alloc]init];
        _detailImgDatas = [[NSMutableArray alloc]init];
        _categoryDatas = [[NSMutableArray alloc]init];
        _configModel = [[ProductConfigModel alloc]init];
        _addProductModel = [[AddProductModel alloc]init];
    }
    return self;
}

//获取分成比例
-(void)getProfitPercent{
    WS(weakSelf)
    [STNetUtil getConfig:@"profit_rule" success:^(NSString *result) {
        if(!IS_NS_STRING_EMPTY(result)){
            weakSelf.configModel = [ProductConfigModel mj_objectWithKeyValues:result];
            [weakSelf.delegate onUpdateConfig];
        }
    }];
}

//获取产品类型
-(void)getProductType{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil get:URL_GOODS_CATEGORY parameters:nil success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.categoryDatas = [CategoryModel mj_objectArrayWithKeyValuesArray:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)updateLoadFile:(UIImage *)image previewType:(PreviewImageType)previewType{
    WS(weakSelf)
    [STNetUtil upload:image url:URL_UPLOAD_FILE_PUBLIC success:^(RespondModel *respondModel) {
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
    [STNetUtil get:URL_GET_FILE_PUBLIC parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

//提交上传
-(void)commitProduct{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil post:URL_GOODS_ADD content:_addProductModel.mj_JSONString success:^(RespondModel *respondModel) {
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


-(void)goPreviewPage:(NSMutableArray *)datas previewType:(PreviewImageType)previewType{
    if(_delegate){
        [_delegate onGoPreviewPage:datas previewType:previewType];
    }
}

-(void)openPhotoDialog:(PreviewImageType)previewImageType{
    if(_delegate){
        [_delegate onOpenPhotoDialog:previewImageType];
    }
}


@end



