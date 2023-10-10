#!/bin/bash

cria_usuario_grupo() {
    # Inicialize as variáveis com valores padrão
    local username=""
    local password=""
    local groupname=""
    # Verificar se os argumentos -u e -p e -g ou -U foram fornecidos
    while [ "$#" -gt 0 ]; do
        case "$1" in
            -u)
                username="$2"
                shift 2  # Avance para o próximo argumento
                ;;
            -p)
                password="$2"
                shift 2  # Avance para o próximo argumento
                ;;
            -g)
                groupname="$2"
                shift 2  # Avance para o próximo argumento
                ;;
            -U)
                groupuserpass="$2"
                groupaux=$(echo "$groupuserpass" | cut -d ":" -f 1)
                userAux=$(echo "$groupuserpass" | cut -d ":" -f 2)
                passAux=$(echo "$groupuserpass" | cut -d ":" -f 3)
                
                groupname="$groupaux"
                username="$userAux"
                password="$passAux"
                shift 2  # Avance para o próximo argumento
                ;;
            *)
                # echo "Argumento inválido: $1"
                exit 1
                ;;
        esac
    done
    # Verificar se os argumentos necessários foram fornecidos
    if [ -z "$username" ] || [ -z "$password" ] || [ -z "$groupname" ]; then
        echo "Use: $0 -u usuario -p senha -g grupo OU $0 -U grupo:usuario:senha"
        exit 1
    fi

    if grep -q "^$groupname:" /etc/group; then
        echo "O grupo $groupname já existe."
    else
        # Crie o grupo
        groupadd "$groupname"
        # Crie um diretório visível e público apenas para o grupo visível
        mkdir /home/$groupname
        chmod 770 /home/$groupname
        chown :$groupname /home/$groupname
        echo "O grupo $groupname foi criado."
    fi

    if id "$username" &>/dev/null; then
        echo "O usuário $username já existe."
    else
        # Crie o usuário e defina a senha
        useradd "$username" -s /bin/bash -m -d "/home/$groupname/$username"
        echo "$username:$password" | chpasswd
        chown "$username:$username" "/home/$groupname/$username"
        chmod 700 "/home/$groupname/$username"
        echo "Usuário criado com sucesso."
    fi

    # Adicione o usuário ao grupo
    usermod -aG "$groupname" "$username"
}

# Verifique se um arquivo foi especificado com a opção -A
if [[ "$1" != "-u" && "$1" != "-p" && "$1" != "-g" && "$1" != "-U" ]]; then
    # Insere nome do arquivo
    arquivo="$1"
    # Verifica se o arquivo existe
    if [ ! -f "$arquivo" ]; then
        echo "O arquivo $arquivo não existe."
        exit 1
    fi
    # Loop para ler o arquivo linha a linha e chamar a função cria_usuario_grupo
    while IFS= read -r linha || [ -n "$linha" ]; do
        # Chame a função com a linha como argumento
        cria_usuario_grupo -U "$linha"
    done < "$arquivo"
else
    # Chame a função com os argumentos passados para o script
    cria_usuario_grupo "$@"
fi

