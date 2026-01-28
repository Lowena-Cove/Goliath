/* Stub looper.h for ATL Android integration
 * This is a minimal stub until full ATL source is synced from upstream
 */

#ifndef ATL_LOOPER_H
#define ATL_LOOPER_H

#include <stdint.h>

/* Stub structures and functions */
struct ALooper;

typedef int (*ALooper_callbackFunc)(int fd, int events, void* data);

static inline struct ALooper* ALooper_forThread(void) {
    return NULL;
}

static inline int ALooper_pollOnce(int timeoutMillis, int* outFd, int* outEvents, void** outData) {
    return -1;
}

#endif /* ATL_LOOPER_H */
