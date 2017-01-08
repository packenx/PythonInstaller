WHEREAMI=$(toolbox readlink -f $0)
SDKVER=$(getprop ro.build.version.sdk)
export PYTHONHOME=${WHEREAMI%/bin/*}
export PYTHONPATH=$PYTHONHOME/lib/python2.7/lib-dynload:$PYTHONHOME/lib/python2.7
export PATH=$PYTHONHOME/bin:$PATH
export LD_LIBRARY_PATH=$PYTHONHOME/lib:$LD_LIBRARY_PATH
if [ SDKVER -gt 20 ]
then $PYTHONHOME/bin/python-with-pie "$@"
else $PYTHONHOME/bin/python "$@"
fi