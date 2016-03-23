//
//  LCTopicViewCell.h
//  LCBudejie
//
//  Created by admin on 16/3/22.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCTopic;
@interface LCTopicViewCell : UITableViewCell

@property (nonatomic, strong)LCTopic *topic;
+ (instancetype)topicCellWithTableView:(UITableView *)tableview;
@end
