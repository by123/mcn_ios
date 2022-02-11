//
//  STTitleTableView.h
//  cigarette
//
//  Created by by.huang on 2019/9/7.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>


//带标题的表单样式
@interface STTitleTableView : UIView

@property(strong, nonatomic)UITableView *tableView;
-(instancetype)initWithTitle:(NSString *)title datas:(NSMutableArray *)datas;

-(CGFloat)getViewHeight;

@end

