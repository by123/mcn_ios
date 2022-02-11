//
//  QulificationsEditView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "QulificationsEditView.h"
#import "STBlankInView.h"
#import "STDefaultBtnView.h"
#import "STAddImageView.h"
#import "TouchScrollView.h"
#import "UITextView+Placeholder.h"
#import "PreviewModel.h"

@interface QulificationsEditView()<STDefaultBtnViewDelegate,STAddImageViewDelegate,TouchScrollViewDelegate,STBlankInViewDelegate,UITextViewDelegate,UITextFieldDelegate>

@property(strong, nonatomic)QulificationsEditViewModel *qulificationsVM;
@property(strong, nonatomic)TouchScrollView *scrollView;
@property(strong, nonatomic)STBlankInView *nameView;
@property(strong, nonatomic)STBlankInView *idView;
@property(strong, nonatomic)STDefaultBtnView *commitBtn;
@property(strong, nonatomic)STAddImageView *addImageView;
@property(strong, nonatomic)UIButton *frontBtn;
@property(strong, nonatomic)UIButton *backBtn;
@property(strong, nonatomic)UITextView *descriptionTV;
@property(assign, nonatomic)CGFloat y;
@property(strong, nonatomic)UIView *descriptionView;
@property(assign, nonatomic)Boolean isTFEdit;

@end

@implementation QulificationsEditView

-(instancetype)initWithViewModel:(QulificationsEditViewModel *)viewModel{
    if(self == [super init]){
        _qulificationsVM = viewModel;
        [self initView];
        if(_qulificationsVM.isEdit){
            [self updateView];
        }
    }
    return self;
}

-(void)initView{
    _scrollView = [[TouchScrollView alloc]initWithParentView:self delegate:self];
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(80));
    [self addSubview:_scrollView];
    
    [self initInfoView];
    [self initBusinessLicenseView];
    [self initIdentifyView];
    [self initDescriptionView];
    
    [_scrollView setContentSize:CGSizeMake(ScreenWidth, _qulificationsVM.roleType == RoleType_Celebrity ? STHeight(605) : STHeight(787))];
    
    _commitBtn = [[STDefaultBtnView alloc]initWithTitle:@"提交认证"];
    _commitBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    _commitBtn.delegate = self;
    [_commitBtn setActive:NO];
    [self addSubview:_commitBtn];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _isTFEdit = YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    _isTFEdit = NO;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    if(!_isTFEdit){
        _y = self.frame.origin.y;
        WS(weakSelf)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CGRect rect = [weakSelf.descriptionView.superview convertRect:weakSelf.descriptionView.frame toView:weakSelf];//获取相对于self的位置
            NSDictionary *userInfo = [notification userInfo];
            NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];//获取弹出键盘的fame的value值
            CGRect keyboardRect = [aValue CGRectValue];
            keyboardRect = [weakSelf convertRect:keyboardRect fromView:weakSelf.window];//获取键盘相对于self的frame ，传window和传nil是一样的
            CGFloat keyboardTop = keyboardRect.origin.y;
            NSNumber * animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];//获取键盘弹出动画时间值
            NSTimeInterval animationDuration = [animationDurationValue doubleValue];
            if (keyboardTop < CGRectGetMaxY(rect)) {//如果键盘盖住了输入框
                CGFloat gap = keyboardTop - CGRectGetMaxY(rect) - 10;//计算需要网上移动的偏移量（输入框底部离键盘顶部为10的间距）
                [UIView animateWithDuration:animationDuration animations:^{
                    weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, gap, weakSelf.frame.size.width, weakSelf.frame.size.height);
                }];
            }
        });
    }
}


- (void)keyboardWillHide:(NSNotification *)notification{
    if(!_isTFEdit){
        WS(weakSelf)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSDictionary *userInfo = [notification userInfo];
//            NSNumber * animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];//获取键盘隐藏动画时间值
//            NSTimeInterval animationDuration = [animationDurationValue doubleValue];
//            [UIView animateWithDuration:0.3f animations:^{
                weakSelf.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
//            }];
        });
    }
}

-(void)onScrollViewDidScroll:(UIScrollView *)scrollView{
    _isTFEdit = NO;
    [_descriptionTV resignFirstResponder];
    [self keyboardWillHide:nil];
}

