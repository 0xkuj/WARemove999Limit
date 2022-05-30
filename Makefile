TARGET := iphone:clang:latest:14.4
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64e arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WARemove999Limit

WARemove999Limit_FILES = Tweak.xm
WARemove999Limit_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
