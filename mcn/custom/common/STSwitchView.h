//
//  STSwitchView.h
//  framework
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SWITCH_NEXT @"switch_next"
#define SWITCH_REMOVE @"switch_remove"

@protocol STSwitchViewDelegate

-(void)onSwitchStatuChange:(Boolean)on tag:(NSInteger)tag view:(id)switchView;

@end

@interface STSwitchView : UIView

@property(weak, nonatomic)id<STSwitchViewDelegate> delegate;
@property(assign, nonatomic)Boolean on;
@property(copy, nonatomic)NSString *flag;

-(void)setOn:(Boolean)on;

@end
