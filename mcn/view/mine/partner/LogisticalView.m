//
//  LogisticalView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "LogisticalView.h"
#import "STBlankInView.h"

@interface LogisticalView()

@property(strong, nonatomic)LogisticalViewModel *mViewModel;

@end

@implementation LogisticalView

-(instancetype)initWithViewModel:(LogisticalViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
    }
    return self;
}



-(void)updateView{
    STBlankInView *nameView = [[STBlankInView alloc]initWithTitle:@"物流公司名称" placeHolder:MSG_EMPTY];
    nameView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(60));
    [nameView setContent:_mViewModel.model.expressCompanyName];
    [self addSubview:nameView];
    
    STBlankInView *numberView = [[STBlankInView alloc]initWithTitle:@"物流单号" placeHolder:MSG_EMPTY];
    numberView.frame = CGRectMake(0, STHeight(60), ScreenWidth, STHeight(60));
    [numberView setContent:_mViewModel.model.expressNumber];
    [self addSubview:numberView];
}


@end

