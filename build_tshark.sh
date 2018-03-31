#!/usr/bin/env bash
#set -x 
function extract() {
    if [ -f "$1" ] ; then
         case "$1" in
             *.tar.bz2)   tar xvjf "$1"     ;;
             *.tar.gz)    tar xvzf "$1"     ;;
             *.tar.xz)    tar xvf "$1"     ;;
             *.bz2)       bunzip2 "$1"      ;;
             *.rar)       unrar x "$1"      ;;
             *.gz)        gunzip "$1"       ;;
             *.tar)       tar xvf "$1"      ;;
             *.tbz2)      tar xvjf "$1"     ;;
             *.tgz)       tar xvzf "$1"     ;;
             *.zip)       unzip "$1"        ;;
             *.Z)         uncompress "$1"   ;;
             *.7z)        7z x "$1"         ;;
             *)           echo "$1 cannot be extracted via >extract<" ;;
         esac
    else
         echo "'$1' is not a valid file"
    fi
}

##############
## Configs
##############

echo "* Variable Configurations"

WIRESHARK_VERSION="2.4.5"
WIRESHARK_EXTENSION=".tar.xz"
WIRESHARK_DIRECTORY="wireshark-${WIRESHARK_VERSION}"
WIRESHARK_TARBALL="wireshark-${WIRESHARK_VERSION}${WIRESHARK_EXTENSION}"

LIBPCAP_VERSION="1.8.1"
LIBPCAP_EXTENSION=".tar.gz"
LIBPCAP_DIRECTORY="libpcap-${LIBPCAP_VERSION}"
LIBPCAP_TARBALL="libpcap-${LIBPCAP_VERSION}${LIBPCAP_EXTENSION}"

LIBGLIB_VERSION="2.54.3"
LIBGLIB_EXTENSION=".tar.xz"
LIBGLIB_DIRECTORY="glib-${LIBGLIB_VERSION}"
LIBGLIB_TARBALL="glib-${LIBGLIB_VERSION}${LIBGLIB_EXTENSION}"

LIBICONV_VERSION="1.15"
LIBICONV_EXTENSION=".tar.gz"
LIBICONV_DIRECTORY="libiconv-${LIBICONV_VERSION}"
LIBICONV_TARBALL="libiconv-${LIBICONV_VERSION}${LIBICONV_EXTENSION}"

LIBFFI_VERSION="3.2.1"
LIBFFI_EXTENSION=".tar.gz"
LIBFFI_DIRECTORY="libffi-${LIBFFI_VERSION}"
LIBFFI_TARBALL="libffi-${LIBFFI_VERSION}${LIBFFI_EXTENSION}"

GETTEXT_VERSION="0.19.8"
GETTEXT_EXTENSION=".tar.gz"
GETTEXT_DIRECTORY="gettext-${GETTEXT_VERSION}"
GETTEXT_TARBALL="gettext-${GETTEXT_VERSION}${GETTEXT_EXTENSION}"

LIBGCRYPT_VERSION="1.6.5"
LIBGCRYPT_EXTENSION=".tar.bz2"
LIBGCRYPT_DIRECTORY="libgcrypt-${LIBGCRYPT_VERSION}"
LIBGCRYPT_TARBALL="libgcrypt-${LIBGCRYPT_VERSION}${LIBGCRYPT_EXTENSION}"

LIBGPG_VERSION="1.28"
LIBGPG_EXTENSION=".tar.bz2"
LIBGPG_DIRECTORY="libgpg-error-${LIBGPG_VERSION}"
LIBGPG_TARBALL="libgpg-error-${LIBGPG_VERSION}${LIBGPG_EXTENSION}"

GMP_VERSION="6.1.2"
GMP_EXTENSION=".tar.xz"
GMP_DIRECTORY="gmp-${GMP_VERSION}"
GMP_TARBALL="gmp-${GMP_VERSION}${GMP_EXTENSION}"

NETTLE_VERSION="3.4"
NETTLE_EXTENSION=".tar.gz"
NETTLE_DIRECTORY="nettle-${NETTLE_VERSION}"
NETTLE_TARBALL="nettle-${NETTLE_VERSION}${NETTLE_EXTENSION}"

LIBTASN1_VERSION="4.13"
LIBTASN1_EXTENSION=".tar.gz"
LIBTASN1_DIRECTORY="libtasn1-${LIBTASN1_VERSION}"
LIBTASN1_TARBALL="libtasn1-${LIBTASN1_VERSION}${LIBTASN1_EXTENSION}"

P11KIT_VERSION="0.23.10"
P11KIT_EXTENSION=".tar.gz"
P11KIT_DIRECTORY="p11-kit-${P11KIT_VERSION}"
P11KIT_TARBALL="p11-kit-${P11KIT_VERSION}${P11KIT_EXTENSION}"

GNUTLS_VERSION="3.5.18"
GNUTLS_EXTENSION=".tar.xz"
GNUTLS_DIRECTORY="gnutls-${GNUTLS_VERSION}"
GNUTLS_TARBALL="gnutls-${GNUTLS_VERSION}${GNUTLS_EXTENSION}"

LZMA_VERSION="5.2.3"
LZMA_EXTENSION=".tar.gz"
LZMA_DIRECTORY="xz-${LZMA_VERSION}"
LZMA_TARBALL="xz-${LZMA_VERSION}${LZMA_EXTENSION}"

LIBXML2_VERSION="2.9.8"
LIBXML2_EXTENSION=".tar.gz"
LIBXML2_DIRECTORY="libxml2-${LIBXML2_VERSION}"
LIBXML2_TARBALL="libxml2-${LIBXML2_VERSION}${LIBXML2_EXTENSION}"

##############
## Download
##############

echo "* Download files"

# Only download glib tarball again if not already downloaded
if [[ ! -f "${LIBGLIB_TARBALL}" ]]; then
  wget -v -nc "https://ftp.gnome.org/pub/gnome/sources/glib/${LIBGLIB_VERSION%.*}/${LIBGLIB_TARBALL}"
fi
if [[ ! -d "${LIBGLIB_DIRECTORY}" ]]; then
  extract "$LIBGLIB_TARBALL"
fi
if [[ ! -d "${LIBGLIB_DIRECTORY}" ]]; then 
  echo "Problem with extracting glib from $LIBGLIB_TARBALL into $LIBGLIB_DIRECTORY!!!" 
  exit -1 
fi

# Only download gnutls tarball again if not already downloaded
if [[ ! -f "${GNUTLS_TARBALL}" ]]; then
  wget -v -nc "https://www.gnupg.org/ftp/gcrypt/gnutls/v${GNUTLS_VERSION%.*}/${GNUTLS_TARBALL}"
fi
if [[ ! -d "${GNUTLS_DIRECTORY}" ]]; then
  extract "$GNUTLS_TARBALL"
fi
if [[ ! -d "${GNUTLS_DIRECTORY}" ]]; then 
  echo "Problem with extracting gnutls from $GNUTLS_TARBALL into $GNUTLS_DIRECTORY!!!" 
  exit -1 
fi

# Only download nettle tarball again if not already downloaded
if [[ ! -f "${NETTLE_TARBALL}" ]]; then
  wget -v -nc "https://ftp.gnu.org/gnu/nettle/${NETTLE_TARBALL}"
fi
if [[ ! -d "${NETTLE_DIRECTORY}" ]]; then
  extract "$NETTLE_TARBALL"
fi
if [[ ! -d "${NETTLE_DIRECTORY}" ]]; then 
  echo "Problem with extracting libnettle from $NETTLE_TARBALL into $NETTLE_DIRECTORY!!!" 
  exit -1 
fi

# Only download lzma tarball again if not already downloaded
if [[ ! -f "${LZMA_TARBALL}" ]]; then
  wget -v -nc "https://phoenixnap.dl.sourceforge.net/project/lzmautils/${LZMA_TARBALL}"
