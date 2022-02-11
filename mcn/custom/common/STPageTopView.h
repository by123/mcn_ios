//
//  STPageTopView.h
//  mcn
//
//  Created by by.huang on 2020/9/2.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol STPageTopViewDelegate <NSObject>

-(void)onPageTopViewItemClick:(NSInteger)position;

@end

@interface STPageTopView : UIView

@property(weak, nonatomic)id<STPageTopViewDelegate> delegate;

-(instancetype)initWithTitles:(NSArray *)titles middleWidth:(CGFloat)middleWidth perWidth:(CGFloat)perWidth;
-(void)changeItem:(NSInteger)position;

@end

NS_ASSUME_NONNULL_END
