//
//  ShelvesListView.h
//  mcn
//
//  Created by by.huang on 2020/8/21.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShelvesListView : UIView

-(instancetype)initWithType:(ShelvesType)shelvesType;
-(void)refreshNew;

@end

NS_ASSUME_NONNULL_END