fi
if [[ ! -d "${LZMA_DIRECTORY}" ]]; then
  extract "$LZMA_TARBALL"
fi
if [[ ! -d "${LZMA_DIRECTORY}" ]]; then 
  echo "Problem with extracting liblzma from $LZMA_TARBALL into $LZMA_DIRECTORY!!!" 
  exit -1 
fi

# Only download p11kit tarball again if not already downloaded
if [[ ! -f "${P11KIT_TARBALL}" ]]; then
  wget -v -nc "https://github.com/p11-glue/p11-kit/releases/download/${P11KIT_VERSION}/${P11KIT_TARBALL}"
fi
if [[ ! -d "${P11KIT_DIRECTORY}" ]]; then
  extract "$P11KIT_TARBALL"
fi
if [[ ! -d "${P11KIT_DIRECTORY}" ]]; then 
  echo "Problem with extracting p11-kit from $P11KIT_TARBALL into $P11KIT_DIRECTORY!!!" 
  exit -1 
fi

# Only download libtasn1 tarball again if not already downloaded
if [[ ! -f "${LIBTASN1_TARBALL}" ]]; then
  wget -v -nc "https://ftp.gnu.org/gnu/libtasn1/${LIBTASN1_TARBALL}"
fi
if [[ ! -d "${LIBTASN1_DIRECTORY}" ]]; then
  extract "$LIBTASN1_TARBALL"
fi
if [[ ! -d "${LIBTASN1_DIRECTORY}" ]]; then 
  echo "Problem with extracting libtasn1 from $LIBTASN1_TARBALL into $LIBTASN1_DIRECTORY!!!" 
  exit -1 
fi

# Only download gmp tarball again if not already downloaded
if [[ ! -f "${GMP_TARBALL}" ]]; then
  wget -v -nc "https://ftp.gnu.org/gnu/gmp/${GMP_TARBALL}"
fi
if [[ ! -d "${GMP_DIRECTORY}" ]]; then
  extract "$GMP_TARBALL"
fi
if [[ ! -d "${GMP_DIRECTORY}" ]]; then 
  echo "Problem with extracting gmp from $GMP_TARBALL into $GMP_DIRECTORY!!!" 
  exit -1 
fi

# Only download libgcrypt tarball again if not already downloaded
if [[ ! -f "${LIBGCRYPT_TARBALL}" ]]; then
  wget -v -nc "https://gnupg.org/ftp/gcrypt/libgcrypt/${LIBGCRYPT_TARBALL}"
fi
if [[ ! -d "${LIBGCRYPT_DIRECTORY}" ]]; then
  extract "$LIBGCRYPT_TARBALL"
fi
if [[ ! -d "${LIBGCRYPT_DIRECTORY}" ]]; then 
  echo "Problem with extracting libgcrypt from $LIBGCRYPT_TARBALL into $LIBGCRYPT_DIRECTORY!!!" 
  exit -1 
fi

# Only download libgpg-error tarball again if not already downloaded
if [[ ! -f "${LIBGPG_TARBALL}" ]]; then
  wget -v -nc "https://gnupg.org/ftp/gcrypt/libgpg-error/${LIBGPG_TARBALL}"
fi
if [[ ! -d "${LIBGPG_DIRECTORY}" ]]; then
  extract "$LIBGPG_TARBALL"
fi
if [[ ! -d "${LIBGPG_DIRECTORY}" ]]; then 
  echo "Problem with extracting libgpg-error from $LIBGPG_TARBALL into $LIBGPG_DIRECTORY!!!" 
  exit -1 
fi

# Only download libffi tarball again if not already downloaded
if [[ ! -f "${LIBFFI_TARBALL}" ]]; then
  wget -v -nc "ftp://sourceware.org/pub/libffi/${LIBFFI_TARBALL}"
fi
if [[ ! -d "${LIBFFI_DIRECTORY}" ]]; then
  extract "$LIBFFI_TARBALL"
fi
if [[ ! -d "${LIBFFI_DIRECTORY}" ]]; then 
  echo "Problem with extracting libffi from $LIBFFI_TARBALL into ${LIBFFI_DIRECTORY}!!!" 
  exit -1 
fi

# Only download gettext tarball again if not already downloaded
if [[ ! -f "${GETTEXT_TARBALL}" ]]; then
  wget -v -nc "http://ftp.gnu.org/pub/gnu/gettext/${GETTEXT_TARBALL}"
fi
if [[ ! -d "${GETTEXT_DIRECTORY}" ]]; then
  extract "$GETTEXT_TARBALL"
fi
if [[ ! -d "${GETTEXT_DIRECTORY}" ]]; then 
  echo "Problem with extracting gettext from $GETTEXT_TARBALL into ${GETTEXT_DIRECTORY}!!!" 
  exit -1 
fi

# Only download libiconv tarball again if not already downloaded
if [[ ! -f "${LIBICONV_TARBALL}" ]]; then
  wget -v -nc "https://ftp.gnu.org/pub/gnu/libiconv/${LIBICONV_TARBALL}"
fi
if [[ ! -d "$LIBICONV_DIRECTORY" ]]; then
  extract "$LIBICONV_TARBALL"
fi
if [[ ! -d "$LIBICONV_DIRECTORY" ]]; then 
  echo "Problem with extracting libiconv from $LIBICONV_TARBALL into $LIBICONV_DIRECTORY!!!" 
  exit -1 
fi

# Only download wireshark tarball again if not already downloaded
if [[ ! -f "${WIRESHARK_TARBALL}" ]]; then
  wget -v -nc "https://2.na.dl.wireshark.org/src/${WIRESHARK_TARBALL}"
fi
if [[ ! -d "$WIRESHARK_DIRECTORY" ]]; then
  extract "$WIRESHARK_TARBALL"
fi
if [[ ! -d "$WIRESHARK_DIRECTORY" ]]; then 
  echo "Problem with extracting wireshark from $WIRESHARK_TARBALL into $WIRESHARK_DIRECTORY!!!" 
  exit -1 
fi

# Only download libpcap tarball again if not already downloaded
if [[ ! -f "${LIBPCAP_TARBALL}" ]]; then
  wget -v -nc "http://www.tcpdump.org/release/${LIBPCAP_TARBALL}"
fi
if [[ ! -d "$LIBPCAP_DIRECTORY" ]]; then
  extract "$LIBPCAP_TARBALL"
fi
if [[ ! -d "$LIBPCAP_DIRECTORY" ]]; then 
  echo "Problem with extracting libpcap from $LIBPCAP_TARBALL into $LIBPCAP_DIRECTORY!!!" 
  exit -1 
fi

# Only download libxml2 tarball again if not already downloaded
if [[ ! -f "${LIBXML2_TARBALL}" ]]; then
  wget -v -nc "ftp://xmlsoft.org/libxml2/${LIBXML2_TARBALL}"
fi
if [[ ! -d "$LIBXML2_DIRECTORY" ]]; then
  extract "$LIBXML2_TARBALL"
fi
if [[ ! -d "$LIBXML2_DIRECTORY" ]]; then 
  echo "Problem with extracting libxml2 from $LIBXML2_TARBALL into $LIBXML2_DIRECTORY!!!" 
  exit -1 
fi


##############
## Setup Env
##############

echo "* Setup TOOLCHAIN"

BUILD_SYS=x86_64-linux-gnu

# Setup Android NDk path
if [[ ! -n $ANDROID_NDK_HOME ]]; then
  export ANDROID_NDK_HOME="/mnt/Lucifer/yanzi/Android/android-ndk-r11c"
fi

# Setup Android lib path (temporary)
if [[ ! -d ${HOME}/.android_lib/ ]]; then
  mkdir ${HOME}/.android_lib/
fi
export PREFIX="${HOME}/.android_lib"

# Don't mix up .pc files from your host and build target
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig

# Build target
ARCH_ABI="arm-linux-androideabi-4.9"
ANDROID_PLATFORM=android-21

