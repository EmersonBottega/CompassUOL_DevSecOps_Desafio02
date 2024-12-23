# CompassUOL_DevSecOps_Desafio02
Desafio 02 - Feito no programa de bolsas DevSecOps da Compass.uol.

# Tecnologias utilizadas:
- Docker
- AWS
- Linux

## Tarefas:
 - Script de automação ✅
 - Subir instância EC2 ✅
 - Subir RDS MySql ✅
 - Wordpress funcionando ✅
 - Utilizar Elastic File System ✅
 - Utilizar Load Balancer ✅
 - Utilizar Auto Scaling ✅ 

# Arquitetura do Projeto:
![Arquitetura](https://github.com/user-attachments/assets/c5ee14ea-2c7b-4a15-ba23-094d95bdb3d0)

# Visão Geral

## Este repositório contém os arquivos e instruções necessários para realizar o deploy de uma aplicação WordPress utilizando:
 - Docker ou Containerd no host EC2.
 - Banco de dados MySQL gerenciado pelo serviço AWS RDS.
 - Sistema de arquivos EFS AWS para armazenar os arquivos estáticos do WordPress.
 - Load Balancer Classic da AWS para gerenciar o tráfego.
 - Auto Scaling para adicionar ou remover automaticamente a capacidade de grupos de recursos em tempo real para acompanhar a demanda.
   
A aplicação WordPress será configurada para rodar nas portas 80 ou 8080 e não utilizará IP público para saída direta.

## Requisitos:
 - Conta AWS com permissões suficientes para:
1. Gerenciar instâncias EC2.
2. Configurar Load Balancers.
3. Criar e configurar um banco de dados RDS MySQL.
4. Criar e configurar o Elastic File System (EFS).

# Passo a Passo

## 1. Criando VPC
1. Pesquisar por VPC na AWS e vá em > suas VPC's > Criar VPC. Ao criar selecione > VPC e muito mais e em seguida > Criar VPC.

![CriandoVPC](https://github.com/user-attachments/assets/6b046f25-b2af-4731-9e88-1dfb02911b8f)

## 2. Configuração das Instâncias EC2

### ⚠ Atenção ⚠
- Olhe o passo 6 (para criar um template de EC2 onde o Auto Scaling irá gerenciar as instâncias EC2);
- Com o passo 6, não há a necessidade de criar uma EC2 manualmente (apenas para aprendizado/teste);
- Você também pode criar a EC2 de acordo com o passo 2 e depois atribui-lo ao Auto Scaling.

### Criando EC2
Faça um script do tipo shell "user_data.sh" (utilize o arquivo colocado neste repositório como base).

 - O arquivo user_data.sh contém os comandos necessários para:
1. Instalar e configurar o Docker ou Containerd.
2. Instalar e configurar o Elastic File System.
3. Configurar o MySql.
4. Configurar o ambiente para o deploy da aplicação WordPress.
5. Adicionar um endpoint no wordpress para usar o Classic Load Balancer.

 - Crie uma instância EC2 na AWS com:
1. Sistema operacional: Amazon Linux 2 ou Oracle Linux.

![SO-EC2](https://github.com/user-attachments/assets/83e4d4b4-e4bb-4df4-bd76-6153506b48df)

2. Vá em Security Groups e crie um grupo de segurança da EC2.

![Entrada_EC2](https://github.com/user-attachments/assets/37864be9-a18e-41ed-899f-ef93d3dafbf2)

![Saida_EC2](https://github.com/user-attachments/assets/d9b450a9-fabc-4b84-9ca4-b66df7e50c14)

3. Copie o conteúdo do arquivo user_data.sh para o campo Detalhes avançados > Dados do Usuário na tela de configuração da instância.

![DadosDoUsuario](https://github.com/user-attachments/assets/fb72fc09-89cb-4aae-b9c1-8b89c8a841ec)

## 3. Configuração do Banco de Dados RDS MySQL
Acesse o console AWS, pesquisar por > RDS > Criar banco de dados > MySQL.

 - Configure:
1. VPC da mesma região que sua instância EC2.
2. Modelos: Nível Gratuito
3. Crie um security group do RDS apontando para o security group criado para a EC2.

![Entrada_RDS](https://github.com/user-attachments/assets/b7ae36a4-81e5-4227-969f-23585b3bb234)

4. Dê um nome para criar um banco automaticamente e funcionar de acordo com o script user_data.sh deste repositório.

![nomeRDS](https://github.com/user-attachments/assets/4c4a888e-4e81-49c9-bb1d-a40fadefe036)

5. Anote as credenciais de acesso (endpoint, usuário, senha) e coloque em seu user_data.

## 4. Configuração do AWS EFS
No console AWS, Pesquise por EFS > Criar sistema de arquivos > Personalizar.

 - Configure:
1. Após dar um nome, selecione Regional e configure assim:

![configEFS](https://github.com/user-attachments/assets/4f86afb7-9250-44a7-9894-4df172d69f54)

2. Crie um security group para o EFS:

![Entrada_EFS](https://github.com/user-attachments/assets/1e981cfd-7190-4f50-b19e-1ca8b0a65a1c)

3. Selecione a mesma VPC da EC2 e continue até criar.

## 5. Configuração do Load Balancer
Pesquise por Load Balancer (EC2 feature) no console AWS > Criar Load Balancer.

 - Configure:
1. Classic Load Balancer - _geração anterior_.
2. Voltado para a Internet.
3. Mesma VPC da EC2.
4. Mesmo security group da EC2.
5. Caminho de ping:

![configCLB](https://github.com/user-attachments/assets/ec5afeb5-29b6-4b2a-93fa-7e88ae2dec46)

## 6. Configurando Auto Scaling
Pesquise por Auto Scaling groups no console AWS > Criar grupo do Auto Scaling.

- Configure:
### Etapa 1:
1. Clique em criar um modelo de execução (template) e ajuste de acordo com o passo 2.
2. Selecione a template criada e vá em > Próximo.

### Etapa 2:
1. Escolha a VPC criada no passo 1.
2. Coloque as sub-redes privadas (east-1a e east-2b).

### Etapa 3:


### Etapa 4:


### Etapa 5:


### Etapa 6:


### Etapa 7:


## Demonstração
Confirme que o WordPress está acessível na porta configurada (80 ou 8080).

 - Em uma aba do navegador coloque o DNS que o Classic Load Balancer gerou.
 - Apresente a tela de login para validação do funcionamento.

## Parabéns! :tada:

Você Conseguiu. :partying_face:
