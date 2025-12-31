//
//  MasonryViewController.m
//  OCStu
//
//  Created by Derek on 2025/12/30.
//

#import "MasonryViewController.h"
#import <Masonry/Masonry.h>

@interface MasonryViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray<NSString *> *levelTitles;
@property (nonatomic, strong) MASConstraint *contentBottomConstraint;

@end

// Masonry 布局练习
@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"Masonry 布局练习";
    
    // 创建滚动视图
    [self setupScrollView];

    self.levelTitles = @[ @"关卡 1：基础定位",
                          @"关卡 2：相对布局",
                          @"关卡 3：实用组件",
                          @"关卡 4：复杂布局" ];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择关卡"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(showLevelList)];

    // 默认展示第一关
    [self loadLevelAtIndex:0];
}

#pragma mark - ScrollView Setup

- (void)setupScrollView {
    // TODO: 创建 scrollView 并添加到 self.view
    // 提示：使用 mas_makeConstraints，让 scrollView 铺满整个视图
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // TODO: 创建 contentView 并添加到 scrollView
    // 提示：contentView 的 width 要等于 scrollView，edges 对齐
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
}

#pragma mark - Level Picker

- (void)showLevelList {
    // 使用 Alert 样式让列表居中，不会“飞出屏幕”
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择关卡"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];

    for (NSUInteger idx = 0; idx < self.levelTitles.count; idx++) {
        NSString *title = self.levelTitles[idx];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull __unused alertAction) {
            [self loadLevelAtIndex:(NSInteger)idx];
        }];
        [alert addAction:action];
    }

    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)loadLevelAtIndex:(NSInteger)index {
    if (index < 0 || index >= (NSInteger)self.levelTitles.count) {
        return;
    }

    self.title = self.levelTitles[(NSUInteger)index];
    [self resetContentView];

    switch (index) {
        case 0:
            [self level1_BasicPositioning];
            break;
        case 1:
            [self level2_RelativeLayout];
            break;
        case 2:
            [self level3_PracticalComponents];
            break;
        case 3:
            [self level4_ComplexLayout];
            break;
        default:
            break;
    }
}

- (void)resetContentView {
    [self.contentBottomConstraint uninstall];
    self.contentBottomConstraint = nil;

    for (UIView *subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
}

- (void)pinContentBottomToView:(UIView *)view offset:(CGFloat)offset {
    [self.contentBottomConstraint uninstall];
    __weak typeof(self) weakSelf = self;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        weakSelf.contentBottomConstraint = make.bottom.equalTo(view.mas_bottom).offset(offset);
    }];
}

#pragma mark - Level 1: 基础定位

- (void)level1_BasicPositioning {
  
    
    // 练习 1.1：顶部标题栏
    // TODO: 创建一个 UIView，紫色背景
    // TODO: 贴顶部和左右边，固定高度 80
    // TODO: 添加标签显示 "顶部标题栏 (高度80)"
    UIView* topTitle = [[UIView alloc] init];
    topTitle.backgroundColor = [UIColor systemPurpleColor];
    [self.contentView addSubview:topTitle];
    [topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(80);
    }];
    UILabel* titleLabel = [[UILabel alloc] init];
    [topTitle addSubview:titleLabel];
    titleLabel.text = @"顶部标题栏";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topTitle);
    }];
    
    // 练习 1.2：创建一个居中的正方形
    // TODO: 创建一个 UIView，设置蓝色背景，圆角 10
    // TODO: 使用 mas_makeConstraints 让它居中，尺寸 150×150
    // TODO: 添加一个白色标签显示 "居中的正方形"
    UIView* box = [[UIView alloc] init];
    box.backgroundColor = [UIColor blueColor];
    box.layer.cornerRadius = 10;
    box.layer.masksToBounds = YES;
    [self.contentView addSubview:box];
    [box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topTitle.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    UILabel* label = [[UILabel alloc] init];
    label.text = @"居中的正方形";
    [box addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(box);
    }];
    
    
    // 练习 1.3：底部按钮（安全区域适配）
    // TODO: 创建一个 UIButton，绿色背景
    // TODO: 左右各留 20 边距，距底部 20，高度 50
    // TODO: 设置标题 "底部按钮（距底部20）"
    // TODO: 最后更新 contentView 的 bottom 约束，确保可滚动
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor systemGreenColor];
    [button setTitle:@"底部按钮（距底部20）" forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20);
    }];

    // 更新 contentView 高度以确保滚动范围包含按钮
    [self pinContentBottomToView:button offset:20];
}

#pragma mark - Level 2: 相对布局

- (void)level2_RelativeLayout {
    // 练习 2.1：两个视图上下排列
    // TODO: 创建 topBox，橙色背景，距顶部 20，左右各 20 边距，高度 100
    // TODO: 创建 bottomBox，青色背景，相对 topBox 底部向下 20，其他同上
    // 关键：使用 make.top.equalTo(topBox.mas_bottom).offset(20)

    UIView *topBox = [[UIView alloc] init];
    topBox.backgroundColor = [UIColor systemOrangeColor];
    [self.contentView addSubview:topBox];
    [topBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(100);
    }];

    UIView *bottomBox = [[UIView alloc] init];
    bottomBox.backgroundColor = [UIColor systemTealColor];
    [self.contentView addSubview:bottomBox];
    [bottomBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBox.mas_bottom).offset(20);
        make.left.right.equalTo(topBox);
        make.height.equalTo(topBox);
    }];

    UILabel *topLabel = [self createLabel:@"topBox (高度100)" ];
    [topBox addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topBox);
    }];

    UILabel *bottomLabel = [self createLabel:@"bottomBox (高度100)" ];
    [bottomBox addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomBox);
    }];

    [self pinContentBottomToView:bottomBox offset:20];
}

#pragma mark - Level 3: 实用组件

- (void)level3_PracticalComponents {
    // 练习 3.1：登录页面布局
    // TODO: 创建头像（UIImageView），使用 SF Symbol "person.crop.circle.fill"
    //       尺寸 100×100，距顶部 60，水平居中
    
    
    // TODO: 创建用户名输入框（使用 createTextField 方法）
    //       距头像底部 40，左右各 20 边距，高度 50
    
    
    // TODO: 创建密码输入框，距用户名底部 15，其他约束相同
    
    
    // TODO: 创建登录按钮，蓝色背景，圆角 25
    //       距密码框底部 30，左右各 20 边距，高度 50
    
    
    // TODO: 更新 contentView 高度
}

#pragma mark - Level 4: 复杂布局

- (void)level4_ComplexLayout {
    // 练习 4.1：九宫格布局（3×3）
    // TODO: 使用双层 for 循环创建 9 个格子
    // TODO: 计算每个格子的位置：
    //       itemWidth = (屏幕宽度 - 左右边距 - 间距总和) / 列数
    //       left = padding + col * (itemWidth + spacing)
    //       top = padding + row * (itemWidth + spacing)
    // 提示：使用 i / cols 得到行号，i % cols 得到列号
    
    NSInteger rows = 3;
    NSInteger cols = 3;
    CGFloat padding = 15;
    CGFloat itemSpacing = 10;
    
    // TODO: for (NSInteger i = 0; i < rows * cols; i++) { ... }
    
    
    // TODO: 更新 contentView 高度
}

#pragma mark - Helper Methods

- (UILabel *)createLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UITextField *)createTextField:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    textField.font = [UIFont systemFontOfSize:16];
    return textField;
}

@end
