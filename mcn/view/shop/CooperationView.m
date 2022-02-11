//
//  CooperationView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "CooperationView.h"
#import "CooperationViewCell.h"
#import "AccountManager.h"

@interface CooperationView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)CooperationViewModel *mViewModel;
@property(strong, nonatomic)UIButton *addressBtn;
@property(strong, nonatomic)UILabel *addressLabel;
@property(strong, nonatomic)UIImageView *addressImageView;
@property(strong, nonatomic)UILabel *defaultLabel;
@property(strong, nonatomic)UILabel *contactLabel;

@property(strong, nonatomic)UITableView *tableView;

@property(strong, nonatomic)UILabel *totalLabel;

@end

@implementation CooperationView

-(instancetype)initWithViewModel:(CooperationViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initContentView];
    [self initBottomView];
}

-(void)initContentView{
    _addressBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(70))];
    _addressBtn.backgroundColor = cwhite;
    [_addressBtn addTarget:self action:@selector(onAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addressBtn];
    
    _addressLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:@"暂无地址" textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    CGSize noAddressSize = [_addressLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _addressLabel.frame = CGRectMake(STWidth(15), STHeight(15), noAddressSize.width, STHeight(21));
    [_addressBtn addSubview:_addressLabel];
    
    _defaultLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(10)] text:@"默认" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c16 multiLine:NO];
    _defaultLabel.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(41), STHeight(20));
    _defaultLabel.hidden = YES;
    _defaultLabel.layer.masksToBounds = YES;
    _defaultLabel.layer.cornerRadius = 4;
    [_addressBtn addSubview:_defaultLabel];
    
    _contactLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [_addressBtn addSubview:_contactLabel];
    
    
    _addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, STHeight(66), ScreenWidth, STHeight(4))];
    _addressImageView.image = [UIImage imageNamed:IMAGE_ADDRESS_MASK];
    _addressImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_addressBtn addSubview:_addressImageView];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STHeight(20) - STWidth(15), STHeight(16), STHeight(20), STHeight(20))];
    arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_addressBtn addSubview:arrowImageView];
    
    [self initTableView];
}

-(void)onAddressBtnClick{
    [_mViewModel goAddressPage:_mViewModel.addressModel.addressId];
}


-(void)initBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(70), ScreenWidth, STHeight(70))];
    bottomView.backgroundColor = cwhite;
    bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0,2);
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowRadius = 10;
    [self addSubview:bottomView];
    
    int count = 0;
    for(ShopModel *shopModel in _mViewModel.datas){
        for(ShopSkuModel *skuModel in shopModel.skuModels){
            count++;
        }
    }
    _totalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)] text:[NSString stringWithFormat:@"合计：\n%d件商品",count] textAlignment:NSTextAlignmentRight textColor:c10 backgroundColor:nil multiLine:YES];
    CGSize totalSize = [_totalLabel.text sizeWithMaxWidth:STWidth(100) font:STFont(14) fontName:FONT_SEMIBOLD];
    _totalLabel.frame = CGRectMake(ScreenWidth - STWidth(226), STHeight(16), STWidth(100), totalSize.height);
    [bottomView addSubview:_totalLabel];
    
    UIButton *cooperateBtn = [[UIButton alloc]initWithFont:STFont(15) text:@"提交合作" textColor:cwhite backgroundColor:c16 corner:4 borderWidth:0 borderColor:nil];
    cooperateBtn.frame = CGRectMake(STWidth(260), STHeight(15), STWidth(100), STHeight(40));
    [cooperateBtn addTarget:self action:@selector(onCommitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cooperateBtn];
}


-(void)onCommitBtnClick{
    [_mViewModel commit];
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(85), ScreenWidth, ContentHeight - STHeight(170))];
    _tableView.delegate = self;
    _tableView.backgroundColor = cbg2;
    _tableView.dataSource = self;
    [_tableView useDefaultProperty];
    [self addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mViewModel.datas.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopModel *shopModel = [_mViewModel.datas objectAtIndex:indexPath.row];
    if(shopModel.isExpand){
        return STHeight(65) + STHeight(15);
    }else{
        UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
        if(userModel.roleType == RoleType_Celebrity){
            return STHeight(65) + STHeight(15) + shopModel.skuModels.count * STHeight(130);
        }else{
            return STHeight(65) + STHeight(15) + shopModel.skuModels.count * STHeight(170);
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CooperationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CooperationViewCell identify]];
    if(!cell){
        cell = [[CooperationViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CooperationViewCell identify]];
    }
    cell.expandBtn.tag = indexPath.row;
    [cell.expandBtn addTarget:self action:@selector(onExpandBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] position:indexPath.row vm:_mViewModel];
    }
    return cell;
}


/********************** tableview ****************************/



-(void)updateView{
    if(!IS_NS_STRING_EMPTY(_mViewModel.addressModel.addressId)){
        AddressInfoModel *addressModel = _mViewModel.addressModel;
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",addressModel.province,addressModel.city,addressModel.area,addressModel.detailAddr];;
        _addressLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)];
        CGSize addressSize = [_addressLabel.text sizeWithMaxWidth:STWidth(270) font:STFont(15) fontName:FONT_SEMIBOLD];
        _addressLabel.frame = CGRectMake(STWidth(15), STHeight(50), STWidth(270), addressSize.height);
        
        _contactLabel.text = [NSString stringWithFormat:@"%@  %@",addressModel.contactUser,addressModel.contactPhone];
        CGSize contactSize = [_contactLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
        _contactLabel.frame = CGRectMake(STWidth(61), STHeight(15), contactSize.width, STHeight(20));
        
        _defaultLabel.hidden = NO;
        _addressImageView.frame = CGRectMake(0, STHeight(74) + addressSize.height, ScreenWidth, STHeight(4));
        _addressBtn.frame = CGRectMake(0, 0, ScreenWidth,  STHeight(78) + addressSize.height);
        
        _tableView.frame = CGRectMake(0, _addressBtn.size.height, ScreenWidth, ContentHeight - _addressBtn.size.height - STHeight(80));
    }
    [_tableView reloadData];
}

-(void)onExpandBtn:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    ShopModel *model = [_mViewModel.datas objectAtIndex:tag];
    model.isExpand = !model.isExpand;
    [_tableView reloadData];
}

-(void)updateCelebrity:(CelebrityParamModel *)model{
    _mViewModel.datas = model.allDatas;
    [STLog print:@"位置1" content: LongStr(model.position1)];
    [STLog print:@"位置2" content: LongStr(model.position2)];
    ShopModel *shopModel = [_mViewModel.datas objectAtIndex:model.position1];
    [STLog print:@"商品数量" content:LongStr(shopModel.skuModels.count)];
    ShopSkuModel *skuModel = [shopModel.skuModels objectAtIndex:model.position2];
    skuModel.celebrityDatas = model.datas;
    [_tableView reloadData];
}


@end