//基本信息
-(void)initInfoView{
    UIView *infoView = [self buildContentView:@"基本信息" height:STHeight(160) top:0];
    [_scrollView addSubview:infoView];
    
    _nameView = [[STBlankInView alloc]initWithTitle:_qulificationsVM.roleType == RoleType_Celebrity ? @"姓名" : @"企业名称" placeHolder:_qulificationsVM.roleType == RoleType_Celebrity ? @"请输入姓名" : @"请输入企业名称"];
    _nameView.frame = CGRectMake(0, STHeight(36), ScreenWidth, STHeight(62));
    _nameView.delegate = self;
    _nameView.contentTF.delegate = self;
    [infoView addSubview:_nameView];
    
    _idView = [[STBlankInView alloc]initWithTitle:_qulificationsVM.roleType == RoleType_Celebrity ? @"身份证号码" : @"营业执照编码" placeHolder:_qulificationsVM.roleType == RoleType_Celebrity ? @"请输入身份证号码" : @"请输入营业执照编码"];
    _idView.frame = CGRectMake(0, STHeight(98), ScreenWidth, STHeight(62));
    _idView.delegate = self;
    _idView.contentTF.delegate = self;
    [_idView hiddenLine];
    [infoView addSubview:_idView];
    
}


//营业执照
-(void)initBusinessLicenseView{
    if(_qulificationsVM.roleType == RoleType_Celebrity) return;
    UIView *businessLicenseView = [self buildContentView:@"营业执照" height:STHeight(167) top:STHeight(175)];
    [_scrollView addSubview:businessLicenseView];
    
    _addImageView = [[STAddImageView alloc]initWithImages:nil];
    _addImageView.frame = CGRectMake(0, STHeight(42), ScreenWidth, STHeight(125));
    _addImageView.delegate = self;
    [businessLicenseView addSubview:_addImageView];
    
}

-(void)onAddImageViewItemClick:(NSInteger)position view:(nonnull id)view{
    if(position + 1 < _addImageView.imageDatas.count){
        [self restoreLisenceDatas];
        PreviewModel *model =  _qulificationsVM.licenseDatas[position];
        model.isSelect = YES;
        [_qulificationsVM goPreviewPage:_qulificationsVM.licenseDatas previewType:PreviewImageType_BusinessLicense];
    }else{
        [_qulificationsVM openPhotoDialog:PreviewImageType_BusinessLicense identifyType:IdentifyType_Other];
    }
}



