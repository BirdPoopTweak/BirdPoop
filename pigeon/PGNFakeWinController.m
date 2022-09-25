#import "PGNListController.h"

@interface PGNFakeWinController : PGNListController
@end

@implementation PGNFakeWinController
-(NSArray *)specifiers
{
	if (!_specifiers)
		_specifiers = [self loadSpecifiersFromPlistName:@"Fake" target:self];

	return _specifiers;
}
@end