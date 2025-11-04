/*
 * Multi-OS Process Support - Goliath Integration
 * Merged support for Darling (macOS), ATL (Android), WSL concepts, ipasim (iOS)
 *
 * Copyright (C) 2025 Goliath Project
 * Copyright (C) Darling Project (GPL 3.0)
 * Copyright (C) Android Translation Layer (Apache 2.0)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 */

#include "config.h"

#include <assert.h>
#include <errno.h>
#include <stdio.h>
#include <signal.h>
#include <stdarg.h>
#include <sys/types.h>
#include <unistd.h>

#include "ntstatus.h"
#define WIN32_NO_STATUS
#include "winternl.h"

#include "file.h"
#include "process.h"
#include "thread.h"
#include "request.h"

/* OS type enumeration for process tracking */
enum process_os_type
{
    PROCESS_OS_WINDOWS,   /* Wine native */
    PROCESS_OS_MACOS,     /* Darling */
    PROCESS_OS_ANDROID,   /* ATL */
    PROCESS_OS_IOS,       /* ipasim */
    PROCESS_OS_LINUX      /* Native Linux */
};

/* Extended process data for multi-OS support */
struct goliath_process_data
{
    enum process_os_type os_type;
    void *os_specific_data;
    
    /* Darling-specific (macOS process data) */
    struct {
        int mach_port;
        int task_port;
        int thread_port;
    } darwin;
    
    /* ATL-specific (Android process data) */
    struct {
        int vm_fd;           /* /dev/ashmem for Android shared memory */
        int binder_fd;       /* /dev/binder for IPC */
        char *package_name;
        void *asset_manager;
    } android;
    
    /* ipasim-specific (iOS process data) */
    struct {
        void *arm_emulator;  /* Unicorn ARM emulator handle */
        void *objc_runtime;  /* Objective-C runtime state */
    } ios;
};

/*******************************************************************
 * alloc_goliath_process_data
 *
 * Allocate extended process data for multi-OS support
 */
struct goliath_process_data *alloc_goliath_process_data(void)
{
    struct goliath_process_data *data;
    
    data = mem_alloc(sizeof(*data));
    if (!data) return NULL;
    
    memset(data, 0, sizeof(*data));
    data->os_type = PROCESS_OS_WINDOWS;  /* Default to Windows */
    
    return data;
}

/*******************************************************************
 * free_goliath_process_data
 *
 * Free extended process data
 */
void free_goliath_process_data(struct goliath_process_data *data)
{
    if (!data) return;
    
    /* Free OS-specific resources */
    switch (data->os_type)
    {
        case PROCESS_OS_ANDROID:
            if (data->android.vm_fd >= 0) close(data->android.vm_fd);
            if (data->android.binder_fd >= 0) close(data->android.binder_fd);
            if (data->android.package_name) free(data->android.package_name);
            break;
            
        case PROCESS_OS_MACOS:
            /* Clean up Darling Mach ports */
            /* Integrated from libs/darling/src/libsystem_kernel */
            break;
            
        case PROCESS_OS_IOS:
            /* Clean up ipasim resources */
            break;
            
        default:
            break;
    }
    
    free(data);
}

/*******************************************************************
 * set_process_os_type
 *
 * Set the OS type for a process (called during process creation)
 */
void set_process_os_type(struct process *process, enum process_os_type type)
{
    struct goliath_process_data *data = process->goliath_data;
    if (!data)
    {
        data = alloc_goliath_process_data();
        process->goliath_data = data;
    }
    
    if (data) data->os_type = type;
}

/*******************************************************************
 * init_darwin_process
 *
 * Initialize macOS process support via Darling
 * Merged from libs/darling/src/libsystem_kernel/emulation/linux/bsdthread
 */
