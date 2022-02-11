//
//  ProductModel.h
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CelebrityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductAuthModel : NSObject

@property(copy, nonatomic)NSString *remark;

@end

@interface ProductMchModel : NSObject

@property(copy, nonatomic)NSString *mchId;
@property(copy, nonatomic)NSString *picFullUrl;
@property(copy, nonatomic)NSString *mchName;
@property(copy, nonatomic)NSString *contactPhone;
@property(copy, nonatomic)NSString *contactUser;
@property(strong, nonatomic)id authenticateDataRespVo;
@property(strong, nonatomic)ProductAuthModel *authModel;

@end

@interface ProductModel : NSObject

@property(copy, nonatomic)NSString *skuId;
@property(copy, nonatomic)NSString *spuId;
@property(copy, nonatomic)NSString *skuPicUrl;
@property(copy, nonatomic)NSString *skuPicOssUrl;
@property(copy, nonatomic)NSString *attribute;
@property(assign, nonatomic)double sellPrice;
@property(assign, nonatomic)int sellFlag;
@property(copy, nonatomic)NSString *spuName;
@property(copy, nonatomic)NSString *spuRemark;
@property(assign, nonatomic)double firstOrderProfit;
@property(assign, nonatomic)double repeatProfit;
@property(assign, nonatomic)double salesProfit;
@property(copy, nonatomic)NSString *allocateRatio;
@property(copy, nonatomic)NSString *createTime;
@property(copy, nonatomic)NSString *mchName;
@property(copy, nonatomic)NSString *picUrl;

+(NSString *)getAttributeValue:(NSString *)attribute;
+(NSString *)getAttributeKeyValue:(NSString *)attribute;


//详情使用
@property(strong, nonatomic)NSMutableArray *picUrlList;
@property(strong, nonatomic)NSMutableArray *goodsDetailList;
@property(strong, nonatomic)id mchUserRespVo;
@property(strong, nonatomic)ProductMchModel *mchModel;

//合作详情使用
@property(strong, nonatomic)id anchors;
@property(strong, nonatomic)NSMutableArray *celebrityModels;
@property(copy, nonatomic)NSString *goodsLink;



@end

@interface ProductCelebrityModel : NSObject

@property(copy, nonatomic)NSString *anchorMchId;
@property(copy, nonatomic)NSString *mchName;
@property(copy, nonatomic)NSString *avatar;
@property(assign, nonatomic)double firstOrderProfit;
@property(assign, nonatomic)double repeatProfit;
@property(copy, nonatomic)NSString *goodsLink;

@end



NS_ASSUME_NONNULL_END
