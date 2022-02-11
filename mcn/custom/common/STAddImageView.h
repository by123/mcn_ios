//
//  STAddImageView.h
//  mcn
//
//  Created by by.huang on 2020/8/20.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreviewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol STAddImageViewDelegate <NSObject>

-(void)onAddImageViewItemClick:(NSInteger)position view:(id)view;

@end

@interface STAddImageView : UIView

-(instancetype)initWithImages:(nullable NSMutableArray *)imgDatas;
-(void)addDatas:(PreviewModel *)model;
-(void)setDatas:(NSMutableArray *)imgDatas;

@property(strong, nonatomic)NSMutableArray *imageDatas;
@property(weak, nonatomic)id<STAddImageViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
