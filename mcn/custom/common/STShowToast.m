//
//  STShowToast.m
//  cigarette
//
//  Created by by.huang on 2020/4/20.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "STShowToast.h"
#import <MBProgressHUD.h>

@implementation STShowToast


+(void)show:(NSString *)text{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:window];
    UILabel *toastLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:16.0f] text:text textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:YES];
    CGSize toastSize = [toastLabel.text sizeWithMaxWidth:STWidth(400) font:16.0f fontName:FONT_REGULAR];
    hud.customView = toastLabel;
    [hud.customView setSize:CGSizeMake(STWidth(400), toastSize.height)];
    hud.mode = MBProgressHUDModeCustomView;
    [hud setUserInteractionEnabled:false];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [window addSubview:hud];
    [hud hide:YES afterDelay:1.0f];
}


+ (void)hide {
    [[LCProgressHUD sharedHUD] setShowNow:NO];
    [[LCProgressHUD sharedHUD] hide:YES];
}

@end
