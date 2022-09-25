#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import <mach-o/loader.h>
#import <mach-o/getsect.h>
#import <objc/runtime.h>
#import <SceneKit/SceneKit.h>
#import <SpriteKit/SpriteKit.h>
#import "BPButton.h"

#define NO_DRM
#define UIColorMake(r, g, b, a) ([UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)/255.f])
#define BUTTON_WIDTH 90

#ifndef DEBUG
#define NSLog(x, ...)
#endif

void MSHookMemory(void *target, const void *data, size_t size);

@interface NSUserDefaults (custom)
-(id)initWithSuiteName:(id)arg1;
@end

NSDictionary *getPreferences();
int clamp(int val, int min, int max);
BOOL BoolForKey(NSString *key, BOOL fallback);
NSInteger IntForKey(NSString *key, NSInteger fallback);
float FloatForKey(NSString *key, float fallback);
void ChangeSectionOffset(const char *segment, const char *section, uint64_t offset, const void *data, size_t size);
void ChangeMethodOffset(Class class, SEL selector, uint64_t offset, uint32_t instruction);
void NopMethodOffset(Class class, SEL selector, uint64_t offset);
NSArray *SaveInstructions(NSArray *addresses);
void RestoreInstructions(NSArray *addresses, NSArray *instructions);
void GenerateMethodOffsetFloatLoad(Class class, SEL selector, unsigned long long offset, float *value, char reg);
NSInteger randomValueBetween(NSInteger min, NSInteger max);