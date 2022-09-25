#import <UIKit/UIKit.h>

@interface BPButton : UIView
@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIVisualEffectView *blurEffectView;
-(instancetype)initWithFrame:(CGRect)arg1 text:(NSString *)text;
@end