//
//  MenuCell.m
//  SQLite(RemoveCache)
//
//  Created by pengpeng yan on 16/2/16.
//  Copyright © 2016年 peng yan. All rights reserved.
//

#import "MenuCell.h"
#import "Masonry.h"
@interface MenuCell ()

@end

@implementation MenuCell

//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
        [self initContraints];
    }
    return self;
}


- (void)initSubViews{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.stepLabel];
    
}

- (void)initContraints{
   [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.mas_left).offset(50);
       make.right.equalTo(self.mas_right).offset(-50);
       make.top.equalTo(self.mas_top).offset(20);
       make.bottom.equalTo(_stepLabel.mas_top).offset(20);
   }];
    [_stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UILabel *)stepLabel{
    if (!_stepLabel) {
        _stepLabel = [[UILabel alloc] init];
    }
    return _stepLabel;
}


@end
