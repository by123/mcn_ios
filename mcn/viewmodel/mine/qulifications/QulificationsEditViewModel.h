//
//  QulificationsEditViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QulificationsModel.h"

@protocol QulificationsEditViewDelegate<BaseRequestDelegate>

-(void)onGoPreviewPage:(NSMutableArray *)datas previewType:(PreviewImageType)previewType;
-(void)onOpenPhotoDialog:(PreviewImageType)previewImageType identifyType:(IdentifyType)identifyType;


@end


@interface QulificationsEditViewModel : NSObject

@property(weak, nonatomic)id<QulificationsEditViewDelegate> delegate;
@property(assign, nonatomic)RoleType roleType;
@property(strong, nonatomic)NSMutableArray *licenseDatas;
@property(strong, nonatomic)NSMutableArray *identifyDatas;
@property(strong, nonatomic)QulificationsModel *model;
@property(assign, nonatomic)Boolean isEdit;

-(void)goPreviewPage:(NSMutableArray *)datas previewType:(PreviewImageType)previewType;

-(void)openPhotoDialog:(PreviewImageType)previewImageType identifyType:(IdentifyType)identifyType;

-(void)commitAuthenticate;
-(void)updateLoadFile:(UIImage *)image type:(IdentifyType)type previewType:(PreviewImageType)previewType;
-(void)getFileUrl:(NSString *)fileName;

@end



