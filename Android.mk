LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
        ANetworkSession.cpp             \
        Parameters.cpp                  \
        ParsedMessage.cpp               \
        sink/LinearRegression.cpp       \
        sink/RTPSink.cpp                \
        sink/TunnelRenderer.cpp         \
        sink/WifiDisplaySink.cpp        \
        TimeSeries.cpp                  \
        wfd.cpp                         \

LOCAL_C_INCLUDES:= \
        $(TOP)/frameworks/av/media/libstagefright \
        $(TOP)/frameworks/native/include/media/openmax \
        $(TOP)/frameworks/av/media/libstagefright/mpeg2ts \

LOCAL_SHARED_LIBRARIES:= \
        libbinder                       \
        libcutils                       \
        libgui                          \
        libmedia                        \
        libstagefright                  \
        libstagefright_foundation       \
        libui                           \
        libutils                        \

LOCAL_LDLIBS := -llog

#ifneq ($(TARGET_ARCH), arm64)
#    LOCAL_LDFLAGS += -Wl,-rpath,/system/lib64
#else
#    LOCAL_LDFLAGS += -Wl,-rpath,/system/lib
#endif

LOCAL_MODULE:= libstagefright_wfd

LOCAL_MODULE_TAGS:= optional

ifeq ($(TARGET_ARCH),arm)
    LOCAL_CFLAGS += -Wno-psabi
endif

LOCAL_CFLAGS += -Wno-multichar -Wno-null-conversion -Wno-unused-parameter -Werror -Wall
LOCAL_CLANG := true
LOCAL_SANITIZE := signed-integer-overflow

include $(BUILD_SHARED_LIBRARY)

#include $(call all-makefiles-under,$(LOCAL_PATH))
