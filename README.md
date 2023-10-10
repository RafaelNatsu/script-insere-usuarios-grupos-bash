# script-insere-usuarios-grupos-bash
  script em bash para inserir usuarios e grupos de um arquivo de controle.

Para solucionar o desafio "Infraestrutura como Código: Script de Criação de Estrutura de Usuários, Diretórios e Permissões" foi criado os scripts inicial e criarUsuarioGrupo. Os dois scripts fazem basicamente a mesma coisa porém tem motivos para isso.
De inicio pensei em separar funções, por exemplo criarUsuarioGrupo o qual como o proprio nome diz, cria o usuario e insere ele em um grupo. Decidi englobar o criar o usuario + criar grupo + inserir no grupo, isso pois foi uma forma de otimizar e encapsular funções iniciais/basicas de um sistema linux.
O script "inicial" seria para adicionar funções em sequencia, automatizando as modificações necessárias pro sistema.

Um outro ponto que quero ressaltar é que, pesquisando idéias para solucionar o desafio, vi alguns repositórios de outros alunos, e algum deles utilizavam arquivos csv para facilitar a inserção de usuarios. Vendo isso optei por uma criação mais manual do arquivo, optei pela simplicidade e facilidade de criação.

# Exemplo de arquivo de usuarios
A seguir é um exemplo do modelo de arquivo para inserir os usuarios.
```text
nome_grupoExemplo:nome_pessoa:senha_do_usuario
nome_grupo:nome_pessoaExemplo:senha_do_usuario
nome_grupoExemplo:nome_pessoaDiferente:senha_do_usuarioExemplo

```
São 3 informações e em sequencia (separados por ':' ): nome do grupo, nome usuario, senha do usuario

# Exemplo de comando
criarUsuarioGrupo.sh
```bash
sudo chmod +x tools/criarUsuarioGrupo.sh
tools/criarUsuarioGrupo.sh -u nome -p senha -g grupo
# ou
tools/criarUsuarioGrupo.sh -U grupo:nome:senha
# ou inserindo os parametros por um arquivo de texto
tools/criarUsuarioGrupo.sh nomeArquivoDeUsuarios.txt

```

todo: Implementar outras logicas para iniciar requerimentos das regras de negócio.
É um arquivo de exemplo MVP, ele cria uma pasta publica e cria os usuarios do documento.
Inicial.sh
```bash
sudo chmod +x tools/inicial.sh
tools/inicial.sh exemploDeArquivoDeUsuarios.txt
```