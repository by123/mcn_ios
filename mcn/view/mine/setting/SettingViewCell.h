
#import <UIKit/UIKit.h>

@interface SettingViewCell : UITableViewCell

-(void)updateData:(NSString *)title lineHidden:(Boolean)hidden;
+(NSString *)identify;

@end
