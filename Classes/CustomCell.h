//
//  CustomCell.h
//  DubPub
//
//  Created by deag on 13/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {
	UILabel *nameLabel;
	UILabel *detailLabel;
	UIImageView *cellImage;
	NSString *category;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *detailLabel;
@property (nonatomic, retain) IBOutlet UIImageView *cellImage;
@property (nonatomic, retain) IBOutlet NSString *category;

@end
