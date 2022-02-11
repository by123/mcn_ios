//
//  STSideView.h
//  cigarette
//
//  Created by by.huang on 2019/12/20.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol STSideViewDelegate

-(void)onSideViewSelect:(NSInteger)position;

@end

@interface STSideView : UIView

@property(weak, nonatomic)id<STSideViewDelegate> delegate;

-(instancetype)initWithTitle:(NSString *)title;
-(void)setDatas:(NSMutableArray *)datas;
-(void)show;
-(void)hidden;
-(void)updateView;

@end

NS_ASSUME_NONNULL_END
