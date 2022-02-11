
#import <UIKit/UIKit.h>
#import "MsgModel.h"


@interface MsgViewCell : UITableViewCell

-(void)updateData:(MsgModel *)model;
+(NSString *)identify;

@property(strong, nonatomic)UIButton *delBtn;
@property(strong, nonatomic)UIView *msgView;

@end
