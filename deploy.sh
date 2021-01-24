#!/bin/bash

# includes
source "config.sh"
source "funcoes.sh"

# variáveis globair
ULTIMA_TAG=''

cd $DIR_APLICACAO

checa_ambiente

atualiza_master

verifica_diferenca_entre_master_e_ultima_tag

checkout_para_ultima_tag
