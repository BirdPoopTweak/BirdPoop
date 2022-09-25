#import <stdint.h>
#import <dlfcn.h>
#import <SpriteKit/SpriteKit.h>
#import "BPButton.h"
#import "Utils.h"

// Needs updating to latest gamepigeon, v224 offsets are probably right but too lazy to fix

__attribute__((always_inline)) 
static void DoPatches()
{
	NSDictionary *v221_offsets = @{
		@"pool_extended_trajectory" : @0x16A0,

		@"pool_disable_hardmode0" : @0x914,
		@"pool_disable_hardmode1" : @0x9B4,
		@"pool_disable_hardmode2" : @0x914,

		@"pool_always_show_trajectory0" : @0x8B4,
		@"pool_always_show_trajectory1" : @0x8C8,
		@"pool_always_show_trajectory2" : @0x964,
		@"pool_always_show_trajectory3" : @0x8B4,
		@"pool_always_show_trajectory4" : @0x8C8,


		@"pool_always_move_cue_ball0" : @0x2774,
		@"pool_always_move_cue_ball1" : @0x2CD4,
		@"pool_always_move_cue_ball2" : @0xB08,
		@"pool_always_move_cue_ball3" : @0x1E18,
		@"pool_always_move_cue_ball4" : @0x2228,
		@"pool_always_move_cue_ball5" : @0xB08,
		@"pool_always_move_cue_ball6" : @0x2778,
		@"pool_always_move_cue_ball7" : @0x2CD8,
		@"pool_always_move_cue_ball8" : @0xB08,

		@"battleship_show_ships" : @0xD60,

		@"archery_remove_timer" : @0x79C,

		@"archery_remove_wind0" : @0x4E8,
		@"archery_remove_wind1" : @0x28,
	};


	NSDictionary *v222_offsets = @{
		@"pool_extended_trajectory" : @0x16A0,

		@"pool_disable_hardmode0" : @0x898,
		@"pool_disable_hardmode1" : @0x92C,
		@"pool_disable_hardmode2" : @0x898,

		@"pool_always_show_trajectory0" : @0x834,
		@"pool_always_show_trajectory1" : @0x848,
		@"pool_always_show_trajectory2" : @0x8DC,
		@"pool_always_show_trajectory3" : @0x834,
		@"pool_always_show_trajectory4" : @0x848,


		@"pool_always_move_cue_ball0" : @0x2730,
		@"pool_always_move_cue_ball1" : @0x2C90,
		@"pool_always_move_cue_ball2" : @0xB0C,
		@"pool_always_move_cue_ball3" : @0x1DD8,
		@"pool_always_move_cue_ball4" : @0x2224,
		@"pool_always_move_cue_ball5" : @0xB0C,
		@"pool_always_move_cue_ball6" : @0x2734,
		@"pool_always_move_cue_ball7" : @0x2C94,
		@"pool_always_move_cue_ball8" : @0xB0C,

		@"battleship_show_ships" : @0xD80,

		@"archery_remove_timer" : @0x7CC,

		@"archery_remove_wind0" : @0x4FC,
		@"archery_remove_wind1" : @0x28
	};


	NSDictionary *v224_offsets = @{
		@"pool_extended_trajectory" : @0x16A0, // not used

		@"pool_disable_hardmode0" : @0x898, // done
		@"pool_disable_hardmode1" : @0x944, // done
		@"pool_disable_hardmode2" : @0x898, // done

		@"pool_always_show_trajectory0" : @0x830, // done
		@"pool_always_show_trajectory1" : @0x844, // done
		@"pool_always_show_trajectory2" : @0x8F0, // done
		@"pool_always_show_trajectory3" : @0x830, // done
		@"pool_always_show_trajectory4" : @0x844, // done


		@"pool_always_move_cue_ball0" : @0x2818, // done
		@"pool_always_move_cue_ball1" : @0x2D84, // done
		@"pool_always_move_cue_ball2" : @0x990, // done
		@"pool_always_move_cue_ball3" : @0x1F34, // done
		@"pool_always_move_cue_ball4" : @0x23C8, // done
		@"pool_always_move_cue_ball5" : @0x990, // done
		@"pool_always_move_cue_ball6" : @0x282C, // done
		@"pool_always_move_cue_ball7" : @0x2D98, // done
		@"pool_always_move_cue_ball8" : @0xB0C, // done

		@"battleship_show_ships" : @0xD54, // done

		@"archery_remove_timer" : @0x848, // done

		@"archery_remove_wind0" : @0x580, // done
		@"archery_remove_wind1" : @0x28 // done
	};


	NSDictionary *allOffsets = @{
		@"2.0.9" : v221_offsets,
		@"2.0.10" : v222_offsets,
		@"2.0.11" : v224_offsets
	};
	
	NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
	NSDictionary *offsets = allOffsets[version];

	if (offsets)
	{
		if (BoolForKey(@"pool_extended_trajectory", YES))
		{
			// 8 ball, 9 ball and 8 ball+

			if ([version isEqual:@"2.0.9"]) {
				const float hugeNumber = 1000000000.0f;
				ChangeSectionOffset("__TEXT", "__const", [offsets[@"pool_extended_trajectory"] unsignedLongLongValue], &hugeNumber, sizeof(float));
			} else if ([version isEqual:@"2.0.10"]) {
				uint32_t patch = 0x52a9cdc8; // mov w8, #0x4e6e0000 ; ~998 million float (4 byte)

				ChangeMethodOffset(%c(PoolScene), @selector(mMove), 0x95c, patch);
				ChangeMethodOffset(%c(PoolScene2), @selector(mMove), 0x9ec, patch);
				ChangeMethodOffset(%c(PoolScene3), @selector(mMove), 0x95c, patch);
			} else if ([version isEqual:@"2.0.11"]) {
				uint32_t patch = 0x52a9cdc8; // mov w8, #0x4e6e0000 ; ~998 million float (4 byte)

				ChangeMethodOffset(%c(PoolScene), @selector(mMove), 0x960, patch);
				ChangeMethodOffset(%c(PoolScene2), @selector(mMove), 0xA04, patch);
				ChangeMethodOffset(%c(PoolScene3), @selector(mMove), 0x960, patch);
			}
		}

		if (BoolForKey(@"pool_disable_hardmode", YES))
		{
			// 8 ball
			NopMethodOffset(%c(PoolScene), @selector(mMove), [offsets[@"pool_disable_hardmode0"] unsignedLongLongValue]);

			// 9 ball
			NopMethodOffset(%c(PoolScene2), @selector(mMove), [offsets[@"pool_disable_hardmode1"] unsignedLongLongValue]);

			// 8 ball+
			NopMethodOffset(%c(PoolScene3), @selector(mMove), [offsets[@"pool_disable_hardmode2"] unsignedLongLongValue]);
		}

		if (BoolForKey(@"pool_always_show_trajectory", YES))
		{
			// 8 ball
			NopMethodOffset(%c(PoolScene), @selector(mMove), [offsets[@"pool_always_show_trajectory0"] unsignedLongLongValue]);
			NopMethodOffset(%c(PoolScene), @selector(mMove), [offsets[@"pool_always_show_trajectory1"] unsignedLongLongValue]);

			// 9 ball
			NopMethodOffset(%c(PoolScene2), @selector(mMove), [offsets[@"pool_always_show_trajectory2"] unsignedLongLongValue]);

			// 8 ball+
			NopMethodOffset(%c(PoolScene3), @selector(mMove), [offsets[@"pool_always_show_trajectory3"] unsignedLongLongValue]);
			NopMethodOffset(%c(PoolScene3), @selector(mMove), [offsets[@"pool_always_show_trajectory4"] unsignedLongLongValue]);
		}

		if (BoolForKey(@"pool_always_move_cue_ball", NO))
		{
			// 8 ball
			Class poolSceneClass = %c(PoolScene);
			NopMethodOffset(poolSceneClass, @selector(update:), [offsets[@"pool_always_move_cue_ball0"] unsignedLongLongValue]);
			NopMethodOffset(poolSceneClass, @selector(update:), [offsets[@"pool_always_move_cue_ball1"] unsignedLongLongValue]);
			NopMethodOffset(poolSceneClass, @selector(touchDownAtPoint:), [offsets[@"pool_always_move_cue_ball2"] unsignedLongLongValue]);

			// 9 ball
			Class poolScene2Class = %c(PoolScene2);
			NopMethodOffset(poolScene2Class, @selector(update:), [offsets[@"pool_always_move_cue_ball3"] unsignedLongLongValue]);
			NopMethodOffset(poolScene2Class, @selector(update:), [offsets[@"pool_always_move_cue_ball4"] unsignedLongLongValue]);
			NopMethodOffset(poolScene2Class, @selector(touchDownAtPoint:), [offsets[@"pool_always_move_cue_ball5"] unsignedLongLongValue]);

			// 8 ball+
			Class poolScene3Class = %c(PoolScene3);
			NopMethodOffset(poolScene3Class, @selector(update:), [offsets[@"pool_always_move_cue_ball6"] unsignedLongLongValue]);
			NopMethodOffset(poolScene3Class, @selector(update:), [offsets[@"pool_always_move_cue_ball7"] unsignedLongLongValue]);
			NopMethodOffset(poolScene3Class, @selector(touchDownAtPoint:), [offsets[@"pool_always_move_cue_ball8"] unsignedLongLongValue]);
		}

		// Sea Battle

		if (BoolForKey(@"battleship_show_ships", YES))
		{
			ChangeMethodOffset(%c(SeaScene), @selector(update:), [offsets[@"battleship_show_ships"] unsignedLongLongValue], 0x52800002);
		}

		// Archery

		if (BoolForKey(@"archery_remove_timer", YES))
		{
			NopMethodOffset(%c(ArcheryView), @selector(update), [offsets[@"archery_remove_timer"] unsignedLongLongValue]);
		}
		
		if (BoolForKey(@"archery_remove_wind", YES))
		{
			// disable wind
			// 
			ChangeMethodOffset(%c(ArcheryView), @selector(shoot), [offsets[@"archery_remove_wind0"] unsignedLongLongValue], 0x1E2703E1);

			// ui indicator
			ChangeMethodOffset(%c(ArcheryScene), @selector(setWind:angle:), [offsets[@"archery_remove_wind1"] unsignedLongLongValue], 0x9E6703E0);
		}
	}
}

