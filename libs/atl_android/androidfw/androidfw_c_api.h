/* Stub androidfw_c_api.h for ATL Android integration
 * This is a minimal stub until full ATL source is synced from upstream
 * See: https://gitlab.com/android_translation_layer/android_translation_layer
 */

#ifndef ANDROIDFW_C_API_H
#define ANDROIDFW_C_API_H

#include <stddef.h>
#include <stdint.h>
#include <sys/types.h>

/* Forward declarations - stubs for Android framework structures */
struct AssetDir;
struct Asset;
struct AssetManager;

/* Stub function declarations */
static inline int Asset_openFileDescriptor(struct Asset *asset, off_t *out_start, off_t *out_length) {
    /* Stub implementation */
    return -1;
}

#endif /* ANDROIDFW_C_API_H */
