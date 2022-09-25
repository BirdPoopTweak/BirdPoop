ARGET = iphone:clang:13.3:7.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BirdPoop
BirdPoop_FILES = $(wildcard *.m)
BirdPoop_INSTALL_PATH = /Library/PreferenceBundles
BirdPoop_FRAMEWORKS = UIKit
BirdPoop_PRIVATE_FRAMEWORKS = Preferences
BirdPoop_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BirdPoop.plist$(ECHO_END)
