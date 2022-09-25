#import "BPButton.h"
#import "Utils.h"

@implementation BPButton
-(instancetype)initWithFrame:(CGRect)arg1 text:(NSString *)text {
	if ((self = [super initWithFrame:arg1])) {
		self.blurEffectView = [[UIVisualEffectView alloc] init];
		self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
		self.blurEffectView.alpha = 0.85;
		self.blurEffectView.backgroundColor = UIColorMake(255, 255, 255, 160);
		self.blurEffectView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview: self.blurEffectView];

		[self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
		[self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
		[self.blurEffectView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
		[self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;

		self.textLabel = [[UILabel alloc] init];
		self.textLabel.text = text;
		self.textLabel.textColor = UIColor.blackColor;
		self.textLabel.textAlignment = NSTextAlignmentCenter;
		self.textLabel.font = [UIFont boldSystemFontOfSize:13];
		self.textLabel.adjustsFontSizeToFitWidth = YES;
		self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview: self.textLabel];

		[self.textLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor constant: -5].active = YES;
		[self.textLabel.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
		[self.textLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
		[self.textLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;

		self.layer.cornerRadius = 14;
		self.clipsToBounds = YES;
	}
	return self;
}
@end