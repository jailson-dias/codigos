emulador="$(cd "$ANDROID_HOME"/tools/bin && ./avdmanager list avd | awk 'FNR==10{ print $2}')"
cd $ANDROID_HOME/tools && ./emulator -avd $emulador
echo $emulador