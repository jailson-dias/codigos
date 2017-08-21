#!/bin/bash
site="https://nodejs.org/en/download/current/"

if [ -z "$(which curl)" ] || [ -z "$(which unzip)" ]; then #verificando ferramentas
    echo "Certifique-se que esteja instalado o curl e o unzip."
    exit 1
fi

#Cuidando dos locais para download e instalação
dest="$HOME"/NodeJS #diretório para instalação
if [ -d "$dest" ];then
    echo -n "O diretório para instalação ($dest) já existe. Ele pode ser apagado? [Y/n] "
    read r
    if [ "$r" = "n" ] || [ "$r" = "N" ];then
        echo -ne "\nOk, escolha outro: "
        read dest
        while [ -e "$dest" ]; do
            echo -en "\nDiretório já existe. Tente novamente: "
            read dest
        done
    fi
    echo "Ok"
    rm -rf "${dest:?}" 2>/dev/null #limpando a casa
fi
download_dir="/tmp/NodeJS"  #local para download
rm -rf "${download_dir:?}"/* 2>/dev/null #limpando
mkdir -p $download_dir #confirmando a existência


#Getting links of node JS
link=($( curl -L "$site" 2> /dev/null | grep -Eo 'http[s]?://([^"]*linux-x64.tar.xz)' | sort | uniq ) ) 2>/dev/null || (echo "Erro ao tentar alcançar $site" && exit 2)
echo "baixando o node JS"
(cd $download_dir && curl -L -C - "$link" -O) || (echo "Erro no download de $link" && exit 2)
nome="$(echo "$link" | grep -Eo '([^/]*$)' )"
(cd $download_dir && tar xf *.tar.xz)
echo -e '\nOk'
rm "${download_dir:?}"/*.tar.xz 2>/dev/null #tirando arquivos compactados
(mv "$download_dir" "$dest") || (echo "Não foi possível instalar em $dest." && exit 4) #movendo para destino final

# # android studio
echo "export PATH=$dest/${nome//.tar.xz}/bin/:"$PATH >> "$HOME"/.bashrc
echo "export PATH=$dest/${nome//.tar.xz}/bin/:"$PATH >> "$HOME"/.profile

echo -e "\nReabra os terminais em execução para atualizar."