// Spoof wins

@interface GameIcon : NSObject
-(NSString *)_id;
@end

%hook GameIcon
-(void)setWins:(int)arg1
{
	NSString *wins = getPreferences()[self._id];
	%orig(wins.length ? wins.intValue : arg1);
}
%end

// Debug settings

%hook SKView
-(void)setShowsFPS:(BOOL)enabled
{
	static int showStats = -1;
	if (showStats == -1) {
		showStats = IntForKey(@"ShowsFPSEnabled", 0);
	}

	%orig(showStats);
}
%end

%hook SCNView
-(void)setAntialiasingMode:(SCNAntialiasingMode)mode
{
	static int AAmode = -1;

	if (AAmode == -1) {
		int value = IntForKey(@"AntialiasingMode", 0);

		if (value == 0) {
			AAmode = SCNAntialiasingModeNone;
		} else if (value == 1) {
			AAmode = SCNAntialiasingModeMultisampling2X;
		} else if (value == 2) {
			AAmode = SCNAntialiasingModeMultisampling4X;
		}
	}

	%orig(AAmode);
}
-(void)setShowsStatistics:(BOOL)show
{
	static int showStats = -1;
	if (showStats == -1) {
		showStats = IntForKey(@"ShowsFPSEnabled", 0);
	}

	%orig(showStats);
}
%end

