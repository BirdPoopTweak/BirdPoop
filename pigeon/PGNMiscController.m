#import "PGNListController.h"
#import <Preferences/PSSpecifier.h>

@interface PGNMiscController : PGNListController
@end

@interface UITableView (private)
-(CGFloat)_defaultMarginWidth;
@end

@implementation PGNMiscController
-(NSArray *)specifiers
{
	if (!_specifiers)
    {
		_specifiers = [self loadSpecifiersFromPlistName:@"Misc" target:self];
        //PSSpecifier *iconCell = _specifiers[(i * 3) + 1];

        int indices[] = {1, 2, 6};
        for (int i = 0; i < sizeof(indices)/sizeof(indices[0]); i++)
        {
            int idx = indices[i];
            PSSpecifier *iconCell = _specifiers[idx];

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