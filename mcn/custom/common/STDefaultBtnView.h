//
//  STDefaultBtnView.h
//  cigarette
//
//  Created by by.huang on 2019/9/9.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol STDefaultBtnViewDelegate

-(void)onDefaultBtnClick;

@end

@interface STDefaultBtnView : UIView

-(instancetype)initWithTitle:(NSString *)title;

@property(weak, nonatomic)id <STDefaultBtnViewDelegate>delegate;

-(void)setActive:(Boolean)active;
-(Boolean)getActive;
-(void)setTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
