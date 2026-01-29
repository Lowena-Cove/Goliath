/* native_window.h for ATL Android integration
 * Based on Android Native Window API
 */

#ifndef ATL_NATIVE_WINDOW_H
#define ATL_NATIVE_WINDOW_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* ANativeWindow - represents a native window/surface */
struct ANativeWindow;

/* Window transformation flags */
enum {
    ANATIVEWINDOW_TRANSFORM_IDENTITY = 0x00,
    ANATIVEWINDOW_TRANSFORM_MIRROR_HORIZONTAL = 0x01,
    ANATIVEWINDOW_TRANSFORM_MIRROR_VERTICAL = 0x02,
    ANATIVEWINDOW_TRANSFORM_ROTATE_90 = 0x04,
    ANATIVEWINDOW_TRANSFORM_ROTATE_180 = 0x03,
    ANATIVEWINDOW_TRANSFORM_ROTATE_270 = 0x07,
};

/* ANativeWindow functions */
void ANativeWindow_acquire(struct ANativeWindow* window);
void ANativeWindow_release(struct ANativeWindow* window);
int32_t ANativeWindow_getWidth(struct ANativeWindow* window);
int32_t ANativeWindow_getHeight(struct ANativeWindow* window);
int32_t ANativeWindow_getFormat(struct ANativeWindow* window);
int32_t ANativeWindow_setBuffersGeometry(struct ANativeWindow* window,
                                          int32_t width, int32_t height, int32_t format);
int32_t ANativeWindow_setBuffersTransform(struct ANativeWindow* window, int32_t transform);

/* ANativeWindow buffer operations */
struct ANativeWindow_Buffer {
    int32_t width;
    int32_t height;
    int32_t stride;
    int32_t format;
    void* bits;
    uint32_t reserved[6];
};

int32_t ANativeWindow_lock(struct ANativeWindow* window, struct ANativeWindow_Buffer* outBuffer,
                            void* inOutDirtyBounds);
int32_t ANativeWindow_unlockAndPost(struct ANativeWindow* window);

#ifdef __cplusplus
}
#endif

#endif /* ATL_NATIVE_WINDOW_H */