# setup NDK standalone toolchain
if [[ ! -n $NDK_TOOLCHAIN ]]; then
  export NDK_TOOLCHAIN="/mnt/Lucifer/yanzi/Android/lib/${ANDROID_PLATFORM}-toolchain-r11c"
fi

if [[ ! -d "$NDK_TOOLCHAIN" ]]; then 
  echo "$NDK_TOOLCHAIN does not exist!!!" 
  exit -1 
fi


# ARM Toolchain 
# CROSS_PREFIX=$ANDROID_NDK_HOME/toolchains/${ARCH_ABI}/prebuilt/linux-x86_64/bin
CROSS_PREFIX=${NDK_TOOLCHAIN}/bin
# export AR="${CROSS_PREFIX}/arm-linux-androideabi-ar"
# export LD="${CROSS_PREFIX}/arm-linux-androideabi-ld" 
# export CC="${CROSS_PREFIX}/arm-linux-androideabi-gcc" 
# export CXX="${CROSS_PREFIX}/arm-linux-androideabi-g++" 
export AR=${CROSS_PREFIX}/arm-linux-androideabi-ar
export AS=${CROSS_PREFIX}/arm-linux-androideabi-as
export LD=${CROSS_PREFIX}/arm-linux-androideabi-ld
export NM=${CROSS_PREFIX}/arm-linux-androideabi-nm
export CC=${CROSS_PREFIX}/arm-linux-androideabi-gcc-4.9
export CXX=${CROSS_PREFIX}/arm-linux-androideabi-g++
export CPP=${CROSS_PREFIX}/arm-linux-androideabi-cpp
export CXXCPP=${CROSS_PREFIX}/arm-linux-androideabi-cpp
export STRIP=${CROSS_PREFIX}/arm-linux-androideabi-strip
export RANLIB=${CROSS_PREFIX}/arm-linux-androideabi-ranlib
export STRINGS=${CROSS_PREFIX}/arm-linux-androideabi-strings

[[ ! -d "$ANDROID_NDK_HOME" || ! -f "$AR" || ! -f "$LD" || ! -f "$CC" || ! -f "$CXX" ]] && echo "Make sure AR, LD, CC, CXX variables are defined correctly. Ensure ANDROID_NDK_HOME is defined also" && exit -1 

# Configure build
# SYSROOT=$ANDROID_NDK_HOME/platforms/${ANDROID_PLATFORM}/arch-arm
SYSROOT=${NDK_TOOLCHAIN}/sysroot
export CPPFLAGS="--sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${NDK_TOOLCHAIN}/include/c++/ -fPIE -DANDROID -DNO_XMALLOC -mandroid" 
export CFLAGS="--sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${PREFIX}/include -fPIE -DANDROID -Wno-multichar"
export CXXFLAGS="${CFLAGS}"
export LIBS="-lc"
export LDFLAGS="-Wl,-rpath-link=-I${SYSROOT}/usr/lib -L${SYSROOT}/usr/lib -L${PREFIX}/lib -L${NDK_TOOLCHAIN}/lib -fPIE -pie"

# Needed for Wireshark building
export CC_FOR_BUILD="/usr/bin/cc"
export PATH=$PATH:${PREFIX}/bin:${PREFIX}/lib


##############
## Build Start
##############


# build libiconv for Android
echo "* building libiconv"

cd "$LIBICONV_DIRECTORY"
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath
make -j4
make install
cd ..

# build libffi for Android
echo "* building libffi"

cd "$LIBFFI_DIRECTORY"
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --enable-static
make -j4
make install
cd ..

# build gettext for Android
echo "* building gettext"

cd "$GETTEXT_DIRECTORY"
echo "fix msginit.c error where 'pw_gecos' is not supported in Android"
sed -i.bak 's/pwd->pw_gecos/""/g' gettext-tools/src/msginit.c
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --disable-libasprintf \
  --disable-java \
  --disable-native-java \
  --disable-openmp \
  --disable-curses
make -j4
# ugly fix error when libgettextlib.la relink issue
if [[ ! -f "${PREFIX}/lib/libgettextlib.so" ]]; then
  ln -sf ${PREFIX}/lib/libgettextlib-$GETTEXT_VERSION.so ${PREFIX}/lib/libgettextlib.so
fi
make
make install
cd ..

# build glib for Android
echo "* building glib"

