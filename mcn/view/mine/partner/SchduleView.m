//
//  SchduleView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "SchduleView.h"
#import "STDashLine.h"
#import "STTimeUtil.h"

@interface SchduleView()

@property(strong, nonatomic)SchduleViewModel *mViewModel;

@end

@implementation SchduleView

-(instancetype)initWithViewModel:(SchduleViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:_mViewModel.cooperationName textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize nameSize = [nameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    nameLabel.frame = CGRectMake(STWidth(15), STHeight(15), nameSize.width, STHeight(25));
    [self addSubview:nameLabel];
    
    UILabel *idLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:[NSString stringWithFormat:@"合作编号：%@",_mViewModel.cooperationId] textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize idSize = [idLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    idLabel.frame = CGRectMake(STWidth(15), STHeight(45), idSize.width, STHeight(21));
    [self addSubview:idLabel];
}

-(void)updateView{
    NSMutableArray *datas = _mViewModel.datas;
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        for(int i = 0 ; i < datas.count ; i ++){
            ScheduleModel *model = datas[i];
            
            STDashLine *line = [[STDashLine alloc] initWithFrame:CGRectMake(STWidth(20), STHeight(100) + STHeight(88) * i, 1, STHeight(88)) withLineLength:2 withLineSpacing:2 withLineColor:c05];
            [self addSubview:line];
            
            UIView *view = [[UIView alloc]init];
            view.layer.masksToBounds = YES;
            [self addSubview:view];
            if(i == 0){
                view.frame = CGRectMake(STWidth(15), STHeight(100) + STHeight(88) * i, STHeight(12), STHeight(12));
                view.backgroundColor =  c16 ;
                view.layer.cornerRadius = STHeight(6);
            }else{
                view.frame = CGRectMake(STWidth(17.5), STHeight(100) + STHeight(88) * i, STHeight(6), STHeight(6));
                view.backgroundColor =  c11 ;
                view.layer.cornerRadius = STHeight(3);
            }
            UILabel *timeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:[STTimeUtil generateDate:model.createTime format:MSG_DATE_FORMAT_ALL] textAlignment:NSTextAlignmentCenter textColor:c05 backgroundColor:nil multiLine:NO];
            CGSize timeSize = [timeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
            timeLabel.frame = CGRectMake(STWidth(37), STHeight(93) + STHeight(88) * i, timeSize.width, STHeight(21));
            [self addSubview:timeLabel];
            
            UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:model.optDesc textAlignment:NSTextAlignmentCenter textColor:c05 backgroundColor:nil multiLine:NO];
            CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
            titleLabel.frame = CGRectMake(STWidth(37), STHeight(118) + STHeight(88) * i, titleSize.width, STHeight(20));
            [self addSubview:titleLabel];
            
            if(i == 0){
                timeLabel.textColor = c10;
                titleLabel.textColor = c10;
            }
            
        }
    }
}

@end

