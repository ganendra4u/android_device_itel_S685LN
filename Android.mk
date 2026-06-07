LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),S685LN)

include $(CLEAR_VARS)
LOCAL_MODULE        := dtb.img
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(TARGET_OUT_INTERMEDIATES)
LOCAL_SRC_FILES     := prebuilt/dtb.img
include $(BUILD_PREBUILT)

include $(call all-makefiles-under,$(LOCAL_PATH))
endif
