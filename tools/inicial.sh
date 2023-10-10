#!/bin/bash

source ./tools/criarUsuarioGrupo.sh

# Verifique se o diretório existe
if [ ! -d "/home/publico" ]; then
    # Crie um diretório público acessível a todos os grupos
    mkdir /home/publico
    chmod 777 /home/publico
else
    echo "O diretório já existe: /home/publico"
fi

# Verifica se o arquivo existe
arquivo="$1"
if [ ! -f "$arquivo" ]; then
    echo "O arquivo $arquivo não existe."
    exit 1
fi

cria_usuario_grupo $arquivo