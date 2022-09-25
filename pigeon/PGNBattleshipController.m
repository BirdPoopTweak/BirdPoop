#import "PGNListController.h"
#import <Preferences/PSSpecifier.h>

@interface PGNBattleshipController : PSListController
@end

@interface UITableView (private)
-(CGFloat)_defaultMarginWidth;
@end

@implementation PGNBattleshipController
-(NSArray *)specifiers
{
	if (!_specifiers)
	{
		_specifiers = [self loadSpecifiersFromPlistName:@"Battleship" target:self];

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