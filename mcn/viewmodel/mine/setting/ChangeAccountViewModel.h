//
//  ChangeAccountViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChangeAccountViewDelegate<BaseRequestDelegate>

-(void)onClearUser;
-(void)onAddNewAccount;

@end


@interface ChangeAccountViewModel : NSObject

@property(weak, nonatomic)id<ChangeAccountViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)Boolean clearStatu;


-(void)clearUser:(NSInteger)tag;
-(void)changeAccount:(NSInteger)tag;
-(void)addNewAccount;

@end



