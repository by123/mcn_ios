//
//  MsgDetailViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgModel.h"

@protocol MsgDetailViewDelegate<BaseRequestDelegate>

-(void)onNotExist;

@end


@interface MsgDetailViewModel : NSObject

@property(weak, nonatomic)id<MsgDetailViewDelegate> delegate;
@property(copy, nonatomic)NSString *msgId;
@property(strong, nonatomic)MsgModel *model;

-(void)requestMsgDetail;
-(void)requestAgree:(Boolean)isAgree;

@end



