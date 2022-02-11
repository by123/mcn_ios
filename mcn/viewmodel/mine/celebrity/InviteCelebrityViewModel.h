//
//  InviteCelebrityViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CelebrityModel.h"

@protocol InviteCelebrityViewDelegate<BaseRequestDelegate>

@end


@interface InviteCelebrityViewModel : NSObject

@property(weak, nonatomic)id<InviteCelebrityViewDelegate> delegate;
@property(strong, nonatomic)CelebrityModel *model;

-(void)inviteCelebrity;

@end