cd "$LIBGLIB_DIRECTORY"
echo ac_cv_alignof_guint32=${ac_cv_alignof_guint32=4} \ 
ac_cv_alignof_guint64=${ac_cv_alignof_guint64=8} \ 
ac_cv_alignof_unsigned_long=${ac_cv_alignof_unsigned_long=8} \ 
ac_cv_build=${ac_cv_build=x86_64-pc-linux-gnu} \ 
ac_cv_c_bigendian=${ac_cv_c_bigendian=no} \ 
ac_cv_c_compiler_gnu=${ac_cv_c_compiler_gnu=yes} \ 
ac_cv_c_const=${ac_cv_c_const=yes} \ 
ac_cv_cxx_compiler_gnu=${ac_cv_cxx_compiler_gnu=yes} \ 
ac_cv_env_CCC_set= \ 
ac_cv_env_CCC_value= \ 
ac_cv_env_CC_set=set \ 
ac_cv_env_CC_value=$CC \ 
ac_cv_env_CFLAGS_set=set \ 
ac_cv_env_CFLAGS_value=$CFLAGS \ 
ac_cv_env_CPPFLAGS_set=set \ 
ac_cv_env_CPPFLAGS_value=$CPPFLAGS \ 
ac_cv_env_CPP_set=set \ 
ac_cv_env_CPP_value=$CPP \ 
ac_cv_env_CXXCPP_set=set \ 
ac_cv_env_CXXCPP_value=$CXXCPP \ 
ac_cv_env_CXXFLAGS_set=set \ 
ac_cv_env_CXXFLAGS_value="${CXXFLAGS}" \ 
ac_cv_env_CXX_set=set \ 
ac_cv_env_CXX_value=$CXX \ 
ac_cv_env_DBUS1_CFLAGS_set= \ 
ac_cv_env_DBUS1_CFLAGS_value= \ 
ac_cv_env_DBUS1_LIBS_set= \ 
ac_cv_env_DBUS1_LIBS_value= \ 
ac_cv_env_GTKDOC_DEPS_CFLAGS_set= \ 
ac_cv_env_GTKDOC_DEPS_CFLAGS_value= \ 
ac_cv_env_GTKDOC_DEPS_LIBS_set= \ 
ac_cv_env_GTKDOC_DEPS_LIBS_value= \ 
ac_cv_env_LDFLAGS_set=set \ 
ac_cv_env_LDFLAGS_value=$LDFLAGS \ 
ac_cv_env_LIBELF_CFLAGS_set= \ 
ac_cv_env_LIBELF_CFLAGS_value= \ 
ac_cv_env_LIBELF_LIBS_set= \ 
ac_cv_env_LIBELF_LIBS_value= \ 
ac_cv_env_LIBFFI_CFLAGS_set= \ 
ac_cv_env_LIBFFI_CFLAGS_value= \ 
ac_cv_env_LIBFFI_LIBS_set= \ 
ac_cv_env_LIBFFI_LIBS_value= \ 
ac_cv_env_LIBS_set=set \ 
ac_cv_env_LIBS_value=-lc \ 
ac_cv_env_LT_SYS_LIBRARY_PATH_set= \ 
ac_cv_env_LT_SYS_LIBRARY_PATH_value= \ 
ac_cv_env_PCRE_CFLAGS_set= \ 
ac_cv_env_PCRE_CFLAGS_value= \ 
ac_cv_env_PCRE_LIBS_set= \ 
ac_cv_env_PCRE_LIBS_value= \ 
ac_cv_env_PKG_CONFIG_LIBDIR_set= \ 
ac_cv_env_PKG_CONFIG_LIBDIR_value= \ 
ac_cv_env_PKG_CONFIG_PATH_set=set \ 
ac_cv_env_PKG_CONFIG_PATH_value=$PKG_CONFIG_PATH \ 
ac_cv_env_PKG_CONFIG_set= \ 
ac_cv_env_PKG_CONFIG_value= \ 
ac_cv_env_PYTHON_set= \ 
ac_cv_env_PYTHON_value= \ 
ac_cv_env_ZLIB_CFLAGS_set= \ 
ac_cv_env_ZLIB_CFLAGS_value= \ 
ac_cv_env_ZLIB_LIBS_set= \ 
ac_cv_env_ZLIB_LIBS_value= \ 
ac_cv_env_build_alias_set=set \ 
ac_cv_env_build_alias_value=${BUILD_SYS} \ 
ac_cv_env_host_alias_set=set \ 
ac_cv_env_host_alias_value=arm-linux-androideabi \ 
ac_cv_env_target_alias_set= \ 
ac_cv_env_target_alias_value= \ 
ac_cv_func__NSGetEnviron=${ac_cv_func__NSGetEnviron=no} \ 
ac_cv_func_alloca_works=${ac_cv_func_alloca_works=yes} \ 
ac_cv_func_bind_textdomain_codeset=${ac_cv_func_bind_textdomain_codeset=yes} \ 
ac_cv_func_clock_gettime=${ac_cv_func_clock_gettime=yes} \ 
ac_cv_func_dcgettext=${ac_cv_func_dcgettext=yes} \ 
ac_cv_func_dlerror=${ac_cv_func_dlerror=yes} \ 
ac_cv_func_dlopen=${ac_cv_func_dlopen=yes} \ 
ac_cv_func_dlsym=${ac_cv_func_dlsym=yes} \ 
ac_cv_func_endmntent=${ac_cv_func_endmntent=yes} \ 
ac_cv_func_endservent=${ac_cv_func_endservent=yes} \ 
ac_cv_func_fallocate=${ac_cv_func_fallocate=yes} \ 
ac_cv_func_fchmod=${ac_cv_func_fchmod=yes} \ 
ac_cv_func_fchown=${ac_cv_func_fchown=yes} \ 
ac_cv_func_fdwalk=${ac_cv_func_fdwalk=no} \ 
ac_cv_func_fsync=${ac_cv_func_fsync=yes} \ 
ac_cv_func_getc_unlocked=${ac_cv_func_getc_unlocked=yes} \ 
ac_cv_func_getfsstat=${ac_cv_func_getfsstat=no} \ 
ac_cv_func_getgrgid_r=${ac_cv_func_getgrgid_r=no} \ 
ac_cv_func_getmntent_r=${ac_cv_func_getmntent_r=yes} \ 
ac_cv_func_getprotobyname_r=${ac_cv_func_getprotobyname_r=no} \ 
ac_cv_func_getpwuid_r=${ac_cv_func_getpwuid_r=yes} \ 
ac_cv_func_getresuid=${ac_cv_func_getresuid=yes} \ 
ac_cv_func_getvfsstat=${ac_cv_func_getvfsstat=no} \ 
ac_cv_func_gmtime_r=${ac_cv_func_gmtime_r=yes} \ 
ac_cv_func_hasmntopt=${ac_cv_func_hasmntopt=no} \ 
ac_cv_func_iconv_open=${ac_cv_func_iconv_open=no} \ 
ac_cv_func_if_indextoname=${ac_cv_func_if_indextoname=yes} \ 
ac_cv_func_if_nametoindex=${ac_cv_func_if_nametoindex=yes} \ 
ac_cv_func_inotify_init1=${ac_cv_func_inotify_init1=yes} \ 
ac_cv_func_issetugid=${ac_cv_func_issetugid=no} \ 
ac_cv_func_lchmod=${ac_cv_func_lchmod=no} \ 
ac_cv_func_lchown=${ac_cv_func_lchown=yes} \ 
ac_cv_func_localtime_r=${ac_cv_func_localtime_r=yes} \ 
ac_cv_func_lstat=${ac_cv_func_lstat=yes} \ 
ac_cv_func_mbrtowc=${ac_cv_func_mbrtowc=yes} \ 
ac_cv_func_memalign=${ac_cv_func_memalign=yes} \ 
ac_cv_func_memmem=${ac_cv_func_memmem=yes} \ 
ac_cv_func_mmap=${ac_cv_func_mmap=yes} \ 
ac_cv_func_newlocale=${ac_cv_func_newlocale=yes} \ 
ac_cv_func_nonposix_getpwuid_r=${ac_cv_func_nonposix_getpwuid_r=no} \ 
ac_cv_func_pipe2=${ac_cv_func_pipe2=yes} \ 
ac_cv_func_poll=${ac_cv_func_poll=yes} \ 
ac_cv_func_posix_getgrgid_r=${ac_cv_func_posix_getgrgid_r=no} \ 
ac_cv_func_posix_getpwuid_r=${ac_cv_func_posix_getpwuid_r=no} \ 
ac_cv_func_posix_memalign=${ac_cv_func_posix_memalign=yes} \ 
ac_cv_func_printf_unix98=${ac_cv_func_printf_unix98=no} \ 
ac_cv_func_prlimit=${ac_cv_func_prlimit=yes} \ 
ac_cv_func_readlink=${ac_cv_func_readlink=yes} \ 
ac_cv_func_realloc_0_nonnull=${ac_cv_func_realloc_0_nonnull=yes} \ 
ac_cv_func_realloc_works=${ac_cv_func_realloc_works=yes} \ 
ac_cv_func_recvmmsg=${ac_cv_func_recvmmsg=yes} \ 
ac_cv_func_sendmmsg=${ac_cv_func_sendmmsg=yes} \ 
ac_cv_func_setenv=${ac_cv_func_setenv=yes} \ 
ac_cv_func_setmntent=${ac_cv_func_setmntent=yes} \ 
ac_cv_func_snprintf=${ac_cv_func_snprintf=yes} \ 
ac_cv_func_snprintf_c99=${ac_cv_func_snprintf_c99=no} \ 
ac_cv_func_socket=${ac_cv_func_socket=yes} \ 
ac_cv_func_splice=${ac_cv_func_splice=yes} \ 
ac_cv_func_statfs=${ac_cv_func_statfs=yes} \ 
ac_cv_func_statvfs=${ac_cv_func_statvfs=no} \ 
ac_cv_func_stpcpy=${ac_cv_func_stpcpy=yes} \ 
ac_cv_func_strcasecmp=${ac_cv_func_strcasecmp=yes} \ 
ac_cv_func_strerror_r=${ac_cv_func_strerror_r=yes} \ 
ac_cv_func_strncasecmp=${ac_cv_func_strncasecmp=yes} \ 
ac_cv_func_strnlen=${ac_cv_func_strnlen=yes} \ 
ac_cv_func_strsignal=${ac_cv_func_strsignal=yes} \ 
ac_cv_func_strtod_l=${ac_cv_func_strtod_l=no} \ 
ac_cv_func_strtoll_l=${ac_cv_func_strtoll_l=yes} \ 
ac_cv_func_strtoull_l=${ac_cv_func_strtoull_l=yes} \ 
ac_cv_func_symlink=${ac_cv_func_symlink=yes} \ 
ac_cv_func_sysctlbyname=${ac_cv_func_sysctlbyname=no} \ 
ac_cv_func_timegm=${ac_cv_func_timegm=yes} \ 
ac_cv_func_unsetenv=${ac_cv_func_unsetenv=yes} \ 
ac_cv_func_uselocale=${ac_cv_func_uselocale=yes} \ 
ac_cv_func_utimes=${ac_cv_func_utimes=yes} \ 
ac_cv_func_valloc=${ac_cv_func_valloc=no} \ 
ac_cv_func_vasprintf=${ac_cv_func_vasprintf=yes} \ 
ac_cv_func_vsnprintf=${ac_cv_func_vsnprintf=yes} \ 
ac_cv_func_vsnprintf_c99=${ac_cv_func_vsnprintf_c99=yes} \ 
ac_cv_func_wcrtomb=${ac_cv_func_wcrtomb=yes} \ 
ac_cv_func_wcslen=${ac_cv_func_wcslen=yes} \ 
ac_cv_func_wcsnlen=${ac_cv_func_wcsnlen=yes} \ 
ac_cv_gnu_library_2_1=${ac_cv_gnu_library_2_1=no} \ 
ac_cv_header_crt_externs_h=${ac_cv_header_crt_externs_h=no} \ 
ac_cv_header_dirent_dirent_h=${ac_cv_header_dirent_dirent_h=yes} \ 
ac_cv_header_dirent_h=${ac_cv_header_dirent_h=yes} \ 
ac_cv_header_dlfcn_h=${ac_cv_header_dlfcn_h=yes} \ 
ac_cv_header_fstab_h=${ac_cv_header_fstab_h=no} \ 
ac_cv_header_inttypes_h=${ac_cv_header_inttypes_h=yes} \ 
ac_cv_header_libelf_h=${ac_cv_header_libelf_h=no} \ 
ac_cv_header_libintl_h=${ac_cv_header_libintl_h=yes} \ 
ac_cv_header_linux_magic_h=${ac_cv_header_linux_magic_h=yes} \ 
ac_cv_header_linux_netlink_h=${ac_cv_header_linux_netlink_h=yes} \ 
ac_cv_header_locale_h=${ac_cv_header_locale_h=yes} \ 
ac_cv_header_mach_mach_time_h=${ac_cv_header_mach_mach_time_h=no} \ 
ac_cv_header_malloc_h=${ac_cv_header_malloc_h=yes} \ 
ac_cv_header_memory_h=${ac_cv_header_memory_h=yes} \ 
ac_cv_header_minix_config_h=${ac_cv_header_minix_config_h=no} \ 
ac_cv_header_mntent_h=${ac_cv_header_mntent_h=yes} \ 
ac_cv_header_sched_h=${ac_cv_header_sched_h=yes} \ 
ac_cv_header_stdc=${ac_cv_header_stdc=yes} \ 
ac_cv_header_stdint_h=${ac_cv_header_stdint_h=yes} \ 
ac_cv_header_stdlib_h=${ac_cv_header_stdlib_h=yes} \ 
ac_cv_header_string_h=${ac_cv_header_string_h=yes} \ 
ac_cv_header_strings_h=${ac_cv_header_strings_h=yes} \ 
ac_cv_header_sys_event_h=${ac_cv_header_sys_event_h=no} \ 
ac_cv_header_sys_filio_h=${ac_cv_header_sys_filio_h=no} \ 
ac_cv_header_sys_inotify_h=${ac_cv_header_sys_inotify_h=yes} \ 
ac_cv_header_sys_mntctl_h=${ac_cv_header_sys_mntctl_h=no} \ 
ac_cv_header_sys_mnttab_h=${ac_cv_header_sys_mnttab_h=no} \ 
ac_cv_header_sys_mount_h=${ac_cv_header_sys_mount_h=yes} \ 
ac_cv_header_sys_param_h=${ac_cv_header_sys_param_h=yes} \ 
ac_cv_header_sys_resource_h=${ac_cv_header_sys_resource_h=yes} \ 
ac_cv_header_sys_select_h=${ac_cv_header_sys_select_h=yes} \ 
ac_cv_header_sys_stat_h=${ac_cv_header_sys_stat_h=yes} \ 
ac_cv_header_sys_statfs_h=${ac_cv_header_sys_statfs_h=yes} \ 
ac_cv_header_sys_statvfs_h=${ac_cv_header_sys_statvfs_h=yes} \ 
ac_cv_header_sys_sysctl_h=${ac_cv_header_sys_sysctl_h=no} \ 
ac_cv_header_sys_time_h=${ac_cv_header_sys_time_h=yes} \ 
ac_cv_header_sys_types_h=${ac_cv_header_sys_types_h=yes} \ 
ac_cv_header_sys_types_h_makedev=${ac_cv_header_sys_types_h_makedev=yes} \ 
ac_cv_header_sys_vfs_h=${ac_cv_header_sys_vfs_h=yes} \ 
ac_cv_header_sys_vfstab_h=${ac_cv_header_sys_vfstab_h=no} \ 
ac_cv_header_sys_vmount_h=${ac_cv_header_sys_vmount_h=no} \ 
ac_cv_header_sys_xattr_h=${ac_cv_header_sys_xattr_h=yes} \ 
ac_cv_header_unistd_h=${ac_cv_header_unistd_h=yes} \ 
ac_cv_header_values_h=${ac_cv_header_values_h=no} \ 
ac_cv_header_xlocale_h=${ac_cv_header_xlocale_h=yes} \ 
ac_cv_host=${ac_cv_host=aarch64-unknown-none} \ 
ac_cv_lib_c_getxattr=${ac_cv_lib_c_getxattr=yes} \ 
ac_cv_lib_elf_elf_begin=${ac_cv_lib_elf_elf_begin=no} \ 
ac_cv_lib_elf_elf_getshdrnum=${ac_cv_lib_elf_elf_getshdrnum=no} \ 
ac_cv_lib_elf_elf_getshdrstrndx=${ac_cv_lib_elf_elf_getshdrstrndx=no} \ 
ac_cv_lib_fam_FAMOpen=${ac_cv_lib_fam_FAMOpen=no} \ 
ac_cv_lib_iconv_libiconv_open=${ac_cv_lib_iconv_libiconv_open=yes} \ 
ac_cv_lib_intl_bindtextdomain=${ac_cv_lib_intl_bindtextdomain=no} \ 
ac_cv_lib_intl_dcgettext=${ac_cv_lib_intl_dcgettext=yes} \ 
ac_cv_lib_intl_ngettext=${ac_cv_lib_intl_ngettext=yes} \ 
ac_cv_lib_selinux_is_selinux_enabled=${ac_cv_lib_selinux_is_selinux_enabled=no} \ 
ac_cv_member_struct_dirent_d_type=${ac_cv_member_struct_dirent_d_type=yes} \ 
ac_cv_member_struct_stat_st_atim_tv_nsec=${ac_cv_member_struct_stat_st_atim_tv_nsec=no} \ 
ac_cv_member_struct_stat_st_atimensec=${ac_cv_member_struct_stat_st_atimensec=yes} \ 
ac_cv_member_struct_stat_st_birthtim=${ac_cv_member_struct_stat_st_birthtim=no} \ 
ac_cv_member_struct_stat_st_birthtim_tv_nsec=${ac_cv_member_struct_stat_st_birthtim_tv_nsec=no} \ 
ac_cv_member_struct_stat_st_birthtime=${ac_cv_member_struct_stat_st_birthtime=no} \ 
ac_cv_member_struct_stat_st_birthtimensec=${ac_cv_member_struct_stat_st_birthtimensec=no} \ 
ac_cv_member_struct_stat_st_blksize=${ac_cv_member_struct_stat_st_blksize=yes} \ 
ac_cv_member_struct_stat_st_blocks=${ac_cv_member_struct_stat_st_blocks=yes} \ 
ac_cv_member_struct_stat_st_ctim_tv_nsec=${ac_cv_member_struct_stat_st_ctim_tv_nsec=no} \ 
ac_cv_member_struct_stat_st_ctimensec=${ac_cv_member_struct_stat_st_ctimensec=yes} \ 
ac_cv_member_struct_stat_st_mtim_tv_nsec=${ac_cv_member_struct_stat_st_mtim_tv_nsec=no} \ 
ac_cv_member_struct_stat_st_mtimensec=${ac_cv_member_struct_stat_st_mtimensec=yes} \ 
ac_cv_member_struct_statfs_f_bavail=${ac_cv_member_struct_statfs_f_bavail=yes} \ 
ac_cv_member_struct_statfs_f_fstypename=${ac_cv_member_struct_statfs_f_fstypename=no} \ 
ac_cv_member_struct_statvfs_f_basetype=${ac_cv_member_struct_statvfs_f_basetype=no} \ 
ac_cv_member_struct_statvfs_f_fstypename=${ac_cv_member_struct_statvfs_f_fstypename=no} \ 
ac_cv_member_struct_tm___tm_gmtoff=${ac_cv_member_struct_tm___tm_gmtoff=no} \ 
ac_cv_member_struct_tm_tm_gmtoff=${ac_cv_member_struct_tm_tm_gmtoff=yes} \ 
ac_cv_objext=${ac_cv_objext=o} \ 
ac_cv_path_EGREP=${ac_cv_path_EGREP='/bin/grep -E'} \ 
ac_cv_path_FGREP=${ac_cv_path_FGREP='/bin/grep -F'} \ 
ac_cv_path_GMSGFMT=${ac_cv_path_GMSGFMT=/usr/bin/msgfmt} \ 
ac_cv_path_GREP=${ac_cv_path_GREP=/bin/grep} \ 
ac_cv_path_MSGFMT=${ac_cv_path_MSGFMT=/usr/bin/msgfmt} \ 
ac_cv_path_PERL_PATH=${ac_cv_path_PERL_PATH=/usr/bin/perl} \ 
ac_cv_path_PYTHON=${ac_cv_path_PYTHON=/usr/bin/python} \ 
ac_cv_path_SED=${ac_cv_path_SED=/bin/sed} \ 
ac_cv_path_XGETTEXT=${ac_cv_path_XGETTEXT=/usr/bin/xgettext} \ 
ac_cv_path_XMLCATALOG=${ac_cv_path_XMLCATALOG=no} \ 
ac_cv_path_ac_pt_PKG_CONFIG=${ac_cv_path_ac_pt_PKG_CONFIG=$PKG_CONFIG_PATH} \ 
ac_cv_path_install=${ac_cv_path_install='/usr/bin/install -c'} \ 
ac_cv_path_lt_DD=${ac_cv_path_lt_DD=/bin/dd} \ 
ac_cv_path_mkdir=${ac_cv_path_mkdir=/bin/mkdir} \ 
ac_cv_prog_AR=${ac_cv_prog_AR=$AR} \ 
ac_cv_prog_AWK=${ac_cv_prog_AWK=mawk} \ 
ac_cv_prog_CC=${ac_cv_prog_CC=$CC} \ 
ac_cv_prog_CPP=${ac_cv_prog_CPP=$CPP} \ 
ac_cv_prog_CXX=${ac_cv_prog_CXX=$CXX} \ 
ac_cv_prog_CXXCPP=${ac_cv_prog_CXXCPP=$CXXCPP} \ 
ac_cv_prog_DBUS_DAEMON=${ac_cv_prog_DBUS_DAEMON=dbus-daemon} \ 
ac_cv_prog_PERL=${ac_cv_prog_PERL=perl} \ 
ac_cv_prog_RANLIB=${ac_cv_prog_RANLIB=$RANLIB} \ 
ac_cv_prog_STRIP=${ac_cv_prog_STRIP=$STRIP} \ 
ac_cv_prog_ac_ct_MANIFEST_TOOL=${ac_cv_prog_ac_ct_MANIFEST_TOOL=mt} \ 
ac_cv_prog_ac_ct_OBJDUMP=${ac_cv_prog_ac_ct_OBJDUMP=objdump} \ 
ac_cv_prog_cc_c89=${ac_cv_prog_cc_c89=} \ 
ac_cv_prog_cc_g=${ac_cv_prog_cc_g=yes} \ 
ac_cv_prog_cxx_g=${ac_cv_prog_cxx_g=yes} \ 
ac_cv_prog_make_make_set=${ac_cv_prog_make_make_set=yes} \ 
ac_cv_safe_to_define___extensions__=${ac_cv_safe_to_define___extensions__=yes} \ 
ac_cv_search_opendir=${ac_cv_search_opendir='none required'} \ 
ac_cv_sizeof___int64=${ac_cv_sizeof___int64=0} \ 
ac_cv_sizeof_char=${ac_cv_sizeof_char=1} \ 
ac_cv_sizeof_int=${ac_cv_sizeof_int=4} \ 
ac_cv_sizeof_long=${ac_cv_sizeof_long=8} \ 
ac_cv_sizeof_long_long=${ac_cv_sizeof_long_long=8} \ 
ac_cv_sizeof_short=${ac_cv_sizeof_short=2} \ 
ac_cv_sizeof_size_t=${ac_cv_sizeof_size_t=8} \ 
ac_cv_sizeof_ssize_t=${ac_cv_sizeof_ssize_t=8} \ 
ac_cv_sizeof_void_p=${ac_cv_sizeof_void_p=8} \ 
ac_cv_sys_file_offset_bits=${ac_cv_sys_file_offset_bits=no} \ 
ac_cv_sys_largefile_CC=${ac_cv_sys_largefile_CC=no} \ 
ac_cv_type_guint32=${ac_cv_type_guint32=yes} \ 
ac_cv_type_guint64=${ac_cv_type_guint64=yes} \ 
ac_cv_type_long_long=${ac_cv_type_long_long=yes} \ 
ac_cv_type_ptrdiff_t=${ac_cv_type_ptrdiff_t=yes} \ 
ac_cv_type_sig_atomic_t=${ac_cv_type_sig_atomic_t=yes} \ 
ac_cv_type_size_t=${ac_cv_type_size_t=yes} \ 
ac_cv_type_struct_ip_mreqn=${ac_cv_type_struct_ip_mreqn=yes} \ 
ac_cv_type_unsigned_long=${ac_cv_type_unsigned_long=yes} \ 
ac_cv_working_alloca_h=${ac_cv_working_alloca_h=yes} \ 
am_cv_CC_dependencies_compiler_type=${am_cv_CC_dependencies_compiler_type=none} \ 
am_cv_CXX_dependencies_compiler_type=${am_cv_CXX_dependencies_compiler_type=none} \ 
am_cv_langinfo_codeset=${am_cv_langinfo_codeset=no} \ 
am_cv_make_support_nested_variables=${am_cv_make_support_nested_variables=yes} \ 
am_cv_pathless_PYTHON=${am_cv_pathless_PYTHON=python} \ 
am_cv_prog_cc_c_o=${am_cv_prog_cc_c_o=yes} \ 
am_cv_prog_tar_ustar=${am_cv_prog_tar_ustar=gnutar} \ 
am_cv_python_platform=${am_cv_python_platform=linux2} \ 
test "${am_cv_python_pyexecdir+set}" = set || am_cv_python_pyexecdir='${exec_prefix}/lib/python2.7/site-packages' \ 
test "${am_cv_python_pythondir+set}" = set || am_cv_python_pythondir='${prefix}/lib/python2.7/site-packages' \ 
am_cv_python_version=${am_cv_python_version=2.7} \ 
am_cv_val_LC_MESSAGES=${am_cv_val_LC_MESSAGES=yes} \ 
bh_cv_c_signed=${bh_cv_c_signed=yes} \ 
cc_cv_CFLAGS__Wall=${cc_cv_CFLAGS__Wall=yes} \ 
cc_cv_CFLAGS__Werror_declaration_after_statement=${cc_cv_CFLAGS__Werror_declaration_after_statement=yes} \ 
cc_cv_CFLAGS__Werror_format_2=${cc_cv_CFLAGS__Werror_format_2=yes} \ 
cc_cv_CFLAGS__Werror_format_security=${cc_cv_CFLAGS__Werror_format_security=no} \ 
cc_cv_CFLAGS__Werror_implicit_function_declaration=${cc_cv_CFLAGS__Werror_implicit_function_declaration=yes} \ 
cc_cv_CFLAGS__Werror_init_self=${cc_cv_CFLAGS__Werror_init_self=yes} \ 
cc_cv_CFLAGS__Werror_missing_include_dirs=${cc_cv_CFLAGS__Werror_missing_include_dirs=yes} \ 
cc_cv_CFLAGS__Werror_missing_prototypes=${cc_cv_CFLAGS__Werror_missing_prototypes=yes} \ 
cc_cv_CFLAGS__Werror_pointer_arith=${cc_cv_CFLAGS__Werror_pointer_arith=yes} \ 
cc_cv_CFLAGS__Wstrict_prototypes=${cc_cv_CFLAGS__Wstrict_prototypes=yes} \ 
glib_cv___va_copy=${glib_cv___va_copy=yes} \ 
glib_cv_compliant_posix_memalign=${glib_cv_compliant_posix_memalign=0} \ 
glib_cv_eventfd=${glib_cv_eventfd=yes} \ 
glib_cv_futex=${glib_cv_futex=yes} \ 
glib_cv_g_atomic_lock_free=${glib_cv_g_atomic_lock_free=yes} \ 
glib_cv_have_libc_enable_secure=${glib_cv_have_libc_enable_secure=no} \ 
glib_cv_have_strlcpy=${glib_cv_have_strlcpy=no} \ 
glib_cv_langinfo_codeset=${glib_cv_langinfo_codeset=no} \ 
glib_cv_langinfo_outdigit=${glib_cv_langinfo_outdigit=no} \ 
glib_cv_langinfo_time=${glib_cv_langinfo_time=no} \ 
glib_cv_long_long_format=${glib_cv_long_long_format=ll} \ 
glib_cv_monotonic_clock=${glib_cv_monotonic_clock=no} \ 
glib_cv_rtldglobal_broken=${glib_cv_rtldglobal_broken=no} \ 
glib_cv_sane_realloc=${glib_cv_sane_realloc=yes} \ 
glib_cv_stack_grows=${glib_cv_stack_grows=no} \ 
glib_cv_uscore=${glib_cv_uscore=no} \ 
glib_cv_use_pid_surrogate=${glib_cv_use_pid_surrogate=yes} \ 
glib_cv_va_copy=${glib_cv_va_copy=yes} \ 
glib_cv_va_val_copy=${glib_cv_va_val_copy=yes} \ 
glib_cv_value_AF_INET6=${glib_cv_value_AF_INET6=10} \ 
glib_cv_value_AF_INET=${glib_cv_value_AF_INET=2} \ 
glib_cv_value_AF_UNIX=${glib_cv_value_AF_UNIX=1} \ 
glib_cv_value_MSG_DONTROUTE=${glib_cv_value_MSG_DONTROUTE=4} \ 
glib_cv_value_MSG_OOB=${glib_cv_value_MSG_OOB=1} \ 
glib_cv_value_MSG_PEEK=${glib_cv_value_MSG_PEEK=2} \ 
glib_cv_value_POLLERR=${glib_cv_value_POLLERR=8} \ 
glib_cv_value_POLLHUP=${glib_cv_value_POLLHUP=16} \ 
glib_cv_value_POLLIN=${glib_cv_value_POLLIN=1} \ 
glib_cv_value_POLLNVAL=${glib_cv_value_POLLNVAL=32} \ 
glib_cv_value_POLLOUT=${glib_cv_value_POLLOUT=4} \ 
glib_cv_value_POLLPRI=${glib_cv_value_POLLPRI=2} \ 
gt_cv_c_long_double=${gt_cv_c_long_double=yes} \ 
gt_cv_c_wchar_t=${gt_cv_c_wchar_t=yes} \ 
gt_cv_c_wint_t=${gt_cv_c_wint_t=yes} \ 
gt_cv_func_dgettext_libc=${gt_cv_func_dgettext_libc=no} \ 
gt_cv_func_dgettext_libintl=${gt_cv_func_dgettext_libintl=yes} \ 
gt_cv_func_ngettext_libc=${gt_cv_func_ngettext_libc=no} \ 
gt_cv_have_gettext=${gt_cv_have_gettext=yes} \ 
jm_ac_cv_header_inttypes_h=${jm_ac_cv_header_inttypes_h=yes} \ 
jm_ac_cv_header_stdint_h=${jm_ac_cv_header_stdint_h=yes} \ 
lt_cv_ar_at_file=${lt_cv_ar_at_file=@} \ 
lt_cv_archive_cmds_need_lc=${lt_cv_archive_cmds_need_lc=no} \ 
lt_cv_deplibs_check_method=${lt_cv_deplibs_check_method=unknown} \ 
lt_cv_file_magic_cmd=${lt_cv_file_magic_cmd='$MAGIC_CMD'} \ 
lt_cv_file_magic_test_file=${lt_cv_file_magic_test_file=} \ 
lt_cv_ld_reload_flag=${lt_cv_ld_reload_flag=-r} \ 
lt_cv_nm_interface=${lt_cv_nm_interface='BSD nm'} \ 
lt_cv_objdir=${lt_cv_objdir=.libs} \ 
lt_cv_path_LD=${lt_cv_path_LD=$LD} \ 
lt_cv_path_LDCXX=${lt_cv_path_LDCXX=$LD} \ 
lt_cv_path_NM=${lt_cv_path_NM=${CROSS_PREFIX}/arm-linux-androideabi-nm} \ 
lt_cv_path_mainfest_tool=${lt_cv_path_mainfest_tool=no} \ 
lt_cv_prog_compiler_c_o=${lt_cv_prog_compiler_c_o=yes} \ 
lt_cv_prog_compiler_c_o_CXX=${lt_cv_prog_compiler_c_o_CXX=yes} \ 
lt_cv_prog_compiler_pic=${lt_cv_prog_compiler_pic='-fPIC -DPIC'} \ 
lt_cv_prog_compiler_pic_CXX=${lt_cv_prog_compiler_pic_CXX='-fPIC -DPIC'} \ 
lt_cv_prog_compiler_pic_works=${lt_cv_prog_compiler_pic_works=yes} \ 
lt_cv_prog_compiler_pic_works_CXX=${lt_cv_prog_compiler_pic_works_CXX=yes} \ 
lt_cv_prog_compiler_rtti_exceptions=${lt_cv_prog_compiler_rtti_exceptions=no} \ 
lt_cv_prog_compiler_static_works=${lt_cv_prog_compiler_static_works=yes} \ 
lt_cv_prog_compiler_static_works_CXX=${lt_cv_prog_compiler_static_works_CXX=yes} \ 
lt_cv_prog_gnu_ld=${lt_cv_prog_gnu_ld=yes} \ 
lt_cv_prog_gnu_ldcxx=${lt_cv_prog_gnu_ldcxx=yes} \ 
lt_cv_sharedlib_from_linklib_cmd=${lt_cv_sharedlib_from_linklib_cmd='printf %s\n'} \ 
lt_cv_sys_global_symbol_pipe=${lt_cv_sys_global_symbol_pipe='sed -n -e '\''s/^.*[    ]\([ABCDGIRSTW][ABCDGIRSTW]*\)[     ][  ]*\([_A-Za-z][_A-Za-z0-9]*\)$/\1 \2 \2/p'\'' | sed '\''/ __gnu_lto/d'\'''} \ 
test "${lt_cv_sys_global_symbol_to_c_name_address+set}" = set || lt_cv_sys_global_symbol_to_c_name_address='sed -n -e '\''s/^: \(.*\) .*$/  {"\1", (void *) 0},/p'\'' -e '\''s/^[ABCDGIRSTW][ABCDGIRSTW]* .* \(.*\)$/  {"\1", (void *) \&\1},/p'\''' \ 
test "${lt_cv_sys_global_symbol_to_c_name_address_lib_prefix+set}" = set || lt_cv_sys_global_symbol_to_c_name_address_lib_prefix='sed -n -e '\''s/^: \(.*\) .*$/  {"\1", (void *) 0},/p'\'' -e '\''s/^[ABCDGIRSTW][ABCDGIRSTW]* .* \(lib.*\)$/  {"\1", (void *) \&\1},/p'\'' -e '\''s/^[ABCDGIRSTW][ABCDGIRSTW]* .* \(.*\)$/  {"lib\1", (void *) \&\1},/p'\''' \ 
lt_cv_sys_global_symbol_to_cdecl=${lt_cv_sys_global_symbol_to_cdecl='sed -n -e '\''s/^T .* \(.*\)$/extern int \1();/p'\'' -e '\''s/^[ABCDGIRSTW][ABCDGIRSTW]* .* \(.*\)$/extern char \1;/p'\'''} \ 
lt_cv_sys_global_symbol_to_import=${lt_cv_sys_global_symbol_to_import=} \ 
lt_cv_sys_max_cmd_len=${lt_cv_sys_max_cmd_len=1572864} \ 
lt_cv_to_host_file_cmd=${lt_cv_to_host_file_cmd=func_convert_file_noop} \ 
lt_cv_to_tool_file_cmd=${lt_cv_to_tool_file_cmd=func_convert_file_noop} \ 
lt_cv_truncate_bin=${lt_cv_truncate_bin='/bin/dd bs=4096 count=1'} \ 
pkg_cv_LIBFFI_CFLAGS=${pkg_cv_LIBFFI_CFLAGS=} \ 
pkg_cv_LIBFFI_LIBS=${pkg_cv_LIBFFI_LIBS='-L$PREFIX/lib -lffi'} \ 
pkg_cv_ZLIB_CFLAGS=${pkg_cv_ZLIB_CFLAGS=} \ 
pkg_cv_ZLIB_LIBS=${pkg_cv_ZLIB_LIBS=-lz} \
> android.cache
chmod a-x android.cache
# ugly fix WEEKDAY_FULL_IS_LOCALE undeclared issue
sed -i.bak 's/!WEEKDAY_FULL_IS_LOCALE/!TRUE/g' glib/gdatetime.c
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-dependency-tracking \
  --cache-file=android.cache \
  --enable-included-printf \
  --enable-static \
  --with-pcre=no
make -j4
make install
cd ..

# build libpcap for Android
echo "* building libpcap"

cd "$LIBPCAP_DIRECTORY"
# ugly fix for missing crtbegin/end_so.a
ln -s ${SYSROOT}/usr/lib/crtbegin_so.o && ln -s ${SYSROOT}/usr/lib/crtend_so.o
# config
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --with-pcap=linux \
  --sysroot=${SYSROOT}
make -j4
make install
cd ..


# gpg-error
cd "$LIBGPG_DIRECTORY"
echo "* building gpg-error"

# fix prob
sed -i.bak 's/_gpgrt_logv_printhex (buffer, length, NULL, NULL)/_gpgrt_logv_printhex (buffer, length, NULL, arg_ptr)/g' src/logging.c
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --enable-static
make -j4
make install
cd ..

# gcrypt
cd "$LIBGCRYPT_DIRECTORY"
echo "* building libgcrypt"

./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --enable-static \
  --with-libgpg-error-prefix=${PREFIX}
make -j4
make install
cd ..

# build gmp for Android
echo "* building gmp"

cd "$GMP_DIRECTORY"
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --enable-static
make -j4
make install
cd ..

# build nettle for Android
echo "* building nettle"

cd "$NETTLE_DIRECTORY"
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --enable-static
make -j4
make install
cd ..

# build gnutls for Android
echo "* building gnutls"

cd "$LIBTASN1_DIRECTORY"
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --enable-static
make -j4
make install
cd ..

# build p11-kit for Android
echo "* building p11-kit"

cd "$P11KIT_DIRECTORY"
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath 
# fix issue SUN_LEN not defined
sed -i.bak '0,/#ifdef OS_UNIX/{s/#ifdef OS_UNIX/#ifndef SUN_LEN\n#define SUN_LEN(su) \\\n  (sizeof(*(su)) - sizeof((su)->sun_path) + strlen((su)->sun_path))\n#endif\n\n#ifdef OS_UNIX/}' p11-kit/server.c
make -j4
make install
cd ..

# build gnutls for Android
echo "* building gnutls"

cd "$GNUTLS_DIRECTORY"
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --enable-static \
  --with-included-unistring \
  --disable-cxx
make -j4
make install
cd ..

# build lzma for Android
echo "* building lzma"

cd "$LZMA_DIRECTORY"
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --enable-static
make -j4
make install
cd ..

# build xml2 for Android
echo "* building libxml2"

cd "$LIBXML2_DIRECTORY"
./configure \
  --build=${BUILD_SYS} \
  --host=arm-linux-androideabi \
  --prefix=${PREFIX} \
  --disable-rpath \
  --enable-static \
  --without-python
make
make install
cd ..

# wireshark
echo "* building wireshark (tshark, dumpcap, etc.)"

cd "$WIRESHARK_DIRECTORY"
./configure \
  --host=arm-linux-androideabi \
  --target=${TOOLCHAIN} \
  --build=${BUILD_SYS} \
  --prefix=${PREFIX} \
  --disable-rpath \
  --with-sysroot=${SYSROOT} \
  --without-plugins \
  --disable-wireshark \
  --disable-editcap \
  --disable-capinfos \
  --disable-captype \
  --disable-mergecap \
  --disable-reordercap \
  --disable-dftest \
  --disable-randpkt \
  --disable-rawshark \
  --disable-androiddump \
  --disable-pcap-ng-default \
  --enable-setuid-install
  "$@"
# ugly fix for implicit declaration of function error
sed -i.bak 's/#ifndef HAVE_MKSTEMPS/#ifdef INITIAL_PATH_SIZE/g' wsutil/tempfile.c
sed -i.bak 's/endgrent();//g' wsutil/privileges.c
sed -i.bak 's/endpwent();//g' wsutil/privileges.c
make -j4
make install
cd ..


# fix ELF warning
if [[ ! -d "termux-elf-cleaner" ]]; then
  git clone https://github.com/termux/termux-elf-cleaner.git
fi
CXX=g++
CFLAGS="-std=c++11 -Wall -Wextra -pedantic"
CPPFLAGS=$CFLAGS
CXXFLAGS=$CFLAGS
LDFLAGS=""
cd termux-elf-cleaner
make
chmod +x $(pwd)/termux-elf-cleaner
export ANDROID_ELF_CLEANER=$(pwd)/termux-elf-cleaner
cd ..


echo "Make sure /system/ is writable"

function adbpush() {
    if [ -f "$1" ] ; then
        $ANDROID_ELF_CLEANER $1
        adb push $1 /sdcard
        adb shell "su -c 'mv /sdcard/$1 /system/lib/'"
    else
         echo "'$1' is not a valid file"
    fi
}

cd $PREFIX/bin
$ANDROID_ELF_CLEANER dumpcap
adb push dumpcap /sdcard/
adb shell "su -c 'mv /sdcard/dumpcap /system/bin/ && chown root:shell /system/bin/dumpcap && chmod 4711 /system/bin/dumpcap'"
$ANDROID_ELF_CLEANER tshark
adb push tshark /sdcard/
adb shell "su -c 'mv /sdcard/tshark /system/bin/ && chown root:shell /system/bin/tshark && chmod +x /system/bin/tshark'"

cd $PREFIX/lib
adbpush libgmp.so
adbpush libhogweed.so.4
adbpush libnettle.so.6
adbpush libtasn1.so.6
adbpush libffi.so.6
adbpush libp11-kit.so
adbpush libgnutls.so
adbpush libgmodule-2.0.so
adbpush libgthread-2.0.so
adbpush libgpg-error.so
adbpush libgcrypt.so
adbpush libpcap.so.1
adbpush libglib-2.0.so
adbpush libwsutil.so
adbpush libiconv.so
adbpush libwiretap.so
adbpush libintl.so
adbpush libwireshark.so
adbpush libxml2.so
adbpush liblzma.so
