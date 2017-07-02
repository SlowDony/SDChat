//
//  SDChatConnectionTableViewCell.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/17.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatConnectionTableViewCell.h"

@implementation SDChatConnectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellId = @"SDChatConnectionTableViewCellID";
    SDChatConnectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell =[[SDChatConnectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    
    //mHexRGB(0x1ba157),mHexRGB(0xff0000),mHexRGB(0x777777)];
   
    
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake (20,(72-8)/2, 8, 8);
    view.backgroundColor = [UIColor clearColor];
    self.pointView =view;
    self.pointView.layer.cornerRadius=4;
    self.pointView.layer.masksToBounds=YES;
    [self addSubview:view];
    
    //
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.frame = CGRectMake(45,(72-50)/2, 50, 50);
    headImageView.image = [UIImage imageNamed:@"chatHead"];
    headImageView.layer.cornerRadius=25;
    headImageView.layer.masksToBounds=YES;
    self.headImage=headImageView;
    [self addSubview:headImageView];
    //
    UILabel *titlelabel = [[UILabel alloc] init];
    titlelabel.frame = CGRectMake(110, 0, 100, 72);
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.text = @" 苗小虎";
    titlelabel.textAlignment = NSTextAlignmentLeft;
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor =fontBlackColor;
    titlelabel.numberOfLines = 1;
    self.titleLab=titlelabel;
    [self addSubview:titlelabel];
    
    UILabel *numLab = [[UILabel alloc] init];
    numLab.frame = CGRectMake(SDDeviceWidth-120, 0, 100, 72);
    numLab.backgroundColor = [UIColor clearColor];
    numLab.text = @"剩余对话人数: 10";
    self.numLab=numLab;
    numLab.textAlignment = NSTextAlignmentLeft;
    numLab.font = [UIFont systemFontOfSize:12];
    numLab.textColor =fontNomalColor;
    numLab.numberOfLines = 1;
    [self addSubview:numLab];

}
@end
