
#import <UIKit/UIKit.h>
#import "CelebrityModel.h"


@interface CelebrityListViewCell : UITableViewCell

@property(strong, nonatomic)UIButton *removeBtn;

-(void)updateData:(CelebrityModel *)model type:(int)type;
+(NSString *)identify;

@end
