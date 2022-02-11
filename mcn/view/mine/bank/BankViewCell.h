
#import <UIKit/UIKit.h>
#import "BankModel.h"


@interface BankViewCell : UITableViewCell

@property(strong, nonatomic)UIButton *delBtn;

-(void)updateData:(BankModel *)model;
+(NSString *)identify;

@end
