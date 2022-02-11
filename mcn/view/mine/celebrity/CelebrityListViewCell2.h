
#import <UIKit/UIKit.h>
#import "CelebrityModel.h"


@interface CelebrityListViewCell2 : UITableViewCell

@property(strong, nonatomic)UIButton *rejectBtn;
@property(strong, nonatomic)UIButton *agreeBtn;

-(void)updateData:(CelebrityModel *)model;
+(NSString *)identify;

@end
