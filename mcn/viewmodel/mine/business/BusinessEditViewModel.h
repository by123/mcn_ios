//
//  BusinessEditViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessModel.h"

@protocol BusinessEditViewDelegate<BaseRequestDelegate>

-(void)onSelectImage;
-(void)onGoUpdatePhonePage;

@end


@interface BusinessEditViewModel : NSObject

@property(weak, nonatomic)id<BusinessEditViewDelegate> delegate;
@property(strong, nonatomic)BusinessModel *model;
@property(copy, nonatomic)NSString *mchId;

-(void)requestDetail;
-(void)requestEdit;
-(void)selectImage;
-(void)updateLoadFile:(UIImage *)image;
-(void)goUpdatePhonePage;

@end



