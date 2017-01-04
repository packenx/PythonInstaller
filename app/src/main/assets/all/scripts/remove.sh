#!/system/bin/sh
# uninstaller
# (c) 2015 Anton Skshidlevsky <meefik@gmail.com>, GPLv3
# $INSTALL_DIR $CREATE_SYMLINK

if busybox printf "$INSTALL_DIR" | busybox grep -c "^/system/" > /dev/null || busybox test "$CREATE_SYMLINK" = "true"
then
    SYSTEM_REMOUNT="1"
else
    SYSTEM_REMOUNT="0"
fi

if busybox test "$SYSTEM_REMOUNT" -ne 0
then
    busybox printf "Remounting /system to rw ... "
    busybox mount -o rw,remount /system
    if busybox test $? -eq 0
    then
        busybox printf "done\n"
    else
        busybox printf "fail\n"
        exit 1
    fi
fi

PY_BIN="${INSTALL_DIR}/python/bin/python-launcher.sh"
busybox printf "Removing Python from $INSTALL_DIR: \n"
if busybox test -e "$PY_BIN"
then
    if busybox test -d "$INSTALL_DIR/python"
    then
        busybox printf "* Python ... "
        busybox rm -r "$INSTALL_DIR/python"
        if busybox test $? -eq 0
        then
            busybox printf "done\n"
        else
            busybox printf "fail\n"
        fi
    fi
    if busybox test "$CREATE_SYMLINK" = "true" && busybox test "$(busybox readlink /system/xbin/python)" = "$PY_BIN"
    then
        busybox printf "* symlink ... "
        busybox rm "/system/xbin/python"
        if busybox test $? -eq 0
        then
            busybox printf "done\n"
        else
            busybox printf "fail\n"
        fi
    fi
else
    busybox printf "... path not found.\n"
fi

if busybox test "$SYSTEM_REMOUNT" -ne 0
then
    busybox printf 'Remounting /system to ro ... '
    busybox mount -o ro,remount /system
    if busybox test $? -eq 0
    then
        busybox printf "done\n"
    else
        busybox printf "skip\n"
        exit 1
    fi
fi
