//
//  QulificationsModel.h
//  mcn
//
//  Created by by.huang on 2020/8/30.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QulificationsModel : NSObject

@property(copy, nonatomic)NSString *idcardBackUrl;
@property(copy, nonatomic)NSString *idcardHeadUrl;
@property(copy, nonatomic)NSString *idcardHeadFullUrl;
@property(copy, nonatomic)NSString *idcardBackFullUrl;
@property(copy, nonatomic)NSString *mchId;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *number;
@property(copy, nonatomic)NSMutableArray *orgNumberUrlList;
@property(copy, nonatomic)NSMutableArray *orgNumberFullUrlList;
@property(copy, nonatomic)NSString *remark;
//需要认证的类型：2mcn机构，3主播，4供应商
@property(assign, nonatomic)int mchType;

@end

NS_ASSUME_NONNULL_END
