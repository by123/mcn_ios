//
//  StaticticsView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "StaticticsView.h"
#import "STDateBlockView.h"
#import "STPageView.h"
#import "AccountManager.h"
#import "StatisticsItemView.h"
#import "STTimeUtil.h"

@interface StaticticsView()<STDateBlockViewDelegate,STPageViewDelegate>

@property(strong, nonatomic)StaticticsViewModel *mViewModel;
@property(strong, nonatomic)STDateBlockView *dateBlockView;
@property(strong, nonatomic)STPageView *pageView;
@property(assign, nonatomic)NSInteger current;
@property(strong, nonatomic)NSMutableArray *itemViews;

@end

@implementation StaticticsView

-(instancetype)initWithViewModel:(StaticticsViewModel *)viewModel{
    if(self == [super init]){
        _current = 0;
        _mViewModel = viewModel;
        _mViewModel.startTime = [STTimeUtil getLastDates:7 format:@"yyyy-MM-dd"];
        _mViewModel.endTime = [STTimeUtil generateDate:[STTimeUtil getTimeStampWithDays:0] format:@"yyyy-MM-dd"];
        _itemViews = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}

-(void)initView{
    _dateBlockView = [[STDateBlockView alloc]initWithFrame:CGRectMake(STWidth(15), 0, STWidth(200), STHeight(42))];
    _dateBlockView.delegate = self;
    [_dateBlockView setController: [STWindowUtil currentController]];
    _dateBlockView.userInteractionEnabled = YES;
    [self addSubview:_dateBlockView];
    
    NSArray *titles = @[@"渠道",@"产品"];
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    CGRect frame = CGRectMake(0, STHeight(82), ScreenWidth, ContentHeight - STHeight(82));
    if(userModel.roleType == RoleType_Mcn){
        titles = @[@"合作",@"产品",@"主播"];
        StatisticsItemView *cooprateView = [[StatisticsItemView alloc]initWithType:StaticticsItemType_Cooperate statisticsType:_mViewModel.type startTime:_mViewModel.startTime endTime:_mViewModel.endTime vm:_mViewModel];
        cooprateView.frame = frame;
        [_itemViews addObject:cooprateView];
        
        StatisticsItemView *productView = [[StatisticsItemView alloc]initWithType:StaticticsItemType_Product statisticsType:_mViewModel.type startTime:_mViewModel.startTime endTime:_mViewModel.endTime vm:_mViewModel];
        productView.frame = frame;
        [_itemViews addObject:productView];
        
        StatisticsItemView *celebrityView = [[StatisticsItemView alloc]initWithType:StaticticsItemType_Celebrity statisticsType:_mViewModel.type startTime:_mViewModel.startTime endTime:_mViewModel.endTime vm:_mViewModel];
        celebrityView.frame = frame;
        [_itemViews addObject:celebrityView];
    }else{
        StatisticsItemView *channelView = [[StatisticsItemView alloc]initWithType:StaticticsItemType_Channel statisticsType:_mViewModel.type startTime:_mViewModel.startTime endTime:_mViewModel.endTime vm:_mViewModel];
        channelView.frame = frame;
        [_itemViews addObject:channelView];
        
        StatisticsItemView *productView = [[StatisticsItemView alloc]initWithType:StaticticsItemType_Product statisticsType:_mViewModel.type startTime:_mViewModel.startTime endTime:_mViewModel.endTime vm:_mViewModel];
        productView.frame = frame;
        [_itemViews addObject:productView];
        
    }
    
    _pageView = [[STPageView alloc]initWithFrame:CGRectMake(0, STHeight(42), ScreenWidth, ContentHeight - STHeight(42)) views:_itemViews titles:titles perLine:0.3f perWidth:STWidth(60)];
    _pageView.delegate = self;
    [self addSubview:_pageView];
}

-(void)onDateBlockSelected:(NSString *)startDate endDate:(NSString *)endDate{
    _mViewModel.startTime = startDate;
    _mViewModel.endTime = endDate;
    [self updateView];
}


-(void)onPageViewSelect:(NSInteger)position view:(id)view{
    _current = position;
    [self updateView];
}



-(void)updateView{
    if(!IS_NS_COLLECTION_EMPTY(_itemViews)){
        StatisticsItemView *itemView = [_itemViews objectAtIndex:_current];
        [itemView updateTime:_mViewModel.startTime endTime:_mViewModel.endTime];
        UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
        if(userModel.roleType == RoleType_Mcn){
            switch (_current) {
                case 0:
                    [itemView refreshData:StaticticsItemType_Cooperate];
                    break;
                case 1:
                    [itemView refreshData:StaticticsItemType_Product];
                    break;
                case 2:
                    [itemView refreshData:StaticticsItemType_Celebrity];
                    break;
                default:
                    break;
            }
        }
        else{
            switch (_current) {
                case 0:
                    [itemView refreshData:StaticticsItemType_Channel];
                    break;
                case 1:
                    [itemView refreshData:StaticticsItemType_Product];
                    break;
                    
                default:
                    break;
            }
        }
    }
}

@end

