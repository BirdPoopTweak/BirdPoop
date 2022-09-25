#import "PGNListController.h"
#import <spawn.h>

@interface PGNRootListController : PGNListController
@end

@implementation PGNRootListController
-(NSArray *)specifiers
{
	if (!_specifiers)
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];

	return _specifiers;
}
- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(applySettings)];
    self.navigationItem.rightBarButtonItem = applyButton;
}
-(void)applySettings 
{
	pid_t pid;
	const char *argv[] = {"killall", "MobileSMS", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char *const *)argv, NULL);
}
@end