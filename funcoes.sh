#!/bin/bash
#

checa_ambiente()
{
	if [ $AMBIENTE != 'HOMOLOGACAO' -a $AMBIENTE != 'PRODUCAO' ]; then
		echo "Este script NÃO pode ser executado no ambiente $AMBIENTE"
		exit
	fi

	ARQUIVOS_PENDENTES=`git diff --stat | wc -l`
	if [ $ARQUIVOS_PENDENTES != 0 ]; then
		echo "Execute o commit antes de fazer o deploy para homologação !"
		exit
	fi

	ARQUIVOS_PENDENTES=`git status | grep "git push" | wc -l`
	if [ $ARQUIVOS_PENDENTES != 0 ]; then
		echo "Execute o push antes de fazer o deploy para homologação !"
		exit
	fi
}

atualiza_master()
{
	git checkout master > /dev/null 2>&1
	git pull > /dev/null 2>&1
	git fetch > /dev/null 2>&1

	ULTIMA_TAG=`git describe --tags $(git rev-list --tags --max-count=1)`
}

verifica_diferenca_entre_master_e_ultima_tag()
{
	TEM_DIFERENCA=`git diff $ULTIMA_TAG --name-only | wc -l`

	if [ $TEM_DIFERENCA != 0 ] ; then 
		echo "existem $TEM_DIFERENCA arquivos diferentes entre a TAG $ULTIMA_TAG e o branch MASTER"
		_cria_nova_tag
	fi
}

checkout_para_ultima_tag()
{
	if [ $AMBIENTE != 'HOMOLOGACAO' -a $AMBIENTE != 'PRODUCAO' ]; then
		echo "a TAG só pode ser selecionada no ambiente de homologação e/ou produção."
		exit;
	fi

	if [ $TEM_DIFERENCA = 0 ]; then
		echo "Nenhuma TAG foi criada !"
		exit;
	fi

	ULTIMA_TAG=`git describe --tags $(git rev-list --tags --max-count=1)`

	git checkout $ULTIMA_TAG > /dev/null 2>&1
	
	echo "selecionando a última TAG $ULTIMA_TAG"
}

# -- funções privadas ---
_cria_nova_tag()
{
	TAG_ARRAY=(`echo $ULTIMA_TAG | tr '.' ' '`)
	TAG_ID="$((${TAG_ARRAY[2]} +1))"
	TAG_NOVA=${TAG_ARRAY[0]}"."${TAG_ARRAY[1]}"."$TAG_ID
	TAG_NOVA_ID=${TAG_NOVA:1}

	git tag -a $TAG_NOVA -m 'release $TAG_NOVA_ID' > /dev/null 2>&1
    git push --tags > /dev/null 2>&1

	echo "aqui eu criei a nova TAG $TAG_NOVA"
}
