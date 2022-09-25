#import "PGNListController.h"
#import <Preferences/PSSpecifier.h>

@interface PGNArcheryController : PSListController
@end

@interface UITableView (private)
-(CGFloat)_defaultMarginWidth;
@end

@implementation PGNArcheryController
-(NSArray *)specifiers
{
	if (!_specifiers)
    {
		_specifiers = [self loadSpecifiersFromPlistName:@"Archery" target:self];
        
        for (int i = 0; i < 2; i++)
        {
            PSSpecifier *iconCell = _specifiers[(i * 3) + 1];

            UIImage *icon = [iconCell propertyForKey:@"iconImage"];

            CGFloat iconWidth = icon.size.width;
            CGFloat cellWidth = UIScreen.mainScreen.bounds.size.width - (self.table._defaultMarginWidth * 2);

            CGFloat scale = cellWidth / iconWidth;

            [iconCell setProperty:@(icon.size.height * scale) forKey:@"height"];
        }
    }

	return _specifiers;
}
@end