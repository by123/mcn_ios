//
//  PartnerMcnViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthUserModel.h"

@protocol PartnerMcnViewDelegate<BaseRequestDelegate>

@end


@interface PartnerMcnViewModel : NSObject

@property(weak, nonatomic)id<PartnerMcnViewDelegate> delegate;
@property(strong, nonatomic)AuthUserModel *model;
@property(copy, nonatomic)NSString *mchId;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)requestDetail;

@end



