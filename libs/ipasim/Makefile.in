# ipasim (iOS Simulator) Makefile
# Complete integration of ipasim into Goliath/Wine
# ipasim provides iOS application simulation and ARM to x86 translation

STATICLIB = libipasim.a

# Headers Analyzer - analyzes and generates wrappers for iOS headers
HEADERS_ANALYZER_SOURCES = \
	src/HeadersAnalyzer/LLVMHelper.cpp \
	src/HeadersAnalyzer/TapiHelper.cpp \
	src/HeadersAnalyzer/ObjCHelper.cpp \
	src/HeadersAnalyzer/LLDBHelper.cpp \
	src/HeadersAnalyzer/HeadersAnalyzer.cpp \
	src/HeadersAnalyzer/HAContext.cpp \
	src/HeadersAnalyzer/LLDHelper.cpp \
	src/HeadersAnalyzer/DLLHelper.cpp \
	src/HeadersAnalyzer/WrapperIndex.cpp \
	src/HeadersAnalyzer/ClangHelper.cpp \
	src/HeadersAnalyzer/Output.cpp

# C Runtime stubs
CRT_SOURCES = \
	src/crt/stubs.cpp

# Mach-O support
MACHO_SOURCES = \
	src/MachOInitializer.cpp \
	src/IpaSimulator/MachO.cpp

# Objective-C interop
OBJC_SOURCES = \
	src/RTObjCInterop/dllmain.cpp

# IpaSimulator core
IPASIM_CORE_SOURCES = \
	src/IpaSimulator/IpaSimulator.cpp \
	src/IpaSimulator/LoadedLibrary.cpp \
	src/IpaSimulator/SysTranslator.cpp \
	src/IpaSimulator/Emulator.cpp \
	src/IpaSimulator/DynamicLoader.cpp \
	src/IpaSimulator/TextBlockStream.cpp

# IpaSimApp
IPASIM_APP_SOURCES = \
	src/IpaSimulator/IpaSimApp/MainPage.cpp \
	src/IpaSimulator/IpaSimApp/App.cpp \
	src/IpaSimulator/IpaSimApp/pch.cpp \
	src/IpaSimulator/IpaSimApp/LogPage.cpp

# pthreads.2 (Windows pthreads implementation)
PTHREADS_SOURCES = \
	deps/pthreads.2/ptw32_spinlock_check_need_init.c \
	deps/pthreads.2/ptw32_threadStart.c \
	deps/pthreads.2/cancel.c \
	deps/pthreads.2/ptw32_cond_check_need_init.c \
	deps/pthreads.2/ptw32_new.c \
	deps/pthreads.2/pthread_attr_setscope.c \
	deps/pthreads.2/pthread_mutexattr_init.c \
	deps/pthreads.2/pthread_getconcurrency.c \
	deps/pthreads.2/ptw32_processInitialize.c \
	deps/pthreads.2/attr.c \
	deps/pthreads.2/sched_getscheduler.c \
	deps/pthreads.2/pthread_spin_lock.c \
	deps/pthreads.2/semaphore.c \
	deps/pthreads.2/pthread_rwlock_timedrdlock.c \
	deps/pthreads.2/autostatic.c \
	deps/pthreads.2/pthread_attr_setinheritsched.c \
	deps/pthreads.2/pthread_mutex_lock.c \
	deps/pthreads.2/pthread_rwlock_wrlock.c \
	deps/pthreads.2/pthread_condattr_setpshared.c \
	deps/pthreads.2/private.c \
	deps/pthreads.2/pthread_rwlock_rdlock.c \
	deps/pthreads.2/pthread_key_create.c \
	deps/pthreads.2/rwlock.c \
	deps/pthreads.2/ptw32_relmillisecs.c \
	deps/pthreads.2/pthread_attr_getschedparam.c \
	deps/pthreads.2/ptw32_tkAssocDestroy.c \
	deps/pthreads.2/pthread_num_processors_np.c \
	deps/pthreads.2/pthread_condattr_destroy.c \
	deps/pthreads.2/sem_getvalue.c \
	deps/pthreads.2/sched_get_priority_min.c \
	deps/pthreads.2/ptw32_throw.c \
	deps/pthreads.2/ptw32_MCS_lock.c \
	deps/pthreads.2/pthread_rwlockattr_getpshared.c \
	deps/pthreads.2/sem_unlink.c \
	deps/pthreads.2/pthread_mutex_consistent.c \
	deps/pthreads.2/pthread_cancel.c \
	deps/pthreads.2/pthread_spin_trylock.c \
	deps/pthreads.2/signal.c \
	deps/pthreads.2/pthread_barrier_init.c \
	deps/pthreads.2/ptw32_OLL_lock.c \
	deps/pthreads.2/ptw32_rwlock_check_need_init.c \
	deps/pthreads.2/sem_open.c \
	deps/pthreads.2/pthread_attr_getinheritsched.c \
	deps/pthreads.2/pthread_self.c \
	deps/pthreads.2/pthread_once.c \
	deps/pthreads.2/sem_destroy.c \
	deps/pthreads.2/sched.c \
	deps/pthreads.2/mutex.c \
	deps/pthreads.2/tsd.c \
	deps/pthreads.2/pthread_attr_destroy.c \
	deps/pthreads.2/pthread_mutexattr_settype.c \
	deps/pthreads.2/pthread_condattr_getpshared.c \
	deps/pthreads.2/pthread_attr_getdetachstate.c

# Objective-C++ samples
MM_SOURCES = \
	samples/issue28.mm

# All C++ sources
CPP_SOURCES = \
	$(HEADERS_ANALYZER_SOURCES) \
	$(CRT_SOURCES) \
	$(MACHO_SOURCES) \
	$(OBJC_SOURCES) \
	$(IPASIM_CORE_SOURCES) \
	$(IPASIM_APP_SOURCES)

# All C sources
C_SOURCES = \
	$(PTHREADS_SOURCES)

SOURCES = $(CPP_SOURCES) $(C_SOURCES) $(MM_SOURCES)

# Compiler flags for ipasim
EXTRACFLAGS = -DIPASIM -DWINDOWS -D_WIN32 \
	-I$(srcdir)/include \
	-I$(srcdir)/src \
	-I$(srcdir)/deps/pthreads.2 \
	-I$(srcdir)/deps/clang/include \
	-I$(srcdir)/deps/llvm/include \
	-std=c++17

# Note: ipasim requires:
# 1. LLVM/Clang libraries for code analysis and translation
# 2. Unicorn engine for ARM emulation
# 3. Windows-specific APIs (will need adaptation for Linux)
# 4. Objective-C runtime

# Special handling for Objective-C++ files
%.o: %.mm
	$(CXX) -c $(CXXFLAGS) $(EXTRACFLAGS) -fobjc-runtime=gnustep-2.0 -o $@ $<