// Basketball

@interface BasketballView : SCNView <SCNSceneRenderer>
@property (nonatomic, retain) BPButton *hackBtn;
@property (nonatomic, retain) BPButton *timerBtn;
@property (nonatomic, retain) NSTimer *autoTimer;
-(void)touchDownAtPoint:(CGPoint)point;
-(void)touchMovedToPoint:(CGPoint)point;
-(void)touchUpAtPoint:(CGPoint)point;
-(void)bXAJKDLBLZ83;
@end

@interface BasketballBall : NSObject
-(SCNNode *)ball;
-(SCNVector3)pos;
@end

%hook BasketballView
%property (nonatomic, retain) BPButton *hackBtn;
%property (nonatomic, retain) BPButton *timerBtn;
%property (nonatomic, retain) NSTimer *autoTimer;
-(void)createScene
{
    %orig;

	self.autoTimer = nil;

	self.hackBtn = [[BPButton alloc] initWithFrame:CGRectMake(5, 85, BUTTON_WIDTH, 35) text:@"Auto (1 Shot)"];
	self.timerBtn = [[BPButton alloc] initWithFrame:CGRectMake(5, 132, BUTTON_WIDTH, 35) text:@"Auto (Timer)"];

    [self addSubview:self.hackBtn];
	[self addSubview:self.timerBtn];

    [self bringSubviewToFront:self.hackBtn];
	[self bringSubviewToFront:self.timerBtn];
}

