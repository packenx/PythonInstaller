#!/sbin/sh
INSTALL_DIR="/data"
archive="$3"
fdout=/proc/self/fd/$2
ui_print()
{
echo "ui_print $1" > $fdout
echo "ui_print" > $fdout
}
ui_print "Making a temporary directory..."
mkdir -p /tmp/python
cd /tmp/python
unzip -o "$archive"
ui_print "Mounting /system part..."
mount /system
ui_print "Installing Python to $INSTALL_DIR..."
cp -rf python $INSTALL_DIR/python
chmod -R 755 $INSTALL_DIR/python
ln -sf $INSTALL_DIR/python/bin/python-launcher.sh /system/xbin/python
ui_print "Unmounting /system part..."
umount /system
exit 0
