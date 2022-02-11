//
//  ChangeAccountView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "ChangeAccountView.h"
#import "ChangeAccountViewCell.h"
#import "AccountManager.h"
#import "STDialog.h"

@interface ChangeAccountView()<UITableViewDelegate,UITableViewDataSource,STDialogDelegate>

@property(strong, nonatomic)ChangeAccountViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIButton *addBtn;
@property(strong, nonatomic)STDialog *dialog;

@end

@implementation ChangeAccountView

-(instancetype)initWithViewModel:(ChangeAccountViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initTableView];
    
    _addBtn = [[UIButton alloc]init];
    _addBtn.backgroundColor = cwhite;
    _addBtn.layer.cornerRadius = 2;
    _addBtn.layer.shadowColor = [UIColor colorWithRed:53/255.0 green:54/255.0 blue:72/255.0 alpha:0.06].CGColor;
    _addBtn.layer.shadowOffset = CGSizeMake(0,0);
    _addBtn.layer.shadowOpacity = 1;
    _addBtn.layer.shadowRadius = 13;
    [_addBtn addTarget:self action:@selector(onAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(19), STHeight(19), STHeight(49), STHeight(49))];
    addImageView.image = [UIImage imageNamed:IMAGE_CHANGE_ACCOUNT_ADD];
    addImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_addBtn addSubview:addImageView];
    
    UILabel *addLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:@"使用新账号" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize addSize = [addLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    addLabel.frame = CGRectMake(STWidth(87), 0, addSize.width, STHeight(87));
    [_addBtn addSubview:addLabel];
    
    [self updateView];
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = cbg2;
    [_tableView useDefaultProperty];
    
    [self addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserModel *currentModel = [[AccountManager sharedAccountManager] getUserModel];
    UserModel *userModel = [_mViewModel.datas objectAtIndex:indexPath.row];
    if([currentModel.userId isEqualToString:userModel.userId]){
        return STHeight(139);
        
    }else{
        return STHeight(120);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChangeAccountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChangeAccountViewCell identify]];
    if(!cell){
        cell = [[ChangeAccountViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ChangeAccountViewCell identify]];
    }
    cell.backgroundColor = cbg2;
    cell.clearBtn.tag = indexPath.row;
    [cell.clearBtn addTarget:self action:@selector(onClearBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] clearStatu:_mViewModel.clearStatu];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserModel *currentModel = [[AccountManager sharedAccountManager] getUserModel];
    UserModel *userModel = [_mViewModel.datas objectAtIndex:indexPath.row];
    if([currentModel.userId isEqualToString:userModel.userId]){
        [LCProgressHUD showMessage:@"当前账号已经登录"];
    }else{
        if(!_mViewModel.clearStatu){
            [STUserDefaults saveKeyValue:UD_USERNAME value:userModel.mobile];
            [_mViewModel changeAccount:indexPath.row];
        }
    }
}


-(void)updateView{
    CGFloat height = (_mViewModel.datas.count - 1) * STHeight(120) + STHeight(139);
    if(height > ContentHeight - STHeight(120)){
        height = ContentHeight - STHeight(120);
    }
    _tableView.frame = CGRectMake(0, 0, ScreenWidth,height);
    _addBtn.frame = CGRectMake(STWidth(15), height + STHeight(15), STWidth(345), STHeight(87));
    [_tableView reloadData];
}


/********************** tableview ****************************/

-(void)onClearBtnClicked:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    _dialog = [[STDialog alloc]initWithTitle:@"是否删除账号" content:@"是否确认删除此账号" subContent:MSG_EMPTY size:CGSizeMake(STWidth(255), STHeight(188))];
    [_dialog showConfirmBtn:YES cancelBtn:YES];
    _dialog.delegate = self;
    _dialog.paramInt = tag;
    [STWindowUtil addWindowView:_dialog];
}

-(void)onConfirmBtnClicked:(id)dialog{
    NSInteger tag = ((STDialog *)dialog).paramInt;
    [(STDialog *)dialog removeFromSuperview];
    [_mViewModel clearUser:tag];
}

-(void)onCancelBtnClicked:(id)dialog{
    [(STDialog *)dialog removeFromSuperview];
}

-(void)onAddBtnClick{
    [_mViewModel addNewAccount];
}

@end

