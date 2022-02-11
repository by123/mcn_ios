//
//  HomeListView.h
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HomeListViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface HomeListView : UIView

-(instancetype)initWithType:(NSString *)goodClass vm:(MainViewModel *)mainVM;

@property(weak, nonatomic)id<HomeListViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
