//
//  WaterFallItemCell.m
//  OCStu
//
//  Created by Derek on 2026/1/24.
//

#import "WaterFallItemCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface WaterFallItemCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *backgroundCardView;

@end

@implementation WaterFallItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    // 卡片背景
    self.backgroundCardView = [[UIView alloc] init];
    self.backgroundCardView.backgroundColor = [UIColor whiteColor];
    self.backgroundCardView.layer.cornerRadius = 8;
    self.backgroundCardView.layer.masksToBounds = YES;
    self.backgroundCardView.layer.borderWidth = 1;
    self.backgroundCardView.layer.borderColor = [UIColor systemGray5Color].CGColor;
    [self.contentView addSubview:self.backgroundCardView];
    
    // 图片视图
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.backgroundColor = [UIColor systemGray6Color];
    [self.backgroundCardView addSubview:self.imageView];
    
    // 标题标签
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor darkTextColor];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundCardView addSubview:self.titleLabel];
    
    // 布局
    [self.backgroundCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundCardView).offset(8);
        make.right.equalTo(self.backgroundCardView).offset(-8);
        make.bottom.equalTo(self.backgroundCardView).offset(-8);
        make.height.equalTo(@40); // 固定标签高度
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.backgroundCardView);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-8);
    }];
}

#pragma mark - Public Methods

- (void)setItemModel:(WaterFallItemModel *)itemModel {
    _itemModel = itemModel;
    [self configWithModel:itemModel];
}

- (void)configWithModel:(WaterFallItemModel *)model {
    self.titleLabel.text = model.title ?: @"默认标题";
    
    // 使用 SDWebImage 加载网络图片
    if (model.imageUrl) {
        NSURL *imageURL = [NSURL URLWithString:model.imageUrl];
        [self.imageView sd_setImageWithURL:imageURL
                          placeholderImage:[UIImage systemImageNamed:@"photo"]
                                 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"图片加载失败: %@", error.localizedDescription);
            }
        }];
    } else {
        // 使用默认图片
        self.imageView.image = [UIImage systemImageNamed:@"photo"];
        self.imageView.tintColor = [UIColor systemGray3Color];
    }
    
    // 根据高度显示不同的背景色（便于调试）
    CGFloat hue = fmod(model.height / 100.0, 1.0);
    self.imageView.backgroundColor = [UIColor colorWithHue:hue saturation:0.7 brightness:0.9 alpha:1.0];
}

@end
