export TARGET = iphone:clang:14.5:7.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = MobileSMS
include $(THEOS)/makefiles/common.mk

GO_EASY_ON_ME=1

TWEAK_NAME = 00BirdPoop
00BirdPoop_FILES = Utils.m BPButton.m Tweak.x 
00BirdPoop_CFLAGS = -fobjc-arc
00BirdPoop_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += pigeon
include $(THEOS_MAKE_PATH)/aggregate.mk
