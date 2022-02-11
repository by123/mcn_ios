
#import <UIKit/UIKit.h>
#import "WithdrawModel.h"


@interface WithdrawListViewCell : UITableViewCell

-(void)updateData:(WithdrawModel *)model;
+(NSString *)identify;

@end
