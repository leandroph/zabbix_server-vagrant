# zabbix_server-vagrant
Laboratório de criação de uma máquina virtual com vagrant, onde é realizado a instalação e configuração do Zabbix Server

Dependências
-------------

Para a criação do laboratório é necessário ter pré instalado os seguintes softwares:

* [Git][1]
* [VirtualBox][2]
* [Vagrant][3]

> Para as máquinas com Windows, é aconselhado que as instalações, provisionamento e execução de comandos sejam feitos pelo  **[Cygwin][5]**. Caso você opte por outro cmd ou gerenciador git, como o **[gitforwindows][10]**, antes de iniciar o provisionamento, execute o comando `git config --global core.autocrlf false` para evitar quebras de linhas.

> Para as máquinas com Windows, é necessário que o [Hyper-V][9] esteja `desabilitado`.

Laboratório
-----------

O Laboratório será criado utilizando o [Vagrant][6]. Ferramenta para criar e gerenciar ambientes virtualizados (baseado em Inúmeros providers) com foco em automação.

Nesse laboratório, que está centralizado no arquivo [Vagrantfile][7], sera criada 1 maquina com a seguinte característica:

Nome       | vCPUs | Memoria RAM | IP            | S.O.¹           
---------- |:-----:|:-----------:|:-------------:|:---------------:
ZabbixServer     | 1     | 1024MB | 192.168.99.100 | ubuntu/focal64


>  Esse Sistema operacionai está sendo utilizado no formato de Boxes, é a forma como o vagrant chama as imagens do sistema operacional utilizado.
>  A memória inicial de cada VM está definida com 1024MB (1GB). Este valor pode ser aumentado, caso necessário através do arquivo `Vagrantfile`.

Criação do Laboratório
----------------------

Para criar o laboratório é necessário fazer o `git clone` desse repositório e, dentro da pasta baixada realizar a execução do `vagrant up`, conforme abaixo:

```bash
git clone https://github.com/leandroph/zabbix_server-vagrant.git
cd docker-vagrant
vagrant up
```
Utilização
----------

Todos os comandos devem ser utilizados dentro do diretório clonado.

Para listar as máquinas:

```bash
vagrant status
```

Para entrar em uma máquina:

```bash
vagrant ssh <machine>
```

Para iniciar todas as máquinas:

```bash
vagrant up
```

Para salvar o estado de todas as máquinas:

```bash
vagrant suspend
```

Retomar as máquinas suspensas:

```bash
vagrant resume
```

Para desligar todas as máquinas:

```bash
vagrant halt
```

Dicas
-----

Opcionalmente, para a agilidade no processo de religar as VMs, você pode apenas efetuar o `vagrant suspend/resume` da VM após terminar sua utilização em determinado período, tendo em vista que o comando `vagrant up` realiza algumas verificações que podem demorar.

> Em caso de erro na criação das máquinas sempre valide se sua conexão está boa, os logs de erros na tela e, se necessário, o arquivo **/var/log/vagrant_provision.log** dentro da máquina que apresentou a falha.

Por fim, abaixo há alguns comandos básicos do vagrant para a gerencia das máquinas virtuais.

Comandos                | Descrição
:----------------------:| ---------------------------------------
`vagrant init`          | Gerar o VagrantFile
`vagrant box add <box>` | Baixar a  imagem do sistema
`vagrant box status`    | Verificar o status dos boxes criados
`vagrant up`            | Criar/Ligar as VMs baseado no VagrantFile
`vagrant provision`     | Provisionar mudanças logicas nas VMs
`vagrant status`        | Verificar se VM estão ativas ou não.
`vagrant ssh <vm>`      | Acessar a VM
`vagrant ssh <vm> -c <comando>` | Executa comando via ssh
`vagrant reload <vm>`   | Reiniciar a VM carregando uma nova configuração aplicada no Vagrantfile
`vagrant halt`          | Desligar as VMs

> Para maiores informações acesse a [Documentação do Vagrant][8]


[1]: https://git-scm.com/downloads
[2]: https://www.virtualbox.org/wiki/Downloads
[3]: https://www.vagrantup.com/downloads
[4]: https://www.vagrantup.com/downloads
[5]: https://cygwin.com/install.html
[6]: https://www.vagrantup.com/
[7]: ./Vagrantfile
[8]: https://www.vagrantup.com/docs
[9]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
[10]: https://gitforwindows.org/
