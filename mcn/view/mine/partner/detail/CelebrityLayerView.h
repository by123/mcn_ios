//
//  CelebrityLayerView.h
//  mcn
//
//  Created by by.huang on 2020/9/8.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CelebrityLayerViewDelegate

-(void)onCelebrityLayerCloseBtnClick;

@end

@interface CelebrityLayerView : UIView

@property(weak, nonatomic)id<CelebrityLayerViewDelegate> delegate;
-(void)updateDatas:(NSMutableArray *)datas;

@end

NS_ASSUME_NONNULL_END