//身份证
-(void)initIdentifyView{
    UIView *identifyView = [self buildContentView:_qulificationsVM.roleType == RoleType_Celebrity ? @"身份证正反面" : @"法定代表人身份证" height:STHeight(200) top:_qulificationsVM.roleType == RoleType_Celebrity ? STHeight(175) : STHeight(357)];
    [_scrollView addSubview:identifyView];
    
    _frontBtn = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(57), STWidth(150), STHeight(95))];
    [_frontBtn setImage:[UIImage imageNamed:IMAGE_IDETIFY_FRONT] forState:UIControlStateNormal];
    _frontBtn.contentMode = UIViewContentModeScaleAspectFill;
    _frontBtn.layer.cornerRadius = 1;
    _frontBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _frontBtn.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _frontBtn.layer.shadowOffset = CGSizeMake(0,2);
    _frontBtn.layer.shadowOpacity = 1;
    _frontBtn.layer.shadowRadius = 10;
    [_frontBtn addTarget:self action:@selector(onFrontBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [identifyView addSubview:_frontBtn];
    
    UILabel *frontLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:@"头像面" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    frontLabel.frame = CGRectMake(STWidth(15), STHeight(162), STWidth(150), STHeight(17));
    [identifyView addSubview:frontLabel];
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(195), STHeight(57), STWidth(150), STHeight(95))];
    [_backBtn setImage:[UIImage imageNamed:IMAGE_IDETIFY_BACK] forState:UIControlStateNormal];
    _backBtn.contentMode = UIViewContentModeScaleAspectFill;
    _backBtn.layer.cornerRadius = 1;
    _backBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _backBtn.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _backBtn.layer.shadowOffset = CGSizeMake(0,2);
    _backBtn.layer.shadowOpacity = 1;
    _backBtn.layer.shadowRadius = 10;
    [_backBtn addTarget:self action:@selector(onBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [identifyView addSubview:_backBtn];
    
    UILabel *backLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:@"国徽面" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    backLabel.frame = CGRectMake(STWidth(195), STHeight(162), STWidth(150), STHeight(17));
    [identifyView addSubview:backLabel];
}

-(void)onFrontBtnClick{
    [STLog print:@"头像面"];
    NSString *imgUrl = [self getPhoto:0];
    if(IS_NS_STRING_EMPTY(imgUrl)){
        [_qulificationsVM openPhotoDialog:PreviewImageType_Identify identifyType:IdentifyType_Front];
    }else{
        [self restoreIdentifyDatas];
        PreviewModel *model;
        for(PreviewModel *data in _qulificationsVM.identifyDatas){
            if(data.position == 0){
                model = data;
            }
        }
        model.imgUrl = imgUrl;
        model.isSelect = YES;
        [_qulificationsVM goPreviewPage:_qulificationsVM.identifyDatas previewType:PreviewImageType_Identify];
    }
}

-(void)onBackBtnClick{
    [STLog print:@"国徽面"];
    NSString *imgUrl = [self getPhoto:1];
    if(IS_NS_STRING_EMPTY(imgUrl)){
        [_qulificationsVM openPhotoDialog:PreviewImageType_Identify identifyType:IdentifyType_Back];
    }else{
        [self restoreIdentifyDatas];
        PreviewModel *model;
        for(PreviewModel *data in _qulificationsVM.identifyDatas){
            if(data.position == 1){
                model = data;
            }
        }
        model.imgUrl = imgUrl;
        model.isSelect = YES;
        [_qulificationsVM goPreviewPage:_qulificationsVM.identifyDatas previewType:PreviewImageType_Identify];
    }
    
}

-(NSString *)getPhoto:(int)position{
    if(!IS_NS_COLLECTION_EMPTY(_qulificationsVM.identifyDatas)){
        for(PreviewModel *model in _qulificationsVM.identifyDatas){
            if(model.position == position){
                return model.imgUrl;
            }
        }
    }
    return MSG_EMPTY;
}

-(void)restoreLisenceDatas{
    if(!IS_NS_COLLECTION_EMPTY(_qulificationsVM.licenseDatas)){
        for(PreviewModel *model in _qulificationsVM.licenseDatas){
            model.isSelect = NO;
        }
    }
}

-(void)restoreIdentifyDatas{
    if(!IS_NS_COLLECTION_EMPTY(_qulificationsVM.identifyDatas)){
        for(PreviewModel *model in _qulificationsVM.identifyDatas){
            model.isSelect = NO;
        }
    }
}


//介绍
-(void)initDescriptionView{
    _descriptionView = [self buildContentView:@"介绍" height:STHeight(200) top:_qulificationsVM.roleType == RoleType_Celebrity ? STHeight(390) : STHeight(572)];
    [_scrollView addSubview:_descriptionView];
    
    UIView *descriptionContentView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(57), STWidth(345), STHeight(125))];
    descriptionContentView.backgroundColor = cbg;
    [_descriptionView addSubview:descriptionContentView];
    
    _descriptionTV = [[UITextView alloc]initWithFrame:CGRectMake(STWidth(10), STHeight(5), STWidth(325), STHeight(115))];
    _descriptionTV.font = [UIFont fontWithName:FONT_REGULAR size:STFont(15)];
    _descriptionTV.textColor = c10;
    _descriptionTV.backgroundColor = cbg;
    _descriptionTV.delegate = self;
    [_descriptionTV setPlaceholder:@"请输入内容介绍" placeholdColor:c03];
    _descriptionTV.showsHorizontalScrollIndicator = NO;
    _descriptionTV.showsVerticalScrollIndicator = NO;
    [descriptionContentView addSubview:_descriptionTV];
}



//创建容器
-(UIView *)buildContentView:(NSString *)title height:(CGFloat)height top:(CGFloat)top{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, top, ScreenWidth, height)];
    view.backgroundColor = cwhite;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(16)] text:title textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(15), titleSize.width, STHeight(22));
    [view addSubview:titleLabel];
    return view;
}


//更新营业执照图片
-(void)updateViewBusinessLicense{
    [_addImageView setDatas:_qulificationsVM.licenseDatas];
    [self checkButton];
}



