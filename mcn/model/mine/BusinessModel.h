//
//  BusinessModel.h
//  mcn
//
//  Created by by.huang on 2020/9/3.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BusinessModel : NSObject

@property(copy, nonatomic)NSString *mchName;
@property(copy, nonatomic)NSString *picFullUrl;
@property(copy, nonatomic)NSString *picUrl;
@property(assign, nonatomic)int sex;
@property(copy, nonatomic)NSString *contactPhone;
@property(copy, nonatomic)NSString *douyinAccount;
@property(copy, nonatomic)NSString *kuaishouAccount;
@property(copy, nonatomic)NSString *remark;




@end

NS_ASSUME_NONNULL_END