-(void)touchDownAtPoint:(CGPoint)arg1
{
	CGPoint converted = CGPointMake(arg1.x, self.frame.size.height - arg1.y);

  	if (CGRectContainsPoint(self.hackBtn.frame, converted)) {
		[self bXAJKDLBLZ83];
	} else if (CGRectContainsPoint(self.timerBtn.frame, converted)) {
		if (!self.autoTimer) {
			[self bXAJKDLBLZ83];
			self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:FloatForKey(@"basketball_auto_interval", 0.9) target:self selector:@selector(bXAJKDLBLZ83) userInfo:nil repeats:YES];
		} else {
			[self.autoTimer invalidate];
			self.autoTimer = nil;
		}
	}

    %orig;
}

%new
-(void)bXAJKDLBLZ83
{
	SCNNode *basketNode = [self valueForKey:@"net"];
	if (!basketNode)
		return;

	BasketballBall *gameBall = [self valueForKey:@"game_ball"];
	if (!gameBall)
		return;

	SCNNode *ballNode = [gameBall ball];
	if (!ballNode)
		return;

	CGPoint src = CGPointMake([self projectPoint:ballNode.position].x, 50);
	[self touchDownAtPoint:src];

	static int prefs_miss_chance = -1;
	if (prefs_miss_chance == -1)
		prefs_miss_chance = clamp(IntForKey(@"basketball_miss_chance", 5), 0, 100);

	CGPoint dest;

	SCNVector3 basketPos = [self projectPoint:basketNode.position];
	CGFloat basketX = basketPos.x;
	CGFloat basketY = basketPos.y;

	if (arc4random_uniform(100) <= prefs_miss_chance) {
		dest = CGPointMake(basketX + randomValueBetween(-150, 150), basketY + randomValueBetween(-75, 75));
	} else {
		dest = CGPointMake(basketX, basketY + 10);
	} 

	[self touchMovedToPoint:dest];
}
%end

// Cup pong

@interface BeerView : SCNView
@property (nonatomic, retain) BPButton *autoButton;
@property (nonatomic, retain) BPButton *winButton;
-(void)touchDownAtPoint:(CGPoint)arg1;
-(void)touchMovedToPoint:(CGPoint)arg1;
-(void)touchUpAtPoint:(CGPoint)arg1;
-(void)i8N2H2qQuF;
-(void)rTp8LO6EbS;
@end

@interface BeerCup : NSObject
@property (nonatomic, retain) SCNNode *node;
@property (assign) SCNVector3 pos;
@property (assign) BOOL live;
@end

@interface BeerBall : NSObject
@property (nonatomic, retain) SCNNode *ball;
@end

static float x_vel = 0;
static float z_vel = 0;

%hook BeerView
%property (nonatomic, retain) BPButton *autoButton;
%property (nonatomic, retain) BPButton *winButton;
-(void)createScene
{
	%orig;

	self.autoButton = [[BPButton alloc] initWithFrame:CGRectMake(5, 85, BUTTON_WIDTH, 35) text:@"Auto (1 shot)"];
	self.winButton = [[BPButton alloc] initWithFrame:CGRectMake(5, 132, BUTTON_WIDTH, 35) text:@"Auto (Timer)"];

	[self addSubview:self.autoButton];
	[self addSubview:self.winButton];

	[self bringSubviewToFront:self.autoButton];
	[self bringSubviewToFront:self.winButton];
}

-(void)touchDownAtPoint:(CGPoint)arg1
{
	CGPoint converted = CGPointMake(arg1.x, self.frame.size.height - arg1.y);

	if (CGRectContainsPoint(self.autoButton.frame, converted))
		[self rTp8LO6EbS];
	else if (CGRectContainsPoint(self.winButton.frame, converted))
		[self i8N2H2qQuF];
	else
		%orig;
}

