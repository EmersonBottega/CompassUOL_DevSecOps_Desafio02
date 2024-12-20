# CompassUOL_DevSecOps_Desafio02
Desafio 02 - Feito no programa de bolsas DevSecOps da Compass.uol.

# Tecnologias utilizadas:
- Docker
- AWS

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

## 1. Configuração das Instâncias EC2
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

## 2. Configuração do Banco de Dados RDS MySQL
Acesse o console AWS e crie uma instância RDS MySQL.

 - Configure:
1. VPC da mesma região que sua instância EC2.
2. Crie um security group permitindo acesso somente da instância EC2.
3. Anote as credenciais de acesso (endpoint, usuário, senha).

## 3. Configuração do AWS EFS
No console AWS, crie um sistema de arquivos EFS.

 - Configure pontos de montagem na mesma região/VPC da sua EC2.
1. Monte o EFS na instância EC2 utilizando:
```bash sudo mount -t nfs4 -o nfsvers=4.1 <EFS_ENDPOINT>:/ /mnt/efs ```

 - Configure permissões para o usuário que executa o WordPress:
1. ```bash sudo chown -R ec2-user:ec2-user /mnt/efs ```

## 4. Configuração do Load Balancer
Crie um Load Balancer Classic no console AWS.

 - Configure:
1. Backend apontando para sua instância EC2.
2. Políticas para redirecionar tráfego HTTP/HTTPS.
3. Teste o acesso via Load Balancer ao WordPress.

## Demonstração
Confirme que o WordPress está acessível na porta configurada (80 ou 8080).

 - Utilize o IP da EC2 e a porta 8080.
 - Em uma aba do navegador coloque <IP:8080>
 - Apresente a tela de login para validação do funcionamento.

## Parabéns! :tada:

Você Conseguiu. :partying_face:
