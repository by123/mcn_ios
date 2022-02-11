
#import <UIKit/UIKit.h>
#import "ShopModel.h"


@interface ShopItemViewCell : UITableViewCell

@property(strong, nonatomic)UIView *shopItemView;
@property(strong, nonatomic)UIButton *delBtn;

-(void)updateData:(ShopSkuModel *)model;
+(NSString *)identify;

@end
