//
//  WaterFallItemCell.h
//  OCStu
//
//  Created by Derek on 2026/1/24.
//

#import "UIKit/UIKit.h"
#import "WaterFallItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WaterFallItemCell : UICollectionViewCell

@property (nonatomic, strong) WaterFallItemModel *itemModel;

-(void) configWithModel:(WaterFallItemModel *)model;

@end



NS_ASSUME_NONNULL_END
