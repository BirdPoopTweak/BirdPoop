#import <Foundation/Foundation.h>
#import "Utils.h"



NSDictionary *getPreferences()
{
	static NSDictionary *preferences;
	if (!preferences) {
		CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.ntwerk.birdpoop"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);

		if (keyList) {
			preferences = (__bridge NSDictionary *)CFPreferencesCopyMultiple(keyList, CFSTR("com.ntwerk.birdpoop"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
			CFRelease(keyList);
		}

		if (!preferences)
			preferences = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.ntwerk.birdpoop.plist"];



	}
	return preferences;
}

int clamp(int val, int min, int max) 
{
	if (val > max)
		return max;
	else if (val < min)
		return min;
	else
		return val;
}

BOOL BoolForKey(NSString *key, BOOL fallback)
{
	if (!getPreferences())
		return fallback;

	id object = getPreferences()[key];
	return object ? [object boolValue] : fallback;
}

NSInteger IntForKey(NSString *key, NSInteger fallback)
{
	if (!getPreferences())
		return fallback;

	id object = getPreferences()[key];
	return object ? [object intValue] : fallback;
}

float FloatForKey(NSString *key, float fallback)
{
	if (!getPreferences())
		return fallback;

	id object = getPreferences()[key];
	return object ? [object floatValue] : fallback;
}

static void *GetAddress(uint64_t offset)
{
	static void *base;

	if (!base)
		base = (void *)_dyld_get_image_header(0);

	return base + offset;
}

void ChangeSectionOffset(const char *segment, const char *section, uint64_t offset, const void *data, size_t size)
{
	const struct section_64 *sect = getsectbynamefromheader_64(GetAddress(0), segment, section);
	void *final_offset = GetAddress(sect->offset + offset);
	MSHookMemory(final_offset, (const void *)data, size);
}

void ChangeMethodOffset(Class class, SEL selector, uint64_t offset, uint32_t instruction)
{
	void *final_offset = (void *)[class instanceMethodForSelector:selector] + offset;
	MSHookMemory(final_offset, (const void *)&instruction, sizeof(uint32_t));
}

void NopMethodOffset(Class class, SEL selector, uint64_t offset)
{
	const uint32_t nop = 0x1F2003D5;
	ChangeMethodOffset(class, selector, offset, nop);
}

uint32_t swap(uint32_t u)
{
	return ((u >> 24) & 0xff) | ((u << 8) & 0xff0000) | ((u >> 8) & 0xff00) | ((u << 24) & 0xff000000);
}

NSArray *SaveInstructions(NSArray *addresses)
{
	NSMutableArray *instructions = [[NSMutableArray alloc] init];

	for (NSNumber *address in addresses)
		[instructions addObject:@(*(uint32_t *)address.unsignedLongValue)];

	return instructions.copy;
}

void RestoreInstructions(NSArray *addresses, NSArray *instructions)
{
	size_t count = addresses.count;

	if (count != instructions.count)
		return;

	for (int i = 0; i < count; i++) {
		uint32_t instruction = [instructions[i] unsignedIntValue];
		MSHookMemory((void *)[addresses[i] unsignedLongValue], (const void *)&instruction, sizeof(uint32_t));
	}
}

void GenerateMethodOffsetFloatLoad(Class class, SEL selector, uint64_t offset, float *value, char reg)
{
	void *address = [class instanceMethodForSelector:selector] + offset;
	long page = ((void *)value - address) >> 12;
	uint64_t pageoff = (uint64_t)value & 0xFFF;

	if (((uint64_t)address & 0xFFF) > pageoff)
		page++;

	uint32_t adrp = ((4 | (page & 3)) << 29) | (1 << 28) | (((page >> 2) & 0x7FFFF) << 5) | 8;
	uint32_t ldr = (757 << 22) | ((pageoff / 4) << 10) | (8 << 5) | reg;

	MSHookMemory(address, (const void *)&adrp, sizeof(uint32_t));
	MSHookMemory(address + sizeof(uint32_t), (const void *)&ldr, sizeof(uint32_t));
}

NSInteger randomValueBetween(NSInteger min, NSInteger max) {
    return (NSInteger)(min + arc4random_uniform(max - min + 1));
}
