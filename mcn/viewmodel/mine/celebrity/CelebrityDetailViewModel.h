//
//  CelebrityDetailViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CelebrityModel.h"

@protocol CelebrityDetailViewDelegate<BaseRequestDelegate>

@end


@interface CelebrityDetailViewModel : NSObject

@property(weak, nonatomic)id<CelebrityDetailViewDelegate> delegate;
@property(strong, nonatomic)CelebrityModel *model;
@property(copy, nonatomic)NSString *mchId;
@property(assign, nonatomic)int type;
@property(assign, nonatomic)int operateState;
@property(copy, nonatomic)NSString *celebrityId;


-(void)requestCelebrityDetail;
-(void)removeCelebrityInvite;
-(void)removeCelebrity;
-(void)rejectCelebrity;
-(void)agreeCelebrity;

@end



