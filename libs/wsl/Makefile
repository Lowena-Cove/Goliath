# WSL (Windows Subsystem for Linux) Integration Makefile
# Complete integration of WSL concepts into Goliath/Wine
# WSL provides Linux compatibility on Windows; we're adapting concepts for cross-platform use

STATICLIB = libwsl.a

# WSL Relay - localhost forwarding
WSLRELAY_SOURCES = \
	src/windows/wslrelay/localhost.cpp \
	src/windows/wslrelay/main.cpp

# WSL command-line tool
WSL_SOURCES = \
	src/windows/wsl/main.cpp

# libwsl - core WSL library
LIBWSL_SOURCES = \
	src/windows/libwsl/WslCoreConfigInterface.cpp \
	src/windows/libwsl/DllMain.cpp

# WSL Service components
SERVICE_SOURCES = \
	src/windows/service/exe/GnsPortTrackerChannel.cpp \
	src/windows/service/exe/GuestTelemetryLogger.cpp \
	src/windows/service/exe/NatNetworking.cpp \
	src/windows/service/exe/DnsTunnelingChannel.cpp \
	src/windows/service/exe/WslCoreVm.cpp \
	src/windows/service/exe/LxssSecurity.cpp \
	src/windows/service/exe/Dmesg.cpp \
	src/windows/service/exe/WslCoreFilesystem.cpp \
	src/windows/service/exe/GnsChannel.cpp \
	src/windows/service/exe/LxssInstance.cpp \
	src/windows/service/exe/Lifetime.cpp \
	src/windows/service/exe/MirroredNetworking.cpp \
	src/windows/service/exe/LxssUserCallback.cpp \
	src/windows/service/exe/GnsRpcServer.cpp \
	src/windows/service/exe/LxssIpTables.cpp \
	src/windows/service/exe/WslCoreGuestNetworkService.cpp \
	src/windows/service/exe/LxssUserSessionFactory.cpp \
	src/windows/service/exe/WslCoreHostDnsInfo.cpp \
	src/windows/service/exe/BridgedNetworking.cpp \
	src/windows/service/exe/ServiceMain.cpp \
	src/windows/service/exe/WslCoreInstance.cpp \
	src/windows/service/exe/RingBuffer.cpp \
	src/windows/service/exe/DistributionRegistration.cpp \
	src/windows/service/exe/LxssCreateProcess.cpp \
	src/windows/service/exe/DnsResolver.cpp

# Test sources - Linux unit tests
TEST_LINUX_SOURCES = \
	test/linux/unit_tests/netlink.c \
	test/linux/unit_tests/binfmt.c \
	test/linux/unit_tests/timer.c \
	test/linux/unit_tests/lxtlog.c \
	test/linux/unit_tests/vnet.c \
	test/linux/unit_tests/poll.c \
	test/linux/unit_tests/dup.c \
	test/linux/unit_tests/lxtutil.c \
	test/linux/unit_tests/sysinfo.c \
	test/linux/unit_tests/sched.c \
	test/linux/unit_tests/brk.c \
	test/linux/unit_tests/dev_pt_common.c \
	test/linux/unit_tests/execve.c \
	test/linux/unit_tests/dev_pt.c \
	test/linux/unit_tests/sysfs.c \
	test/linux/unit_tests/ioprio.c \
	test/linux/unit_tests/epoll.c \
	test/linux/unit_tests/lxtfs.c \
	test/linux/unit_tests/timerfd.c \
	test/linux/unit_tests/drvfs.c \
	test/linux/unit_tests/mprotect.c

# Test sources - Windows tests
TEST_WINDOWS_SOURCES = \
	test/windows/MountTests.cpp \
	test/windows/testplugin/Plugin.cpp \
	test/windows/NetworkTests.cpp \
	test/windows/Plan9Tests.cpp \
	test/windows/PolicyTests.cpp \
	test/windows/PluginTests.cpp \
	test/windows/SimpleTests.cpp \
	test/windows/InstallerTests.cpp \
	test/windows/UnitTests.cpp \
	test/windows/Common.cpp \
	test/windows/DrvFsTests.cpp

# All C++ sources
CPP_SOURCES = \
	$(WSLRELAY_SOURCES) \
	$(WSL_SOURCES) \
	$(LIBWSL_SOURCES) \
	$(SERVICE_SOURCES) \
	$(TEST_WINDOWS_SOURCES)

# All C sources
C_SOURCES = \
	$(TEST_LINUX_SOURCES)

SOURCES = $(CPP_SOURCES) $(C_SOURCES)

# Compiler flags for WSL
EXTRACFLAGS = -DWSL -D_WIN32 -DWINDOWS \
	-I$(srcdir)/src/windows/include \
	-I$(srcdir)/test/linux/unit_tests \
	-std=c++17

# Note: WSL integration provides:
# 1. Linux system call translation (adapted for Goliath)
# 2. Filesystem bridging (DrvFs, Plan9, etc.)
# 3. Networking integration
# 4. Process and session management concepts
# These concepts are being adapted for cross-platform use in Goliath

