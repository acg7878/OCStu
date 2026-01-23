//
//  WaterFallLayout.m
//  OCStu
//
//  Created by Derek on 2026/1/22.
//

#import "WaterFallLayout.h"

@interface WaterFallLayout ()

/// 缓存所有布局属性
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArray;
/// 记录每一列的当前高度（y坐标）
@property (nonatomic, strong) NSMutableArray<NSNumber *> *columnHeights;
/// 内容总高度
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation WaterFallLayout



@end
