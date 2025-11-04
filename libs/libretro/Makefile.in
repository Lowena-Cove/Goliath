# Libretro Common Library Makefile
# Complete integration of Libretro into Goliath/Wine
# Libretro provides unified interfaces for game console emulation

STATICLIB = libretro.a

# String utilities
STRING_SOURCES = \
	string/stdstring.c

# CD-ROM support
CDROM_SOURCES = \
	cdrom/cdrom.c

# File operations
FILE_SOURCES = \
	file/archive_file_7z.c \
	file/archive_file.c \
	file/archive_file_zlib.c \
	file/config_file_userdata.c \
	file/config_file.c \
	file/retro_dirent.c \
	file/file_path.c \
	file/file_path_io.c \
	file/nbio/nbio_orbis.c \
	file/nbio/nbio_windowsmmap.c \
	file/nbio/nbio_linux.c \
	file/nbio/nbio_intf.c \
	file/nbio/nbio_unixmmap.c \
	file/nbio/nbio_stdio.c

# Playlist management
PLAYLIST_SOURCES = \
	playlists/label_sanitization.c

# Utilities
UTILS_SOURCES = \
	utils/debugbreak/debugbreak.c \
	utils/sha1.c \
	utils/md5.c \
	utils/djb2.c

# libco - Cooperative threading library
LIBCO_SOURCES = \
	libco/libco.c \
	libco/psp1.c \
	libco/ppc.c \
	libco/armeabi.c \
	libco/ps2.c \
	libco/amd64.c \
	libco/aarch64.c \
	libco/psp2.c \
	libco/sjlj.c \
	libco/x86.c \
	libco/scefiber.c \
	libco/fiber.c \
	libco/ucontext.c

LIBCO_CPP_SOURCES = \
	libco/genode.cpp

# Media detection
MEDIA_SOURCES = \
	media/media_detect_cd.c

# OpenGL state management
GLSM_SOURCES = \
	glsm/glsm.c

# Graphics scaler
GFX_SOURCES = \
	gfx/scaler/pixconv.c \
	gfx/scaler/scaler_filter.c \
	gfx/scaler/scaler.c \
	gfx/scaler/scaler_int.c \
	gfx/gl_capabilities.c

# Format parsers
FORMAT_SOURCES = \
	formats/xml/rxml.c \
	formats/png/rpng.c \
	formats/png/rpng_encode.c \
	formats/bmp/rbmp_encode.c \
	formats/bmp/rbmp.c \
	formats/wav/rwav.c \
	formats/tga/rtga.c \
	formats/image_transfer.c \
	formats/image_texture.c \
	formats/json/rjson.c

# Audio utilities
AUDIO_SOURCES = \
	audio/audio_mix.c \
	audio/audio_mixer.c \
	audio/conversion/s16_to_float.c \
	audio/conversion/float_to_s16.c \
	audio/dsp_filter.c \
	audio/resampler/sinc_resampler.c \
	audio/resampler/nearest_resampler.c \
	audio/resampler/cc_resampler.c

# VFS (Virtual Filesystem)
VFS_SOURCES = \
	vfs/vfs_implementation.c \
	vfs/vfs_implementation_cdrom.c

# Streams
STREAM_SOURCES = \
	streams/chd_stream.c \
	streams/file_stream.c \
	streams/file_stream_transforms.c \
	streams/memory_stream.c \
	streams/network_stream.c \
	streams/rzip_stream.c \
	streams/stdin_stream.c \
	streams/trans_stream.c \
	streams/trans_stream_pipe.c \
	streams/trans_stream_zlib.c

# Lists and data structures  
LIST_SOURCES = \
	lists/dir_list.c \
	lists/file_list.c \
	lists/nested_list.c \
	lists/string_list.c \
	lists/vector_list.c

# Features
FEATURES_SOURCES = \
	features/features_cpu.c

# Encodings
ENCODING_SOURCES = \
	encodings/encoding_utf.c \
	encodings/encoding_crc32.c

# Net utilities
NET_SOURCES = \
	net/net_compat.c \
	net/net_http.c \
	net/net_http_parse.c \
	net/net_socket_ssl.c

# Hash functions
HASH_SOURCES = \
	hash/lrc_hash.c \
	hash/rhash.c

# Time utilities
TIME_SOURCES = \
	time/rtime.c

# Dynamic library loading
DYNLIB_SOURCES = \
	dynamic/dylib.c

# Threading
RTHREADS_SOURCES = \
	rthreads/rthreads.c \
	rthreads/rsemaphore.c \
	rthreads/async_job.c

# All C sources
C_SOURCES = \
	$(STRING_SOURCES) \
	$(CDROM_SOURCES) \
	$(FILE_SOURCES) \
	$(PLAYLIST_SOURCES) \
	$(UTILS_SOURCES) \
	$(LIBCO_SOURCES) \
	$(MEDIA_SOURCES) \
	$(GLSM_SOURCES) \
	$(GFX_SOURCES) \
	$(FORMAT_SOURCES) \
	$(AUDIO_SOURCES) \
	$(VFS_SOURCES) \
	$(STREAM_SOURCES) \
	$(LIST_SOURCES) \
	$(FEATURES_SOURCES) \
	$(ENCODING_SOURCES) \
	$(NET_SOURCES) \
	$(HASH_SOURCES) \
	$(TIME_SOURCES) \
	$(DYNLIB_SOURCES) \
	$(RTHREADS_SOURCES)

# All C++ sources
CPP_SOURCES = \
	$(LIBCO_CPP_SOURCES)

SOURCES = $(C_SOURCES) $(CPP_SOURCES)

# Compiler flags for Libretro
EXTRACFLAGS = -DLIBRETRO -DHAVE_ZLIB \
	-I$(srcdir)/include \
	-I$(srcdir)/libco \
	-I$(srcdir)/audio/resampler \
	-I$(srcdir)/gfx/scaler

