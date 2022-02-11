//
//  STTitleTableView.m
//  cigarette
//
//  Created by by.huang on 2019/9/7.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STTitleTableView.h"
#import "STTitleTableViewCell.h"

@interface STTitleTableView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)NSMutableArray *datas;
@property(copy, nonatomic)NSString *title;

@end

@implementation STTitleTableView

-(instancetype)initWithTitle:(NSString *)title datas:(NSMutableArray *)datas{
    if(self == [super init]){
        _datas = datas;
        _title = title;
        
        self.backgroundColor = cbg2;
        
        if(!IS_NS_STRING_EMPTY(title)){
            UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:title textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
             CGSize nameSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
             titleLabel.frame = CGRectMake(STWidth(15), STHeight(15), nameSize.width, STHeight(20));
             [self addSubview:titleLabel];
             
        }
 
        [self initTableView];
    }
    return self;
}


/********************** tableview ****************************/
-(void)initTableView{
    if(IS_NS_COLLECTION_EMPTY(_datas))  return;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,IS_NS_STRING_EMPTY(_title) ? 0 : STHeight(45), ScreenWidth, _datas.count * STHeight(50))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [_tableView useDefaultProperty];
    [self addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    STTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[STTitleTableViewCell identify]];
    if(!cell){
        cell = [[STTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[STTitleTableViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
        if(_datas.count -1 == indexPath.row){
            [cell updateData:[_datas objectAtIndex:indexPath.row] hiddenLine:YES];
        }else{
            [cell updateData:[_datas objectAtIndex:indexPath.row] hiddenLine:NO];
        }
    }
    return cell;
}

-(void)updateView{
    [_tableView reloadData];
}


-(void)refreshNew{
    [_tableView.mj_header endRefreshing];
    
}

-(void)uploadMore{
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}

/********************** tableview ****************************/


-(CGFloat)getViewHeight{
    return IS_NS_STRING_EMPTY(_title) ? 0 :  STHeight(45)+_datas.count * STHeight(51);
}


@end
