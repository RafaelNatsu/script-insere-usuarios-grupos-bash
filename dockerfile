FROM ubuntu
WORKDIR /app
COPY . .
RUN chmod +x tools/criarUsuarioGrupo.sh
RUN chmod +x tools/inicial.sh