%new
-(void)i8N2H2qQuF // keep shooting until win
{
	BOOL canShoot = NO;

	for (BeerCup *cup in [self valueForKey:@"cups"]) {
		if (cup.live) {
			canShoot = YES;
			break;
		}
	}

	if (canShoot) {
		[self rTp8LO6EbS];
		[self performSelector:_cmd withObject:nil afterDelay:3];
	}
}

%new
-(void)rTp8LO6EbS // shoot into random cup
{
	NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
	
	unsigned long branchOffset;
	unsigned long xLoadOffset = 0x90C;
	unsigned long yLoadOffset = 0x91C;

	if ([version isEqualToString:@"2.0.9"]) {
		branchOffset = 0x794;
	} else if ([version isEqualToString:@"2.0.10"]) {
		branchOffset = 0x79C;
	} else return;

	NSArray *cups = [self valueForKey:@"cups"];
	BeerCup *cup = nil;

	BOOL canShoot = NO;

	for (BeerCup *cup in cups) {
		if (cup.live) {
			canShoot = YES;
			break;
		}
	}

	SCNNode *ball = [[self valueForKey:@"game_ball"] ball];

	if (!canShoot || !ball)
		return;

	while (!cup.live)
		cup = cups[arc4random_uniform(cups.count)];

	SCNVector3 ballPos = ball.position;
	x_vel = (cup.pos.x - ballPos.x) * 1.3;
	z_vel = -1.2 / (cup.pos.z - ballPos.z + 0.25) - 2.91;

	Class cls = %c(BeerView);
	SEL sel = @selector(touchUpAtPoint:);

	unsigned long method = (unsigned long)[cls instanceMethodForSelector:sel];

	NSArray *addresses = @[@(method + branchOffset), @(method + xLoadOffset), @(method + xLoadOffset + 4), @(method + yLoadOffset), @(method + yLoadOffset + 4)];
	NSArray *instructions = SaveInstructions(addresses);

	ChangeMethodOffset(cls, sel, branchOffset, 0x1400003D); // replace b.le with unconditional branch
	GenerateMethodOffsetFloatLoad(cls, sel, xLoadOffset, &x_vel, 8); // generate x_vel load into s8
	GenerateMethodOffsetFloatLoad(cls, sel, yLoadOffset, &z_vel, 9); // generate y_vel load into s9

	SCNVector3 touch = [self projectPoint:ballPos];
	
	CGPoint src = CGPointMake(touch.x, self.frame.size.height - touch.y);
	CGPoint dest = CGPointMake(touch.x, 600);

	[self touchDownAtPoint:src];
	[self touchMovedToPoint:dest];
	[self touchUpAtPoint:dest];

	RestoreInstructions(addresses, instructions); // we do a little untrolling
}
%end

// Anagrams

@interface AnagramsScene : SKScene
@property (nonatomic, retain) NSMutableArray *playableWords;
@property (nonatomic, retain) NSMutableDictionary *blockLookup;
@property (nonatomic, retain) BPButton *nextButton;
@property (nonatomic, retain) BPButton *allButton;
-(void)update:(double)arg1;
-(void)winGame;
-(void)enterWord;
-(void)QEb575qNTC;
-(void)uhJz2BIgOJ;
@end

@interface AnagramsBlock : SKNode
-(NSString *)getLetter;
@end

%hook AnagramsScene
%property (nonatomic, retain) NSMutableArray *playableWords;
%property (nonatomic, retain) NSMutableDictionary *blockLookup;
%property (nonatomic, retain) BPButton *nextButton;
%property (nonatomic, retain) BPButton *allButton;
-(id)loadDict:(id)arg1
{
	NSArray *blocks = [self valueForKey:@"blocks"];

	self.playableWords = [[NSMutableArray alloc] init];
	self.blockLookup = [[NSMutableDictionary alloc] init];

	NSMutableArray *letters = [[NSMutableArray alloc] init];

	for (int i = 0; i < blocks.count; i++)
	{
		NSString *s = [blocks[i] getLetter];
		self.blockLookup[s] = @(i);
		[letters addObject:s];
	}
	
	id orig = %orig;

	for (NSString *word in orig)
	{
		if (word.length)
		{
			NSMutableArray *availableLetters = letters.mutableCopy;
			BOOL canPlay = YES;

			for (int i = 0; i < word.length; i++)
			{
				NSString *letter = [word substringWithRange:NSMakeRange(i, 1)];

				if (![availableLetters containsObject:letter])
				{
					canPlay = NO;
					break;
				}

				for (int i = 0; i < availableLetters.count; i++)
				{
					if ([availableLetters[i] isEqualToString:letter])
					{
						[availableLetters removeObjectAtIndex:i];
						break;
					}
				}
			}

			if (canPlay)
				[self.playableWords addObject:word];
		}
	}

	return orig;
}

