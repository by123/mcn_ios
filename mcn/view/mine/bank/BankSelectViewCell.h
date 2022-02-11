
#import <UIKit/UIKit.h>
#import "TitleContentModel.h"


@interface BankSelectViewCell : UITableViewCell

-(void)updateData:(TitleContentModel *)model;
+(NSString *)identify;

@end
