/* atl_runtime.h for ATL runtime integration
 * Android Translation Layer runtime initialization
 */

#ifndef ATL_RUNTIME_H
#define ATL_RUNTIME_H

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize the ATL runtime
 * Returns 0 on success, non-zero on failure
 */
int atl_runtime_init(void);

#ifdef __cplusplus
}
#endif

#endif /* ATL_RUNTIME_H */
