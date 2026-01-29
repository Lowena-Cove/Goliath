/* androidfw_c_api.h for ATL Android integration
 * Based on androidfw C API from Android framework
 * See: https://gitlab.com/android_translation_layer/android_translation_layer
 */

#ifndef ANDROIDFW_C_API_H
#define ANDROIDFW_C_API_H

#include <stddef.h>
#include <stdint.h>
#include <sys/types.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Forward declarations for Android framework structures */
struct AssetDir;
struct Asset;
struct AssetManager;

/* Asset functions */
int Asset_openFileDescriptor(struct Asset *asset, off_t *out_start, off_t *out_length);
const void *Asset_getBuffer(struct Asset *asset, bool wordAligned);
off64_t Asset_getLength(struct Asset *asset);
off64_t Asset_getRemainingLength(struct Asset *asset);
ssize_t Asset_read(struct Asset *asset, void *buf, size_t count);
off64_t Asset_seek(struct Asset *asset, off64_t offset, int whence);
void Asset_delete(struct Asset *asset);

/* AssetManager functions */
struct AssetManager *AssetManager_fromJava(void *env, void *assetManager);
struct Asset *AssetManager_open(struct AssetManager *manager, const char *filename, int mode);
struct Asset *AssetManager_openNonAsset(struct AssetManager *manager, const char *filename, int mode);
struct AssetDir *AssetManager_openDir(struct AssetManager *manager, const char *dirName);

/* AssetDir functions */
size_t AssetDir_getFileCount(struct AssetDir *dir);
const char *AssetDir_getFileName(struct AssetDir *dir, size_t index);
int AssetDir_getFileType(struct AssetDir *dir, size_t index);
const char *AssetDir_getNextFileName(struct AssetDir *dir);
void AssetDir_delete(struct AssetDir *dir);

/* Android logging functions */
enum {
    ANDROID_LOG_UNKNOWN = 0,
    ANDROID_LOG_DEFAULT,
    ANDROID_LOG_VERBOSE,
    ANDROID_LOG_DEBUG,
    ANDROID_LOG_INFO,
    ANDROID_LOG_WARN,
    ANDROID_LOG_ERROR,
    ANDROID_LOG_FATAL,
    ANDROID_LOG_SILENT,
};

int android_log_printf(int prio, const char *tag, const char *fmt, ...) __attribute__((__format__(printf, 3, 4)));

#ifdef __cplusplus
}
#endif

#endif /* ANDROIDFW_C_API_H */
