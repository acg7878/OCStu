//
//  WaterFallLayout.h
//  OCStu
//
//  Created by Derek on 2026/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WaterFallLayoutDelegate <NSObject>

// @required：必须实现
// @optional：可选实现
@required
- (CGFloat)waterfallLayout:(UICollectionViewLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)itemWidth;

@end

@interface WaterFallLayout : UICollectionViewLayout

/// 代理对象（获取item高度）
@property (nonatomic, weak) id<WaterFallLayoutDelegate> delegate;
/// 列数
@property (nonatomic, assign) NSInteger columnCount;

@end


NS_ASSUME_NONNULL_END