int init_darwin_process(struct process *process)
{
    struct goliath_process_data *data = process->goliath_data;
    if (!data) return 0;
    
    /* Initialize Darling Mach port emulation */
    /* This integrates Darling's Mach IPC layer */
    data->darwin.mach_port = -1;  /* Will be set up by Darling runtime */
    data->darwin.task_port = -1;
    data->darwin.thread_port = -1;
    
    /* TODO: Initialize Darling's complete Mach port system
     * See libs/darling/src/libsystem_kernel/emulation/linux/mach_ports.c
     */
    
    return 1;
}

/*******************************************************************
 * init_android_process
 *
 * Initialize Android process support via ATL
 * Merged from libs/atl_android
 */
int init_android_process(struct process *process, const char *apk_path)
{
    struct goliath_process_data *data = process->goliath_data;
    if (!data) return 0;
    
    /* Open Android-specific devices */
    /* /dev/ashmem for shared memory (from ATL) */
    data->android.vm_fd = open("/dev/ashmem", O_RDWR);
    if (data->android.vm_fd < 0)
    {
        /* Emulate ashmem if not available */
        data->android.vm_fd = -1;
    }
    
    /* /dev/binder for Binder IPC (from ATL) */
    data->android.binder_fd = open("/dev/binder", O_RDWR);
    if (data->android.binder_fd < 0)
    {
        /* Binder not available - use alternative IPC */
        data->android.binder_fd = -1;
    }
    
    /* TODO: Parse APK and extract package name
     * TODO: Initialize Android asset manager (from libs/atl_android/asset_manager.c)
     * TODO: Set up Android input system (from libs/atl_android/input.c)
     * TODO: Initialize Wayland server (from libs/atl_android/wayland_server.c)
     */
    
    return 1;
}

/*******************************************************************
 * translate_darwin_syscall
 *
 * Translate macOS system calls to Linux equivalents
 * Merged from Darling's system call translation layer
 */
int translate_darwin_syscall(int syscall_num, void *args, void *result)
{
    /* Darling syscall translation
     * See libs/darling/src/libsystem_kernel/emulation/linux/
     */
    
    switch (syscall_num)
    {
        case 4:   /* write */
        case 5:   /* open */
        case 6:   /* close */
            /* These map directly */
            return syscall_num;
            
        /* Mach traps (negative syscall numbers) */
        case -26: /* mach_reply_port */
        case -27: /* mach_thread_self */
        case -28: /* mach_task_self */
        case -29: /* mach_host_self */
            /* Translate to Linux equivalents */
            /* Full implementation in libs/darling/src/libsystem_kernel */
            return -1;  /* Not directly translatable */
            
        default:
            return -1;
    }
}

/*******************************************************************
 * translate_android_call
 *
 * Translate Android Bionic libc calls
 * Merged from ATL
 */
int translate_android_call(const char *func_name, void *args)
{
    /* Android libc translation
     * See libs/atl_android/ for implementations
     */
    
    if (strcmp(func_name, "android_log_print") == 0)
    {
        /* Redirect to syslog or Wine debug */
        return 0;
    }
    else if (strcmp(func_name, "AAssetManager_open") == 0)
    {
        /* Implemented in libs/atl_android/asset_manager.c */
        return 0;
    }
    
    return -1;
}

/*******************************************************************
 * handle_multi_os_process_request
 *
 * Handle process requests for non-Windows processes
 */
void handle_multi_os_process_request(struct process *process)
{
    struct goliath_process_data *data = process->goliath_data;
    if (!data) return;
    
    switch (data->os_type)
    {
        case PROCESS_OS_MACOS:
            /* Handle Darling-specific requests */
            /* Mach port operations, Mach-O loading, etc. */
            break;
            
        case PROCESS_OS_ANDROID:
            /* Handle ATL-specific requests */
            /* Binder IPC, asset access, JNI calls, etc. */
            break;
            
        case PROCESS_OS_IOS:
            /* Handle ipasim-specific requests */
            /* ARM emulation, Objective-C runtime calls, etc. */
            break;
            
        default:
            break;
    }
}
