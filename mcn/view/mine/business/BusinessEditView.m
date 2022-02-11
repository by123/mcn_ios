//
//  BusinessEditView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "BusinessEditView.h"
#import "STBlankInView.h"
#import "STSelectInView.h"
#import "AccountManager.h"

@interface BusinessEditView()<STSelectInViewDelegate,STBlankInViewDelegate>

@property(strong, nonatomic)BusinessEditViewModel *mViewModel;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)STBlankInView *nameView;
@property(strong, nonatomic)STSelectInView *mobileView;
@property(strong, nonatomic)STBlankInView *douyinView;
@property(strong, nonatomic)STBlankInView *kuaishouView;
@property(strong, nonatomic)STSelectInView *headView;


@end

@implementation BusinessEditView

-(instancetype)initWithViewModel:(BusinessEditViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _headView = [[STSelectInView alloc]initWithTitle:@"头像" placeHolder:MSG_EMPTY frame:CGRectMake(0, 0, ScreenWidth, STHeight(60))];
    _headView.delegate = self;
    [_headView setRightArrow];
    _headView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(60));
    [self addSubview:_headView];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(300), STHeight(10), STHeight(40), STHeight(40))];
    _headImageView.backgroundColor = cline;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(20);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_headImageView];
    
    _nameView = [[STBlankInView alloc]initWithTitle:@"姓名" placeHolder:@"请输入姓名"];
    _nameView.frame = CGRectMake(0, STHeight(60), ScreenWidth, STHeight(60));
    _nameView.delegate = self;
    [self addSubview:_nameView];
    
    _mobileView = [[STSelectInView alloc]initWithTitle:@"手机号" placeHolder:@"请输入手机号" frame:CGRectMake(0, 0, ScreenWidth, STHeight(60))];
    _mobileView.frame = CGRectMake(0, STHeight(120), ScreenWidth, STHeight(60));
    _mobileView.delegate = self;
    [_mobileView setRightArrow];
    [self addSubview:_mobileView];
    
    _douyinView = [[STBlankInView alloc]initWithTitle:@"抖音号" placeHolder:@"请输入抖音号"];
    _douyinView.frame = CGRectMake(0, STHeight(180), ScreenWidth, STHeight(60));
    _douyinView.delegate = self;
    [self addSubview:_douyinView];
    
    _kuaishouView = [[STBlankInView alloc]initWithTitle:@"快手号" placeHolder:@"请输入快手号"];
    _kuaishouView.frame = CGRectMake(0, STHeight(240), ScreenWidth, STHeight(60));
    _kuaishouView.delegate = self;
    [_kuaishouView hiddenLine];
    [self addSubview:_kuaishouView];
}


-(void)onSelectClicked:(id)selectInView{
    if(selectInView == _headView){
        [_mViewModel selectImage];
    }else if(selectInView == _mobileView){
        [_mViewModel goUpdatePhonePage];
    }
    [_nameView resign];
    [_douyinView resign];
    [_kuaishouView resign];
}

-(void)onTextFieldDidChange:(id)view{
    if(view == _nameView){
        _mViewModel.model.mchName = [_nameView getContent];
    }else if(view == _mobileView){
        _mViewModel.model.contactPhone = [_mobileView getContent];
    }else if(view == _douyinView){
        _mViewModel.model.douyinAccount = [_douyinView getContent];
    }else if(view == _kuaishouView){
        _mViewModel.model.kuaishouAccount = [_kuaishouView getContent];
    }
}

-(void)updateView{
    BusinessModel *model =  _mViewModel.model;
    [_nameView setContent:model.mchName];
    [_mobileView setContent:model.contactPhone];
    [_douyinView setContent:model.douyinAccount];
    [_kuaishouView setContent:model.kuaishouAccount];
    
    if(!IS_NS_STRING_EMPTY(model.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picFullUrl]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
}

-(void)updateHeadImage:(NSString *)headUrl{
    if(!IS_NS_STRING_EMPTY(headUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:headUrl]];
    }}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameView resign];
    [_douyinView resign];
    [_kuaishouView resign];
}

-(void)updatePhone{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    [_mobileView setContent:userModel.mobile];
}

@end