-(void)startGame
{
	%orig;
	
	self.nextButton = [[BPButton alloc] initWithFrame:CGRectMake(5, 85, BUTTON_WIDTH, 35) text:@"Auto (1 word)"];
	self.allButton = [[BPButton alloc] initWithFrame:CGRectMake(5, 132, BUTTON_WIDTH, 35) text:@"Auto (All)"];

	[self.view addSubview:self.nextButton];
	[self.view addSubview:self.allButton];

	[self.view bringSubviewToFront:self.nextButton];
	[self.view bringSubviewToFront:self.allButton];
}

-(void)touchDownAtPoint:(CGPoint)arg1
{
	CGPoint converted = CGPointMake(arg1.x, self.frame.size.height - arg1.y);

	if (CGRectContainsPoint(self.allButton.frame, converted)) {
		[self QEb575qNTC];
	} else if (CGRectContainsPoint(self.nextButton.frame, converted)) {
		[self uhJz2BIgOJ];
	} else {
		%orig;
	}
}

-(void)enterWord
{
	NSString *word = @"";

	for (AnagramsBlock *block in [self valueForKey:@"answer"])
	{
		NSString *letter = [block getLetter];
		word = [word stringByAppendingString:letter];
	}

	[self.playableWords removeObject:word];
	%orig;
}

%new
-(void)QEb575qNTC // play all words
{
	[self uhJz2BIgOJ];
	if (self.playableWords.count) {
		[self performSelector:_cmd withObject:nil afterDelay:0.01];
	} else {
		[self winGame];
	}
}

%new
-(void)uhJz2BIgOJ // play word
{
	if (self.playableWords.count) {

		NSString *word = self.playableWords.firstObject;
		NSArray *blocks = [self valueForKey:@"blocks"];

		for (int i = 0; i < word.length; i++)
			[[self valueForKey:@"answer"] addObject:blocks[[self.blockLookup[[word substringWithRange:NSMakeRange(i, 1)]] intValue]]];

		[self enterWord];
	}
}
%end

// Word hunt

@interface HuntScene : SKScene
@property (nonatomic, retain) NSMutableArray *playableWords;
@property (nonatomic, retain) BPButton *nextButton;
@property (nonatomic, retain) BPButton *allButton;
@property (nonatomic, retain) NSTimer *autoTimer;
-(BOOL)checkWord:(NSString *)arg1 flag:(BOOL)arg2;
-(void)revealWords:(BOOL)arg1;
-(void)placeGrid:(BOOL)arg1;
-(void)checkMatches;
-(void)enterWord;
-(void)winGame;
-(void)playAll;
-(void)playOne;
-(void)touchDownAtPoint:(CGPoint)arg1;
-(void)touchMovedToPoint:(CGPoint)arg1;
-(void)touchUpAtPoint:(CGPoint)arg1;
-(void)update:(double)arg1;
@end

%hook HuntScene
%property (nonatomic, retain) NSMutableArray *playableWords;
%property (nonatomic, retain) BPButton *nextButton;
%property (nonatomic, retain) BPButton *allButton;
-(void)startGame
{
	%orig;
	
	self.nextButton = [[BPButton alloc] initWithFrame:CGRectMake(5, 85, BUTTON_WIDTH, 35) text:@"Auto (1 word)"];
	self.allButton = [[BPButton alloc] initWithFrame:CGRectMake(5, 132, BUTTON_WIDTH, 35) text:@"Auto (All)"];
	
	[self.view addSubview:self.nextButton];
	[self.view addSubview:self.allButton];
	
	[self.view bringSubviewToFront:self.nextButton];
	[self.view bringSubviewToFront:self.allButton];
}

