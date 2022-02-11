
#import <UIKit/UIKit.h>
#import "PartnerModel.h"
#import "PartnerViewModel.h"

@interface PartnerItemViewCell : UITableViewCell

@property(strong, nonatomic)UIButton *merchantBtn;

-(void)updateData:(PartnerModel *)model vm:(PartnerViewModel *)vm;
+(NSString *)identify;

@end
