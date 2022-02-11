//
//  ChangePwdViewModel.h
//  cigarette
//
//  Created by xiao ming on 2019/12/16.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePwdViewModel : NSObject

@property(assign, nonatomic)BOOL isSuccess;

- (void)requestChange:(NSString *)oldPwd newPwd:(NSString *)newPwd;

@end

NS_ASSUME_NONNULL_END
