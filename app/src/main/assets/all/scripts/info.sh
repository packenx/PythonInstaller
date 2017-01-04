#!/system/bin/sh
# information
# (c) 2015 Anton Skshidlevsky <meefik@gmail.com>, GPLv3
# $ENV_DIR $INSTALL_DIR

busybox printf "System:\n"
DEVICE=$(getprop ro.product.model)
busybox printf "* device: $DEVICE\n"
ANDROID=$(getprop ro.build.version.release)
busybox printf "* android: $ANDROID\n"
ARCH=$(busybox uname -m)
busybox printf "* architecture: $ARCH\n"

busybox printf "\nFree space:\n"
DATA_FREE=$(busybox df -Ph /data | busybox grep -v ^Filesystem | busybox awk '{print $4}')
busybox printf "* /data: $DATA_FREE\n"
SYSTEM_FREE=$(busybox df -Ph /system | busybox grep -v ^Filesystem | busybox awk '{print $4}')
busybox printf "* /system: $SYSTEM_FREE\n"

busybox printf "\nLatest Python:\n"
PY_PATH="${ENV_DIR}/python"
PY_BIN="${PY_PATH}/bin/python-launcher.sh"
PY_VERSION=$(${PY_BIN} -V 2>&1 | busybox awk '{print $2}')
busybox printf "* version: $PY_VERSION\n"
PY_SIZE=$(busybox du -sh $PY_PATH | busybox awk '{print $1}')
busybox printf "* size: $PY_SIZE\n"

busybox printf "\nInstalled Python:\n"
PY_PATH="${INSTALL_DIR}/python"
PY_BIN="${PY_PATH}/bin/python-launcher.sh"
if busybox test -e "$PY_BIN"
then
    busybox printf "* location: $PY_PATH\n"
    PY_VERSION=$(${PY_BIN} -V 2>&1 | busybox awk '{print $2}')
    busybox printf "* version: $PY_VERSION\n"
    PY_SIZE=$(busybox du -sh $PY_PATH | busybox awk '{print $1}')
    busybox printf "* size: $PY_SIZE\n"
else
    busybox printf "* not installed\n"
fi
