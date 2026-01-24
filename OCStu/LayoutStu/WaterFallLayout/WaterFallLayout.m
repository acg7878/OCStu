//
//  WaterFallLayout.m
//  OCStu
//
//  Created by Derek on 2026/1/22.
//

#import "WaterFallLayout.h"
#include <CoreFoundation/CFCGTypes.h>
#include <CoreGraphics/CGGeometry.h>
#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#include <objc/NSObjCRuntime.h>

@interface WaterFallLayout ()

/// 缓存所有布局属性
@property(nonatomic, strong)
    NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArray;
/// 记录每一列的当前高度（y坐标）
@property(nonatomic, strong) NSMutableArray<NSNumber *> *columnHeights;
/// 内容总高度
@property(nonatomic, assign) CGFloat contentHeight;

@end

@implementation WaterFallLayout

- (NSMutableArray *)attrsArray {
  if (!_attrsArray) {
    _attrsArray = [[NSMutableArray alloc] init];
  }
  return _attrsArray;
}

- (NSMutableArray *)columnHeights {
  if (!_columnHeights) {
    _columnHeights = [[NSMutableArray alloc] init];
  }
  return _columnHeights;
}

/// 负责计算所有item位置
/*
    步骤
        1. 重置状态、初始化
        2. 计算 item 宽度
        3. 遍历item计算位置
            3.1 找到最短列
            3.2 计算item frame
            3.3 创建UICollectionViewLayoutAttributes对象，存储item布局信息
            3.4 更新该列高度为item底部y坐标
*/
- (void)prepareLayout {
  [super prepareLayout];

  // 重置状态、初始化
  [self.attrsArray removeAllObjects];
  [self.columnHeights removeAllObjects];
  self.contentHeight = 0;
  // 初始化每列高度
  for (NSInteger i = 0; i < self.columnCount; i++) {
    [self.columnHeights addObject:@0];
  }

  // 计算 item 高度
  CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
  CGFloat leftRightMargin = 20; // 左右边距
  CGFloat columnSpacing = 10;   // 列间距
  CGFloat spacingWidth = (self.columnCount - 1) * columnSpacing;
  CGFloat itemWidth =
      (collectionViewWidth - leftRightMargin * 2 - spacingWidth) / self.columnCount;

  // 遍历item计算位置
  NSInteger sections = [self.collectionView numberOfSections];
  for (NSInteger i = 0; i < sections; i++) {
    NSInteger items = [self.collectionView numberOfItemsInSection:i];
    for (NSInteger j = 0; j < items; j++) {
      /*
          indexPath 标识数据，构成NSIndexPath(section,item)
          拿到这个可以：
              1. 找到对应的cell：cellForItemAtIndexPath
              2. 通过delegate访问数据源
              3. 告诉布局属性这是哪个item：layoutAttributesForCellWithIndexPath

       */

      NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
      CGFloat itemHeight = [self.delegate waterfallLayout:self
                                 heightForItemAtIndexPath:indexPath
                                            withItemWidth:itemWidth];
      // 找到最短列
      NSInteger shortestColumn = 0;
      CGFloat shortestHeight = [self.columnHeights[0] doubleValue];
      for (NSInteger col = 1; col < self.columnCount; col++) {
        CGFloat currentHeight = [self.columnHeights[col] doubleValue];
        if (currentHeight < shortestHeight) {
          shortestHeight = currentHeight;
          shortestColumn = col;
        }
      }

      CGFloat x =
          leftRightMargin + shortestColumn * (itemWidth + columnSpacing);
      CGFloat y = shortestHeight + 10; // 10间距
      CGRect frame = CGRectMake(x, y, itemWidth, itemHeight);

      // attrs 为item的布局属性
      UICollectionViewLayoutAttributes *attrs =
          [UICollectionViewLayoutAttributes
              layoutAttributesForCellWithIndexPath:indexPath];
      attrs.frame = frame;
      [self.attrsArray addObject:attrs];

      // 更新该列高度为item底部y坐标
      self.columnHeights[shortestColumn] = @(CGRectGetMaxY(frame));
    }
  }

  // 计算最终内容高度
  self.contentHeight = 0;
  for (NSNumber *height in self.columnHeights) {
    if (height.doubleValue > self.contentHeight) {
      self.contentHeight = height.doubleValue;
    }
  }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
  return self.attrsArray;
}

- (CGSize)collectionViewContentSize {
  return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

@end
