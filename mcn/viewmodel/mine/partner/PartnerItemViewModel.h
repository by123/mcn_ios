//
//  PartnerItemViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnerModel.h"

@protocol PartnerItemViewDelegate<BaseRequestDelegate>

-(void)onRequestNoDatas:(Boolean)isFirst;

@end


@interface PartnerItemViewModel : NSObject

@property(weak, nonatomic)id<PartnerItemViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)PartnerType partnerType;


-(void)requestList:(Boolean)isRefreshNew;

@end