-(void)touchDownAtPoint:(CGPoint)arg1
{
	CGPoint converted = CGPointMake(arg1.x, self.frame.size.height - arg1.y);

	if (CGRectContainsPoint(self.allButton.frame, converted)) {
		[self playOne];
		[self playAll];
	} else if (CGRectContainsPoint(self.nextButton.frame, converted)) {
		[self playOne];
	} else {
		%orig;
	}
}

%new
-(void)playAll
{
	CGPoint pt = CGPointMake(0, 0);
	[self touchUpAtPoint:pt];
	if (self.playableWords.count) {
		[self touchDownAtPoint:pt];
		[self playOne];
		[self performSelector:_cmd withObject:nil afterDelay:0.01];
	}
}

%new
-(void)playOne
{
	if (!self.playableWords.count) {
		self.playableWords = [[NSMutableArray alloc] init];

		[self revealWords:YES];
		NSArray *words = [[[[self valueForKey:@"wordList"] valueForKey:@"words_string"] stringByReplacingOccurrencesOfString:@"?" withString:@""] componentsSeparatedByString:@"|"].mutableCopy;

		for (NSString *word in words) {
			if ([self checkWord:word flag:0])
				[self.playableWords addObject:word];
		}
	}

	if (self.playableWords.count) {

		NSString *word = self.playableWords[arc4random_uniform(self.playableWords.count)];
		NSArray *blocks = [self valueForKey:@"blocks"];
		BOOL foundWord = NO;
		
		unsigned int width = [[[self valueForKey:@"grid"] firstObject] count];

		for (id _block in blocks) {
			if (![_block isEqual:NSNull.null]) {

				NSMutableArray *chain = [[NSMutableArray alloc] init];
				NSMutableDictionary *availableLetters = [[self valueForKey:@"grid_letters"] mutableCopy];
				AnagramsBlock *block = (AnagramsBlock *)_block;
				foundWord = YES;

				unsigned int index = [blocks indexOfObject:block];
				int x = index % width;
				int y = index / width;

				for (int i = 0; i < word.length; i++) {

					if (!foundWord)
						break;

					NSString *letter = [word substringWithRange:NSMakeRange(i, 1)];
					block = blocks[y * width + x];

					if ([letter isEqualToString:[block getLetter]]) {
						[chain addObject:block];
						
						if (i < word.length - 1) {
							NSString *nextLetter = [word substringWithRange:NSMakeRange(i + 1, 1)];
							NSMutableArray *letterValues = [availableLetters[letter] mutableCopy];
							NSArray *nextValues = availableLetters[nextLetter];

							for (NSValue *nextVal in nextValues) {
								CGPoint nextPos = nextVal.CGPointValue;
								if (!(x == nextPos.x && y == nextPos.y) && abs(x - (int)nextPos.x) < 2 && abs(y - (int)nextPos.y) < 2) {
									[letterValues removeObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
									availableLetters[letter] = letterValues.copy;
									x = nextPos.x;
									y = nextPos.y;
									goto next;
								}
							}

							foundWord = NO; break;
							next: NULL;
						}
					} else {
						foundWord = NO;
						break;
					}
				}
				
				[self.playableWords removeObject:word];

				if (foundWord) {
					[self setValue:[[NSMutableArray alloc] init] forKey:@"chain"];
					
					for (AnagramsBlock *block in chain) {
						[self setValue:block forKey:@"selected"];
						[[self valueForKey:@"chain"] addObject:block];
					}

					[self checkMatches];
				}
			}
		}
	}
}
%end

// Constructor

static void ReceiveSuccess()
{
	DoPatches();
	%init();
}

__attribute__((noinline)) 
static void Constructor()
{
	NSBundle *bundle = [NSBundle mainBundle];
	NSDictionary *info = [bundle infoDictionary];
	NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
	if ([prodName isEqual:@"GamePigeon"])
	{
		ReceiveSuccess();
	}
}

__attribute__((noinline)) static void JunkFunction1()
{
	
}

__attribute__((noinline)) static void JunkFunction2()
{
	
}

__attribute__((noinline)) static void JunkFunction3()
{
	
}

__attribute__((noinline)) static void JunkFunction4()
{
	
}

%ctor
{
	JunkFunction1();
	JunkFunction2();
	Constructor();
	JunkFunction3();
	JunkFunction4();
}