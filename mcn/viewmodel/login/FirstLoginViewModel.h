//
//  FirstLoginViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FirstLoginViewDelegate<BaseRequestDelegate>

@end


@interface FirstLoginViewModel : NSObject

@property(weak, nonatomic)id<FirstLoginViewDelegate> delegate;

- (void)requestChange:(NSString *)newPwd;

@end



