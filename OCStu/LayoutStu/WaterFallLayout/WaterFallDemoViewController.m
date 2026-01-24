//
//  WaterFallDemoViewController.m
//  OCStu
//
//  Created by Derek on 2026/1/24.
//

#import "WaterFallDemoViewController.h"
#import "WaterFallLayout.h"
#import "WaterFallItemCell.h"
#import "WaterFallItemModel.h"

@interface WaterFallDemoViewController () <UICollectionViewDataSource, WaterFallLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WaterFallLayout *waterFallLayout;
@property (nonatomic, strong) NSMutableArray<WaterFallItemModel *> *dataArray;

@end

@implementation WaterFallDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"瀑布流布局演示";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    [self setupData];
    [self setupUI];
}

- (void)setupData {
    self.dataArray = [NSMutableArray array];
    
    // 使用高质量的微软风格壁纸数据
    NSArray *wallpapers = @[
        @{@"title": @"阿尔卑斯山脉", @"url": @"https://images.unsplash.com/photo-1506905925346-21bda4d32df4", @"aspect": @1.5},
        @{@"title": @"纽约夜景", @"url": @"https://images.unsplash.com/photo-1477959858617-67f85cf4f1df", @"aspect": @1.25},
        @{@"title": @"森林秘境", @"url": @"https://images.unsplash.com/photo-1441974231531-c6227db76b6e", @"aspect": @1.37},
        @{@"title": @"海滩夕阳", @"url": @"https://images.unsplash.com/photo-1507525428034-b723cf961d3e", @"aspect": @1.12},
        @{@"title": @"喜马拉雅", @"url": @"https://images.unsplash.com/photo-1464822759023-fed622ff2c3b", @"aspect": @1.5},
        @{@"title": @"都市天际线", @"url": @"https://images.unsplash.com/photo-1486406146926-c627a92ad1ab", @"aspect": @1.25},
        @{@"title": @"挪威峡湾", @"url": @"https://images.unsplash.com/photo-1501854140801-50d01698950b", @"aspect": @1.67},
        @{@"title": @"湖泊晨雾", @"url": @"https://images.unsplash.com/photo-1470240731273-7821a6eeb6bd", @"aspect": @1.2},
        @{@"title": @"极光星空", @"url": @"https://images.unsplash.com/photo-1444703686981-a3abbc4d4fe3", @"aspect": @1.3},
        @{@"title": @"瀑布奇观", @"url": @"https://images.unsplash.com/photo-1519681393784-d120267933ba", @"aspect": @1.45}
    ];
    
    for (int i = 0; i < 30; i++) {
        WaterFallItemModel *model = [[WaterFallItemModel alloc] init];
        
        // 循环使用壁纸数据
        NSDictionary *wallpaper = wallpapers[i % wallpapers.count];
        model.title = wallpaper[@"title"];
        model.imageUrl = wallpaper[@"url"];
        
        // 根据图片宽高比计算图片区域高度（适配瀑布流布局）
        CGFloat aspectRatio = [wallpaper[@"aspect"] floatValue];
        CGFloat itemWidth = (self.view.bounds.size.width - 60) / 2; // 屏幕宽度减去边距后除以列数
        model.height = itemWidth * aspectRatio;
        
        [self.dataArray addObject:model];
    }
}

- (void)setupUI {
    // 创建瀑布流布局
    self.waterFallLayout = [[WaterFallLayout alloc] init];
    self.waterFallLayout.columnCount = 2; // 2列
    self.waterFallLayout.delegate = self;
    
    // 创建集合视图
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.waterFallLayout];
    self.collectionView.backgroundColor = [UIColor systemGray6Color];
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[WaterFallItemCell class] forCellWithReuseIdentifier:@"WaterFallItemCell"];
    [self.view addSubview:self.collectionView];
    
    // 自动布局
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterFallItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterFallItemCell" forIndexPath:indexPath];
    WaterFallItemModel *model = self.dataArray[indexPath.item];
    [cell configWithModel:model];
    return cell;
}

#pragma mark - WaterFallLayoutDelegate

- (CGFloat)waterfallLayout:(UICollectionViewLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)itemWidth {
    WaterFallItemModel *model = self.dataArray[indexPath.item];
    
    // 总高度 = 图片高度 + 固定标签区域高度(60px)
    return model.height + 60;
}

@end