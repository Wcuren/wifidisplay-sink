/*
 * Copyright 2012, The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//#define LOG_NDEBUG 0
#define LOG_TAG "wfd"
#include <utils/Log.h>
#include "sink/WifiDisplaySink.h"
#include <gui/SurfaceControl.h>
#include <gui/Surface.h>
#include "wfd.h"

namespace android {

extern "C" void wfd_sink_start(const char *sourceHost, int32_t sourcePort, long surface_control_id) {
    sp<SurfaceControl> surface_control = (SurfaceControl*) surface_control_id;
    sp<Surface> surface = surface_control->getSurface();
    sp<ANetworkSession> session = new ANetworkSession;
    session->start();

    sp<ALooper> looper = new ALooper;

    sp<WifiDisplaySink> sink = new WifiDisplaySink(session, surface);
    looper->registerHandler(sink);

    if (sourcePort >= 0) {
        sink->start(sourceHost, sourcePort);
    }

    looper->start(true /* runOnCallingThread */);

}
}
