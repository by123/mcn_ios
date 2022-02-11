//
//  MsgModel.h
//  mcn
//
//  Created by by.huang on 2020/8/21.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MsgModel : NSObject

@property(assign, nonatomic)NSString *msgId;
@property(copy, nonatomic)NSString *appTypes;
@property(copy, nonatomic)NSString *title;
@property(copy, nonatomic)NSString *content;
@property(copy, nonatomic)NSString *text;
@property(copy, nonatomic)NSString *createTime;
//4邀请通知  5是物流助手
@property(assign, nonatomic)MessageType messageType;
@property(assign, nonatomic)int messageState;
@property(assign, nonatomic)int pushType;
//0未读 1已读
@property(assign, nonatomic)int readState;
//0未操作 1已操作
@property(assign, nonatomic)int optState;
@property(assign, nonatomic)int productionModeState;
@property(copy, nonatomic)NSString *messageJson;
@property(copy, nonatomic)NSString *extraMapJson;

+(NSMutableArray *)getDatas;

@end

NS_ASSUME_NONNULL_END
