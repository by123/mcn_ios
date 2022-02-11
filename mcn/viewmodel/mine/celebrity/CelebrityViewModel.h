//
//  CelebrityViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CelebrityViewDelegate<BaseRequestDelegate>

-(void)onGoCelebrityDetailPage:(NSString *)mchId type:(int)type operateState:(int)operateState celebrityId:(NSString *)celebrityId;

@end


@interface CelebrityViewModel : NSObject

@property(weak, nonatomic)id<CelebrityViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)goCelebrityDetailPage:(NSString *)mchId type:(int)type operateState:(int)operateState celebrityId:(NSString *)celebrityId;

@end



