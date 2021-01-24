#!/bin/bash

# descobrindo o diretório completo
DIR_SCRIPT=${PWD}"/"$(dirname $0)

# variáveis globais
ULTIMA_TAG=''

# includes
source $DIR_SCRIPT"/"config.sh
source $DIR_SCRIPT"/"funcoes.sh

cd $DIR_APLICACAO

checa_ambiente

atualiza_master

verifica_diferenca_entre_master_e_ultima_tag

checkout_para_ultima_tag
