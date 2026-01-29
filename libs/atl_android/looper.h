/* looper.h for ATL Android integration
 * Based on Android Looper API
 */

#ifndef ATL_LOOPER_H
#define ATL_LOOPER_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* ALooper - Android event loop/message loop */
struct ALooper;

/* Looper callback function type */
typedef int (*ALooper_callbackFunc)(int fd, int events, void* data);

/* Looper event types */
enum {
    ALOOPER_EVENT_INPUT = 1 << 0,
    ALOOPER_EVENT_OUTPUT = 1 << 1,
    ALOOPER_EVENT_ERROR = 1 << 2,
    ALOOPER_EVENT_HANGUP = 1 << 3,
    ALOOPER_EVENT_INVALID = 1 << 4,
};

/* Looper prepare options */
enum {
    ALOOPER_PREPARE_ALLOW_NON_CALLBACKS = 1 << 0,
};

/* Looper poll results */
enum {
    ALOOPER_POLL_WAKE = -1,
    ALOOPER_POLL_CALLBACK = -2,
    ALOOPER_POLL_TIMEOUT = -3,
    ALOOPER_POLL_ERROR = -4,
};

/* Get the looper associated with the calling thread, or NULL if none */
struct ALooper* ALooper_forThread(void);

/* Prepare a looper for the calling thread */
struct ALooper* ALooper_prepare(int opts);

/* Acquire a reference to the looper */
void ALooper_acquire(struct ALooper* looper);

/* Release a reference to the looper */
void ALooper_release(struct ALooper* looper);

/* Poll for events */
int ALooper_pollOnce(int timeoutMillis, int* outFd, int* outEvents, void** outData);
int ALooper_pollAll(int timeoutMillis, int* outFd, int* outEvents, void** outData);

/* Wake the looper */
void ALooper_wake(struct ALooper* looper);

/* Add or remove file descriptors */
int ALooper_addFd(struct ALooper* looper, int fd, int ident, int events,
                  ALooper_callbackFunc callback, void* data);
int ALooper_removeFd(struct ALooper* looper, int fd);

#ifdef __cplusplus
}
#endif

#endif /* ATL_LOOPER_H */
