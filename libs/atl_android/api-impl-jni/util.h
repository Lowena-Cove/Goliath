/* Stub util.h for ATL Android integration
 * This is a minimal stub until full ATL source is synced from upstream
 * See: https://gitlab.com/android_translation_layer/android_translation_layer
 */

#ifndef ATL_API_IMPL_JNI_UTIL_H
#define ATL_API_IMPL_JNI_UTIL_H

#include <stdlib.h>
#include <stddef.h>

/* Placeholder utility functions - will be replaced by upstream sync */
static inline void *atl_malloc(size_t size) {
    return malloc(size);
}

static inline void atl_free(void *ptr) {
    free(ptr);
}

#endif /* ATL_API_IMPL_JNI_UTIL_H */