//更新身份证图片
-(void)updateViewIdentify{
    NSString *frontImageUrl;
    NSString *backImageUrl;
    if(!IS_NS_COLLECTION_EMPTY(_qulificationsVM.identifyDatas)){
        for(PreviewModel *model in _qulificationsVM.identifyDatas){
            if(model.position == 0){
                frontImageUrl = model.imgUrl;
            }else if(model.position == 1){
                backImageUrl = model.imgUrl;
            }
        }
    }
    if(IS_NS_STRING_EMPTY(frontImageUrl)){
        [_frontBtn setImage:[UIImage imageNamed:IMAGE_IDETIFY_FRONT] forState:UIControlStateNormal];
    }else{
        [_frontBtn sd_setImageWithURL:[NSURL URLWithString:frontImageUrl] forState:UIControlStateNormal];
    }
    if(IS_NS_STRING_EMPTY(backImageUrl)){
        [_backBtn setImage:[UIImage imageNamed:IMAGE_IDETIFY_BACK] forState:UIControlStateNormal];
    }else{
        [_backBtn sd_setImageWithURL:[NSURL URLWithString:backImageUrl] forState:UIControlStateNormal];
    }
    [self checkButton];
}

-(void)updateView{
    if(!IS_NS_STRING_EMPTY(_qulificationsVM.model.name)){
        [_nameView setContent:_qulificationsVM.model.name];
        [_commitBtn setTitle:@"变更认证"];
    }
    if(!IS_NS_STRING_EMPTY(_qulificationsVM.model.number)){
        [_idView setContent:_qulificationsVM.model.number];
    }
    if(!IS_NS_STRING_EMPTY(_qulificationsVM.model.remark)){
        _descriptionTV.text = _qulificationsVM.model.remark;
    }
    if(!IS_NS_COLLECTION_EMPTY(_qulificationsVM.model.orgNumberUrlList)){
        for(int i = 0 ; i < _qulificationsVM.model.orgNumberUrlList.count ; i ++){
            PreviewModel *model = [PreviewModel build:_qulificationsVM.model.orgNumberFullUrlList[i] imgSrc:_qulificationsVM.model.orgNumberUrlList[i] isSelect:NO];
            [_qulificationsVM.licenseDatas addObject:model];
        }
    }
    if(!IS_NS_STRING_EMPTY(_qulificationsVM.model.idcardHeadUrl) && !IS_NS_STRING_EMPTY(_qulificationsVM.model.idcardHeadFullUrl)){
        PreviewModel *model = [PreviewModel build:_qulificationsVM.model.idcardHeadFullUrl imgSrc:_qulificationsVM.model.idcardHeadUrl isSelect:NO position:0];
        [_qulificationsVM.identifyDatas addObject:model];
    }
    if(!IS_NS_STRING_EMPTY(_qulificationsVM.model.idcardBackUrl) && !IS_NS_STRING_EMPTY(_qulificationsVM.model.idcardBackFullUrl)){
        PreviewModel *model = [PreviewModel build:_qulificationsVM.model.idcardBackFullUrl imgSrc:_qulificationsVM.model.idcardBackUrl isSelect:NO position:1];
        [_qulificationsVM.identifyDatas addObject:model];
    }
    
    
    [self updateViewIdentify];
    [self updateViewBusinessLicense];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameView resign];
    [_idView resign];
    [_descriptionTV resignFirstResponder];
}

-(void)checkButton{
    if(IS_NS_STRING_EMPTY([_nameView getContent])){
        [_commitBtn setActive:NO];
        return;
    }
    if(IS_NS_STRING_EMPTY([_idView getContent])){
        [_commitBtn setActive:NO];
        return;
    }
    if(IS_NS_STRING_EMPTY(_descriptionTV.text)){
        [_commitBtn setActive:NO];
        return;
    }
    if([_qulificationsVM.identifyDatas count] < 2){
        [_commitBtn setActive:NO];
        return;
    }
    if(_qulificationsVM.roleType != RoleType_Celebrity){
        if([_qulificationsVM.licenseDatas count] > 0){
            [_commitBtn setActive:YES];
        }else{
            [_commitBtn setActive:NO];
        }
        return;
    }
    [_commitBtn setActive:YES];
}


-(void)onTextFieldDidChange:(id)view{
    [self checkButton];
}

-(void)textViewDidChange:(UITextView *)textView{
    [self checkButton];
}

-(void)onDefaultBtnClick{
    _qulificationsVM.model.name = [_nameView getContent];
    _qulificationsVM.model.number = [_idView getContent];
    _qulificationsVM.model.remark = _descriptionTV.text;
    [_qulificationsVM commitAuthenticate];
}




@end

