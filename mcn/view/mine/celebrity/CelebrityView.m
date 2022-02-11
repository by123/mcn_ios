//
//  CelebrityView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "CelebrityView.h"
#import "STPageView.h"
#import "CelebrityListView.h"

@interface CelebrityView()<STPageViewDelegate>

@property(strong, nonatomic)CelebrityViewModel *mViewModel;
@property(strong, nonatomic)STPageView *pageView;
@property(strong, nonatomic)CelebrityListView *memberView;
@property(strong, nonatomic)CelebrityListView *inviteView;
@property(assign, nonatomic)NSInteger current;


@end

@implementation CelebrityView

-(instancetype)initWithViewModel:(CelebrityViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    NSArray *titles = @[@"成员",@"邀请的主播"];

    _memberView = [[CelebrityListView alloc]initWithType:0 vm:_mViewModel];
    _memberView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(38));
    
    _inviteView = [[CelebrityListView alloc]initWithType:1 vm:_mViewModel];
    _inviteView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(38));
    
    NSMutableArray *views = [[NSMutableArray alloc]init];
    [views addObject:_memberView];
    [views addObject:_inviteView];
    
    _pageView = [[STPageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight) views:views titles:titles perLine:0.4f perWidth:STWidth(80)];
    _pageView.delegate = self;
    [self addSubview:_pageView];
}


-(void)updateView{
    if(_current == 0){
        [_memberView refreshNew];
    }else{
        [_inviteView refreshNew];
    }
}

-(void)onPageViewSelect:(NSInteger)position view:(id)view{
    _current = position;
    if(position == 0){
        [_memberView refreshNew];
    }else{
        [_inviteView refreshNew];
    }
}

@end

