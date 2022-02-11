//
//  CelebrityListViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CelebrityModel.h"
#import "CelebrityViewModel.h"

@protocol CelebrityListViewDelegate<BaseRequestDelegate>

-(void)onRequestNoDatas:(Boolean)isFirst;


@end


@interface CelebrityListViewModel : NSObject

@property(weak, nonatomic)id<CelebrityListViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)int inviteType;
@property(strong, nonatomic)CelebrityViewModel *celebrityVM;

-(void)requestList:(Boolean)isRefreshNew;
-(void)reqeustInviteList:(Boolean)isRefreshNew;
-(void)removeCelebrity:(NSString *)cid;

@end



