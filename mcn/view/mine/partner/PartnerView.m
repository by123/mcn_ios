//
//  PartnerView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PartnerView.h"
#import "STPageView.h"
#import "PartnerItemView.h"

@interface PartnerView()<STPageViewDelegate>

@property(strong, nonatomic)PartnerViewModel *mViewModel;
@property(strong, nonatomic)STPageView *pageView;
@property(strong, nonatomic)NSMutableArray *views;
@property(assign, nonatomic)NSInteger current;

@end

@implementation PartnerView

-(instancetype)initWithViewModel:(PartnerViewModel *)viewModel{
    if(self == [super init]){
        _current = _mViewModel.type;
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _views = [[NSMutableArray alloc]init];
    PartnerItemView *view1 = [[PartnerItemView alloc]initWithType:PartnerType_All vm:_mViewModel];
    [_views addObject:view1];
    
    PartnerItemView *view2 = [[PartnerItemView alloc]initWithType:PartnerType_WaitSend vm:_mViewModel];
    [_views addObject:view2];
    
    PartnerItemView *view3 = [[PartnerItemView alloc]initWithType:PartnerType_WaitConfirm vm:_mViewModel];
    [_views addObject:view3];
    
    PartnerItemView *view4 = [[PartnerItemView alloc]initWithType:PartnerType_Cooperative vm:_mViewModel];
    [_views addObject:view4];
    
    PartnerItemView *view5 = [[PartnerItemView alloc]initWithType:PartnerType_Cancel vm:_mViewModel];
    [_views addObject:view5];
    

    _pageView = [[STPageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight) views:_views titles:@[@"全部",@"待发货",@"待确认",@"已合作",@"已取消"] perLine:0.3f];
    _pageView.delegate = self;
    [self addSubview:_pageView];
    
    [_pageView setCurrentTab:_mViewModel.type];
}


-(void)onPageViewSelect:(NSInteger)position view:(id)view{
    _current = position;
    if(!IS_NS_COLLECTION_EMPTY(_views)){
        PartnerItemView *view = _views[position];
        [view refreshNew];
    }
}

-(void)updateView{
    
}

-(void)reloadView{
    if(!IS_NS_COLLECTION_EMPTY(_views)){
          PartnerItemView *view = _views[_current];
          [view refreshNew];
      }
}

@end

