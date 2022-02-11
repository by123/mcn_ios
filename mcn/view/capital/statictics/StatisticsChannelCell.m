

#import "StatisticsChannelCell.h"
#import "StatisticsChannelItemCell.h"

@interface StatisticsChannelCell()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView *view;
@property(strong, nonatomic)UILabel *mchNameLabel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSMutableArray *skuDatas;

@end

@implementation StatisticsChannelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _view = [[UIView alloc]init];
    _view.backgroundColor = cwhite;
    [self.contentView addSubview:_view];
    
    _mchBtn = [[UIButton alloc]init];
    _mchBtn.frame = CGRectMake(0, 0, ScreenWidth, STHeight(60));
    _mchBtn.backgroundColor = cwhite;
    [_view addSubview:_mchBtn];
    
    _mchNameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [_mchBtn addSubview:_mchNameLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STHeight(16) - STWidth(15), STHeight(22), STHeight(16), STHeight(16))];
    arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_mchBtn addSubview:arrowImageView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(60)-LineHeight, ScreenWidth, LineHeight)];
    lineView.backgroundColor = cline;
    [_mchBtn addSubview:lineView];
    
    [self initTableView];
}

-(void)updateData:(StatisticsCooperateModel *)model{
    _skuDatas = model.skuDatas;
    
    _mchNameLabel.text = model.cooperationName;
    CGSize mchNameSize = [_mchNameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _mchNameLabel.frame = CGRectMake(STWidth(15), 0, mchNameSize.width, STHeight(60));
    
    _view.frame = CGRectMake(0, 0, ScreenWidth, STHeight(80) + [self getTableViewHeight]);
    _tableView.frame = CGRectMake(0, STHeight(80), ScreenWidth, [self getTableViewHeight]);
    [_tableView reloadData];
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = cwhite;
    [_tableView useDefaultProperty];

    [_view addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_skuDatas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(21);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatisticsChannelItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[StatisticsChannelItemCell identify]];
    if(!cell){
        cell = [[StatisticsChannelItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[StatisticsChannelItemCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_skuDatas)){
        [cell updateData:[_skuDatas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)updateView{
    [_tableView reloadData];
}


-(CGFloat)getTableViewHeight{
    if(IS_NS_COLLECTION_EMPTY(_skuDatas)) return 0;
    CGFloat height = STHeight(20) + _skuDatas.count * STHeight(21) + (_skuDatas.count - 1) * STHeight(15);
    return height;
}

/********************** tableview ****************************/


+(NSString *)identify{
    return NSStringFromClass([StatisticsChannelCell class]);
}

@end


