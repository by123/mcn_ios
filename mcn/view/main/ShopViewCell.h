
#import <UIKit/UIKit.h>
#import "ShopModel.h"
#import "ShopViewModel.h"

@interface ShopViewCell : UITableViewCell

@property(strong, nonatomic)UIView *cardView;
@property(strong, nonatomic)UIButton *allSelectBtn;
@property(strong, nonatomic)UIButton *detailBtn;

-(void)updateData:(ShopViewModel *)shopVM position:(NSInteger)position;
+(NSString *)identify;

@end
