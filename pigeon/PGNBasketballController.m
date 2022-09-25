#import "PGNListController.h"
#import <Preferences/PSSpecifier.h>

@interface PGNBasketballController : PSListController
@end

@interface UITableView (private)
-(CGFloat)_defaultMarginWidth;
@end

@implementation NSString (pp)
-(NSUInteger)unsignedIntegerValue
{
    return [self intValue];
}
@end

@implementation PGNBasketballController
-(NSArray *)specifiers
{
	if (!_specifiers)
    {
		_specifiers = [self loadSpecifiersFromPlistName:@"Basketball" target:self];

        PSSpecifier *iconCell = _specifiers[1];

        UIImage *icon = [iconCell propertyForKey:@"iconImage"];

        CGFloat iconWidth = icon.size.width;
        CGFloat cellWidth = UIScreen.mainScreen.bounds.size.width - (self.table._defaultMarginWidth * 2);

        CGFloat scale = cellWidth / iconWidth;

        [iconCell setProperty:@(icon.size.height * scale) forKey:@"height"];
    }

	return _specifiers;
}
@end