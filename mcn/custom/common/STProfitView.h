//
//  STProfitView.h
//  manage
//
//  Created by by.huang on 2019/7/12.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STProfitViewDelegate

-(void)onChangeProfitView:(Boolean)isRelative;
-(void)onProfitTextFieldDidChange;

@end

@interface STProfitView : UIView

-(instancetype)initWithFrame:(CGRect)frame totalPercent:(double)totalPercent allocPercent:(double)allocPercent;

@property(weak, nonatomic)id delegate;
@property(assign, nonatomic)Boolean isRelative;
@property(strong, nonatomic)UITextField *realPercentTF;
-(void)resignFirstResponder;

-(NSString *)getProfitPool;
-(NSString *)getProfitPercentInPool;
-(NSString *)getProfitPercent;

-(void)changeAbsoluteProfitView;
-(void)setProfitPercent:(NSString *)percentStr;
-(void)hiddenRelative:(Boolean)hidden;
-(Boolean)isProfitFill;
-(void)updateTips:(double)totalPercent allocPercent:(double)allocPercent;

@end

