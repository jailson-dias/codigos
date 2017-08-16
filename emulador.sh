# emulador="$(cd "$ANDROID_HOME"/tools/bin && ./avdmanager list avd | awk 'FNR==10{ print $2}')"
emulador=("$(cd "$ANDROID_HOME"/tools/bin && ./avdmanager list avd)")
echo "Emuladores Disponível:"
avd=6
num=1
nome=$(echo $emulador | awk '{ print $'$avd'}')
while [ "$nome" != "" ]; do
    echo "$num. $nome"
    avd=$(($avd + 25))
    num=$(($num + 1))
    nome=$(echo $emulador | awk '{ print $'$avd'}')
done

if [ $num == 1 ]; then
    echo "Nenhum emulador encontrado"
else 
    echo "Selecione o emulador que deseja abrir"    
    read abrir
    while [ $abrir -ge $num ]; do
        echo "Emulador não disponível"
        echo "Selecione o emulador que deseja abrir"    
        read abrir
    done
    abrir="$(echo $emulador | awk '{print $'$((6 + ($abrir - 1) * 25))'}')"
    cd $ANDROID_HOME/tools && ./emulator -use-system-libs -avd $abrir
fi
