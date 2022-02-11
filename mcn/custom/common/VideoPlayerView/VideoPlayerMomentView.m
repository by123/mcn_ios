//
//  VideoPlayerMomentView.m
//  cigarette
//
//  Created by xiao ming on 2020/3/27.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "VideoPlayerMomentView.h"

@interface VideoPlayerMomentView ()

@property(nonatomic, strong)UIView *containerView;

@end

@implementation VideoPlayerMomentView

- (instancetype)init {
    if(self == [super init]){
        self.userInteractionEnabled = true;
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapGesture {
    [self removeFromSuperview];
    [self stopPlay];
}

- (void)showVideo:(NSString *)path {
    [self setupPlayer:path];
    [self startPlay];
}

- (void)showPicture:(UIImage *)image {
    self.image = image;
    [self.activityView stopAnimating];
}

@end
