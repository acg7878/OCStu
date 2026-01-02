#import "DelegateStu.h"
#import <Masonry/Masonry.h>

@interface UIScrollViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *offsetLabel;

@end

@implementation UIScrollViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor systemBackgroundColor];
	self.title = @"UIScrollView 代理练习";

	[self setupScrollView];
	[self setupOffsetLabel];
	[self buildSampleContent];
}

- (void)setupScrollView {
	self.scrollView = [[UIScrollView alloc] init];
	self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
	self.scrollView.backgroundColor = [UIColor secondarySystemBackgroundColor];
	self.scrollView.alwaysBounceVertical = YES;
	self.scrollView.delegate = self;
	[self.view addSubview:self.scrollView];

//	[NSLayoutConstraint activateConstraints:@[
//		[self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
//		[self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
//		[self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
//		[self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
//	]];
    // masonry 方法
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

- (void)setupOffsetLabel {
	self.offsetLabel = [[UILabel alloc] init];
	self.offsetLabel.translatesAutoresizingMaskIntoConstraints = NO;
	self.offsetLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
	self.offsetLabel.textColor = [UIColor labelColor];
	self.offsetLabel.text = @"offset: (0, 0)";
	self.offsetLabel.backgroundColor = [[UIColor systemBackgroundColor] colorWithAlphaComponent:0.8];
	self.offsetLabel.layer.cornerRadius = 6;
	self.offsetLabel.layer.masksToBounds = YES;
	self.offsetLabel.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:self.offsetLabel];
	[self.view bringSubviewToFront:self.offsetLabel];

//	[NSLayoutConstraint activateConstraints:@[
//		[self.offsetLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:8],
//		[self.offsetLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
//		[self.offsetLabel.widthAnchor constraintGreaterThanOrEqualToConstant:140],
//		[self.offsetLabel.heightAnchor constraintEqualToConstant:28]
//	]];
    
    [self.offsetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(8);
        make.leading.equalTo(self.view.mas_leading).offset(16);
        make.width.greaterThanOrEqualTo(@140);
        make.height.equalTo(@28);
    }];
}

- (void)buildSampleContent {
	CGFloat y = 16.0;
	CGFloat width = UIScreen.mainScreen.bounds.size.width - 32.0;
	NSArray<UIColor *> *colors = @[ UIColor.systemRedColor,
									UIColor.systemBlueColor,
									UIColor.systemGreenColor,
									UIColor.systemOrangeColor,
									UIColor.systemPurpleColor ];

	for (NSInteger idx = 0; idx < colors.count; idx++) {
		UIView *card = [[UIView alloc] initWithFrame:CGRectMake(16.0, y, width, 180.0)];
		card.backgroundColor = colors[(NSUInteger)idx];
		card.layer.cornerRadius = 12.0;
		card.layer.masksToBounds = YES;

		UILabel *label = [[UILabel alloc] initWithFrame:CGRectInset(card.bounds, 12.0, 12.0)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		label.textColor = UIColor.whiteColor;
		label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
		label.text = [NSString stringWithFormat:@"卡片 %ld", (long)(idx + 1)];
		[card addSubview:label];

		[self.scrollView addSubview:card];
		y += 200.0;
	}

	self.scrollView.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, y);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	NSLog(@"开始拖拽，offset.y = %.1f", scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	self.offsetLabel.text = [NSString stringWithFormat:@"offset: (%.1f, %.1f)",
							  scrollView.contentOffset.x,
							  scrollView.contentOffset.y];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	NSLog(@"结束拖拽，是否减速: %@", decelerate ? @"YES" : @"NO");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSLog(@"减速结束，offset.y = %.1f", scrollView.contentOffset.y);
}

@end
