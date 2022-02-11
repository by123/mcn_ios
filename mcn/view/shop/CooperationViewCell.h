
#import <UIKit/UIKit.h>
#import "ShopModel.h"
#import "CooperationViewModel.h"

@interface CooperationViewCell : UITableViewCell

@property(strong, nonatomic)UIButton *expandBtn;

-(void)updateData:(ShopModel *)model position:(NSInteger)position vm:(CooperationViewModel *)vm;
+(NSString *)identify;

@end
