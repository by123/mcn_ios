//
//  HomeViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"
#import "BannerModel.h"

@protocol HomeViewDelegate<BaseRequestDelegate>

-(void)onUpdateBanner;

@end


@interface HomeViewModel : NSObject

@property(weak, nonatomic)id<HomeViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *categoryDatas;
@property(strong, nonatomic)NSMutableArray *bannerDatas;

//获取商品类别
-(void)requestGoodsCategory;

//获取banner
-(void)requestBanner;

@end



