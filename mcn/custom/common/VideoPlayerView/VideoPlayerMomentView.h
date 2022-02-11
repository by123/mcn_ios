//
//  VideoPlayerMomentView.h
//  cigarette
//
//  Created by xiao ming on 2020/3/27.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "VideoPlayerBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerMomentView : VideoPlayerBaseView

- (void)showVideo:(NSString *)path;
- (void)showPicture:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
