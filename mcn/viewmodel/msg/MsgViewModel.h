//
//  MsgViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgModel.h"

@protocol MsgViewDelegate<BaseRequestDelegate>

-(void)onRequestNoDatas:(Boolean)isFirst;

@end


@interface MsgViewModel : NSObject

@property(weak, nonatomic)id<MsgViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)reqeustMsgList:(Boolean)isRefreshNew;
-(void)readMsg:(NSString *)msgId;
-(void)delMsg:(NSString *)msgId;

@end



