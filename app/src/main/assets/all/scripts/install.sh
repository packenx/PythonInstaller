#!/system/bin/sh
# installer
# (c) 2015 Anton Skshidlevsky <meefik@gmail.com>, GPLv3
# $INSTALL_DIR $ENV_DIR $CREATE_SYMLINK

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

busybox printf "Copying Python to $INSTALL_DIR ... "
busybox cp -rf $ENV_DIR/python $INSTALL_DIR/python
if busybox test $? -eq 0
then
    busybox printf "done\n"
else
    busybox printf "fail\n"
fi

busybox printf "Setting permissions ... "
busybox chmod -R 755 $INSTALL_DIR/python
if busybox test $? -eq 0
then
    busybox printf "done\n"
else
    busybox printf "fail\n"
fi

if busybox test "$CREATE_SYMLINK" = "true"
then
    busybox printf "Creating symlink ... "
    busybox ln -sf $INSTALL_DIR/python/bin/python-launcher.sh /system/xbin/python
    if busybox test $? -eq 0
    then
        busybox printf "done\n"
    else
        busybox printf "fail\n"
    fi
fi

if busybox test "$SYSTEM_REMOUNT" -ne 0
then
    busybox printf "Remounting /system to ro ... "
    busybox mount -o ro,remount /system
    if busybox test $? -eq 0
    then
        busybox printf "done\n"
    else
        busybox printf "skip\n"
        exit 1
    fi
fi
