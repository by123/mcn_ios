
#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface ChangeAccountViewCell : UITableViewCell

-(void)updateData:(UserModel *)model clearStatu:(Boolean)clearStatu;
+(NSString *)identify;

@property(strong, nonatomic)UIButton *clearBtn;

@end
