//
//  PreviewPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PreviewPage.h"
#import "PreviewView.h"

@interface PreviewPage()<PreviewViewDelegate>

@property(strong, nonatomic)PreviewView *previewView;
@property(strong, nonatomic)PreviewViewModel *viewModel;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)PreviewImageType previewType;

@end

@implementation PreviewPage

+(void)show:(BaseViewController *)controller datas:(NSMutableArray *)datas previewType:(PreviewImageType)previewType{
    PreviewPage *page = [[PreviewPage alloc]init];
    page.datas = datas;
    page.previewType = previewType;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideNavigationBar:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)initView{
    [self initNavigationBar];
    _viewModel = [[PreviewViewModel alloc]init];
    _viewModel.datas = _datas;
    _viewModel.previewType = _previewType;
    _viewModel.delegate = self;
    self.view.backgroundColor = cblack;
    
    _previewView =[[PreviewView alloc]initWithViewModel:_viewModel];
    _previewView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_previewView];
}

-(void)initNavigationBar{
    NSString *titleStr = MSG_EMPTY;
    NSString *rightBtnStr = @"删除";
    
    if(_previewType == PreviewImageType_Identify){
        titleStr = @"身份证";
    }else if(_previewType == PreviewImageType_BusinessLicense){
        titleStr = @"营业执照";
    }else if(_previewType == PreviewImageType_Photo){
        titleStr = @"产品相册";
    }else if(_previewType == PreviewImageType_Detail){
        titleStr = @"产品详情";
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(16)] text:titleStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    titleLabel.frame =  CGRectMake(0, StatuBarHeight, ScreenWidth, STHeight(44));
    [self.view addSubview:titleLabel];
    
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, StatuBarHeight, STWidth(64), STHeight(44));
    [backBtn setImage:[UIImage imageNamed:IMAGE_LIGHT_BACK] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(onBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *deleteBtn = [[UIButton alloc]initWithFont:STFont(15) text:rightBtnStr textColor:cwhite backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    deleteBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)];
    CGSize size = [rightBtnStr sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    CGFloat width = size.width + STWidth(20);
    deleteBtn.frame = CGRectMake(ScreenWidth - width- STWidth(15), StatuBarHeight, width, STHeight(44));
    [deleteBtn addTarget:self action:@selector(onDeleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    
}

-(void)onBackBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onDeleteBtnClick{
    if(!IS_NS_COLLECTION_EMPTY(_viewModel.datas)){
        for(PreviewModel *model in _viewModel.datas){
            if(model.isSelect){
                if(IS_NS_STRING_EMPTY(model.imgUrl)){
                    [LCProgressHUD showMessage:@"照片未上传"];
                }else{
                    [_viewModel.datas removeObject:model];
                }
                break;
            }
        }
    }
    if(_viewModel.datas.count > 0){
        PreviewModel *model = _viewModel.datas [0];
        model.isSelect = YES;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    [_previewView updateView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

