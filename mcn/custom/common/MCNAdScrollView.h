//
//  MCNAdScrollView.h
//  mcn
//
//  Created by by.huang on 2020/8/18.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MCNAdScrollViewDelegate <NSObject>

-(void)onMCNAdScrollViewDidChange:(id)view position:(NSInteger)position;
-(void)onMCNItemClick:(NSInteger)position;

@end

@interface MCNAdScrollView : UIView

//needLoad是否网络图片需要加载
-(instancetype)initWithImages:(NSMutableArray *)datas needLoad:(Boolean)needLoad isAuto:(Boolean)isAuto;

@property(weak, nonatomic)id<MCNAdScrollViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
