//
//  WaterFallItemModel.h
//  OCStu
//
//  Created by Derek on 2026/1/22.
//

#import <Foundation/Foundation.h>

@interface WaterFallItemModel : NSObject

/// 图片URL
@property (nonatomic, copy) NSString *imageUrl;
/// item高度
@property (nonatomic, assign) CGFloat height;
/// 标题
@property (nonatomic, copy) NSString *title;

@end
