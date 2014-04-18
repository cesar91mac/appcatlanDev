//
//  RSSTableViewCell.h
//  Appcatlan
//
//  Created by César Flores on 4/17/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnail;

@end
