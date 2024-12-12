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
 - Utilizar Elastic File System ❌
 - Utilizar Load Balancer ❌

# Visão Geral

## Este repositório contém os arquivos e instruções necessários para realizar o deploy de uma aplicação WordPress utilizando:
 - Docker ou Containerd no host EC2.
 - Banco de dados MySQL gerenciado pelo serviço AWS RDS.
 - Sistema de arquivos EFS AWS para armazenar os arquivos estáticos do WordPress.
 - Load Balancer Classic da AWS para gerenciar o tráfego.
   
A aplicação WordPress será configurada para rodar nas portas 80 ou 8080 e não utilizará IP público para saída direta.

## Requisitos:
 - Conta AWS com permissões suficientes para:
1. Gerenciar instâncias EC2.
2. Configurar Load Balancers.
3. Criar e configurar um banco de dados RDS MySQL.
4. Criar e configurar o Elastic File System (EFS).

# Passo a Passo

## 1. Configuração do Host EC2
Faça um script do tipo shell "user_data.sh" (utilize o arquivo colocado neste repositório).

 - O arquivo user_data.sh contém os comandos necessários para:
1. Instalar e configurar o Docker ou Containerd.
2. Instalar e configurar o MySql.
3. Configurar o ambiente para o deploy da aplicação WordPress.

 - Crie uma instância EC2 na AWS com:
1. Sistema operacional: Amazon Linux 2 ou Oracle Linux.
2. Grupo de segurança configurado para permitir tráfego HTTP/HTTPS nas portas 80 e/ou 8080.
3. Copie o conteúdo do arquivo user_data.sh para o campo Advanced > User Data na tela de configuração da instância.

 - Inicie a instância e verifique se o script foi executado corretamente:
1. ```bash sudo docker --version ```

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
