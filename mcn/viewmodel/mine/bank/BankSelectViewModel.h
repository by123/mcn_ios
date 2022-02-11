//
//  BankSelectViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BankSelectViewDelegate<BaseRequestDelegate>

-(void)onGoAddPage:(int)current;

@end


@interface BankSelectViewModel : NSObject

@property(weak, nonatomic)id<BankSelectViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)goAddPage:(int)current;

@end



