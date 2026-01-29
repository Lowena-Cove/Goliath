/* wayland_server.h for ATL Android integration
 * Minimal Wayland server structures needed by ATL
 */

#ifndef ATL_WAYLAND_SERVER_H
#define ATL_WAYLAND_SERVER_H

#ifdef __cplusplus
extern "C" {
#endif

/* Forward declarations for Wayland structures */
struct wl_display;
struct wl_client;
struct wl_resource;
struct wl_listener;
struct wl_signal;

/* These are minimal forward declarations.
 * The actual implementations come from the system's libwayland-server library.
 */

#ifdef __cplusplus
}
#endif

#endif /* ATL_WAYLAND_SERVER_H */
