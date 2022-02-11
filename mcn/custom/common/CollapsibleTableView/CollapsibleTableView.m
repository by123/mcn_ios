//
//  CollapsibleTableView.m
//  cigarette
//
//  Created by xiao ming on 2019/12/26.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "CollapsibleTableView.h"
#import "CollapsibleViewCell.h"

static NSString *CellIdentify = @"CellIdentify";

@interface CollapsibleTableView()<UITableViewDelegate,UITableViewDataSource,CollapsibleViewCellDelegate>

///当前需要展示的数据
@property (nonatomic, strong) NSMutableArray<CollapsibleModel *> *currentItems;
///上一次展示的数据
@property (nonatomic, strong) NSMutableArray<CollapsibleModel *> *lastedItems;

@property(strong, nonatomic)UITableView *tableView;

@end

@implementation CollapsibleTableView

- (instancetype)init {
    if(self == [super init]){
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

//刷新
- (void)setRootItems:(NSMutableArray<CollapsibleModel *> *)rootItems {
    _rootItems = rootItems;
    [self resetCurrentItems];
    [self.tableView reloadData];
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentItems.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollapsibleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify forIndexPath:indexPath];
    cell.menuItem = self.currentItems[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CollapsibleModel *menuItem = self.currentItems[indexPath.row];
    if (!menuItem.isCanUnfold) return;
    
    menuItem.isUnfold = !menuItem.isUnfold; //设置展开闭合

    if (menuItem.subs.count == 0) {
        if ([self.delegate respondsToSelector:@selector(requestSubDataForTargetModel:)]) {
            [self.delegate requestSubDataForTargetModel:menuItem];
        }
        return;
    }
    
    // 更新被点击cell，这个方法会直接跳转(cellForRowAtIndexPath、以及其他delegate函数)，去更新cell代码（在数据源变化之前调用）
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    [self resetCurrentItems];
    [self startCellAnimation:indexPath];
}

- (void)startCellAnimation:(NSIndexPath *)indexPath {
    
    // 判断老数据和新数据的数量, 来进行展开和闭合动画
    // 定义一个数组, 用于存放需要展开闭合的indexPath
    NSMutableArray<NSIndexPath *> *indexPaths = @[].mutableCopy;
    
    // 如果 老数据 比 新数据 多, 那么就需要进行闭合操作
    if (self.lastedItems.count > self.currentItems.count) {
        // 遍历lastedItems, 找出多余的老数据对应的indexPath
        for (int i = 0; i < self.lastedItems.count; i++) {
            // 当新数据中 没有对应的item时
            if (![self.currentItems containsObject:self.lastedItems[i]]) {
                NSIndexPath *subIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
                [indexPaths addObject:subIndexPath];
            }
        }
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationTop)];
    }else {
        // 此时 新数据 比 老数据 多, 进行展开操作
        // 遍历 currentItems, 找出 lastedItems 中没有的选项, 就是需要新增的indexPath
        for (int i = 0; i < self.currentItems.count; i++) {
            if (![self.lastedItems containsObject:self.currentItems[i]]) {
                NSIndexPath *subIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
                [indexPaths addObject:subIndexPath];
            }
        }
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationTop)];
    }
}

#pragma mark - < cell delegate >
- (void)cellSelectedBtnClick:(CollapsibleViewCell *)cell {
    //记录选中的model
    self.selectedItem = cell.menuItem;
    
    //刷新
    [self setItemsSelectStateToFalse:self.currentItems];
    cell.menuItem.isSelected = !cell.menuItem.isSelected;
    [self.tableView reloadData];
}

#pragma mark - < 重新添加可以展示的选项 >
- (void)resetCurrentItems {
    self.lastedItems = [NSMutableArray arrayWithArray:self.currentItems];
    
    // 清空当前所有展示项
    [self.currentItems removeAllObjects];
    
    // 重新添加需要展示项, 并设置层级, root层级为0
    [self assemblyVisibleItems:self.rootItems index:0];
}

/**
 将需要展示的选项添加到currentItems中, 此方法使用递归添加所有需要展示的层级到currentItems中
 @param menuItems 需要添加到currentItems中的数据
 @param index 层级, 即当前添加的数据属于第几层
 */
- (void)assemblyVisibleItems:(NSArray<CollapsibleModel *> *)menuItems index:(NSInteger)index {
    for (int i = 0; i < menuItems.count; i++) {
        CollapsibleModel *item = menuItems[i];
        // 设置当前层级
        item.index = index;
        // 将选项添加到数组中
        [self.currentItems addObject:item];
        // 判断该选项的是否能展开, 并且已经需要展开
        if (item.isCanUnfold && item.isUnfold) {
            // 当需要展开子集的时候, 添加子集到数组, 并设置子集层级
            [self assemblyVisibleItems:item.subs index:index + 1];
        }
    }
}

- (void)setItemsSelectStateToFalse:(NSArray<CollapsibleModel *> *)menuItems {
    for (CollapsibleModel *model in menuItems) {
        model.isSelected = false;
        [self setItemsSelectStateToFalse:model.subs];
    }
}


#pragma mark - < getter >
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.rowHeight = STHeight(60);
        [self.tableView registerClass:[CollapsibleViewCell class] forCellReuseIdentifier:CellIdentify];
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray<CollapsibleModel *> *)currentItems {
    if (!_currentItems) {
        _currentItems = [[NSMutableArray alloc] init];
    }
    return _currentItems;
}
@end
