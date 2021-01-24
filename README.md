## Script para deploy Automático

### Considerações
Este script irá manter, de maneira automática, as versões de sua aplicação, algo como ...
```
v1.0.1
v1.0.2
v1.0.23 ...
```

O Script irá usar o `GIT` para criar as novas `TAGs` assim que o código é alterado.

### Requisitos
* Ambiente de Homologação ou Produção.

* Necessário que o código esteja sendo versionado pelo `GIT`. 
Você pode usar o comando como:
`git clone usuario@servidorGit app`

* variável de ambiente com o nome `AMBIENTE`, esta variável informa se o servidor é de `DESENVOLVIMENTO`, `HOMOLOGACAO` ou `PRODUCAO`. a variável deve conter umas das três opções, recomenda-se criá-las no arquivo `/etc/bashrc.bashrc` do seu servidor `Linux`.

* Criar o `config.sh` informando o diretório de sua aplicação.

* O arquivo a ser executado deve ser `deploy.sh`, certifique-se que possui permissão de execução.

### Configurações
* crie o arquivo config.sh e inclua o diretório de sua aplicação.

* coloque no `crontabe` do seu servidor, homologação e/ou produção, a chamada ao arquivo `deploy.sh`.

### Observações
* O Script só roda em ambientes de homologação ou produção.
* O Script só roda no branch diferente de `master`.
