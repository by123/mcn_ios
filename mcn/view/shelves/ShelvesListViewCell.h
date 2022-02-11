
#import <UIKit/UIKit.h>
#import "ShelvesModel.h"


@interface ShelvesListViewCell : UITableViewCell

@property(strong, nonatomic)UIView *shelvesView;
@property(strong, nonatomic)UIButton *shelvesBtn;

-(void)updateData:(ShelvesModel *)model type:(ShelvesType)type;
+(NSString *)identify;

@end
