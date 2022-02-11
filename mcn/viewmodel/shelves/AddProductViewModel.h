//
//  AddProductViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddProductModel.h"
#import "CategoryModel.h"

@protocol AddProductViewDelegate<BaseRequestDelegate>

-(void)onGoPreviewPage:(NSMutableArray *)datas previewType:(PreviewImageType)previewType;
-(void)onOpenPhotoDialog:(PreviewImageType)previewImageType;
-(void)onUpdateConfig;

@end


@interface AddProductViewModel : NSObject

@property(weak, nonatomic)id<AddProductViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *photosImgDatas;
@property(strong, nonatomic)NSMutableArray *detailImgDatas;
@property(strong, nonatomic)NSMutableArray *categoryDatas;
@property(strong, nonatomic)ProductConfigModel *configModel;
@property(strong, nonatomic)AddProductModel *addProductModel;


-(void)getProfitPercent;
-(void)getProductType;
-(void)goPreviewPage:(NSMutableArray *)datas previewType:(PreviewImageType)previewType;
-(void)openPhotoDialog:(PreviewImageType)previewImageType;
-(void)updateLoadFile:(UIImage *)image previewType:(PreviewImageType)previewType;
-(void)getFileUrl:(NSString *)fileName;
-(void)commitProduct;

@end



