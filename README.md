Desafio de Infraestrutura como Código (IaC) - VExpenses 🚀

Introdução 🌟

Olá! Meu nome é Rafael e sou um entusiasta de tecnologia, especialmente na área de desenvolvimento de software e infraestrutura. Recentemente, participei de um desafio online da VExpenses como parte do processo seletivo para uma vaga de estágio em DevOps. O objetivo deste desafio foi demonstrar meus conhecimentos em Infraestrutura como Código (IaC) utilizando Terraform, bem como minhas habilidades em segurança e automação de configuração de servidores.

O desafio consistiu em analisar um arquivo Terraform denominado main.tf, que define a criação de uma infraestrutura básica na AWS, incluindo VPC, Subnet, Grupo de Segurança, Key Pair e uma instância EC2. Além disso, fui solicitado a implementar melhorias de segurança, automatizar a instalação do servidor Nginx na instância EC2 e documentar detalhadamente as modificações realizadas.

Para esse projeto, utilizei as seguintes tecnologias:

    Docker 🐳: Utilizado para criar um ambiente isolado e gerenciar serviços, como o LocalStack, que simula os serviços da AWS localmente. O uso do Docker permite garantir que a aplicação seja executada de maneira consistente em diferentes ambientes.

    Git Bash 💻: Como um terminal que proporciona uma experiência robusta de linha de comando, o Git Bash me permitiu interagir com o Git e executar comandos de forma eficiente no Windows, facilitando o gerenciamento do meu repositório.

    Terraform 🌱: Essa ferramenta foi fundamental para definir a infraestrutura como código, permitindo a criação de recursos na AWS de maneira declarativa e reutilizável. Com o Terraform, pude configurar rapidamente a infraestrutura necessária.

    LocalStack 🛠️: Essencial para simular os serviços da AWS em um ambiente local, o LocalStack possibilitou testar e validar a infraestrutura sem custos adicionais, proporcionando um ambiente seguro para experimentação.

    WSL (Windows Subsystem for Linux) 🐧: Essa funcionalidade me permitiu utilizar um terminal Linux diretamente no Windows, facilitando a execução de comandos e scripts que são comuns em ambientes Unix, aumentando a flexibilidade durante o desenvolvimento.

Com essas tecnologias em mãos, consegui superar o desafio proposto, criando uma infraestrutura funcional e bem documentada, que pode ser facilmente replicada e expandida. Estou ansioso para compartilhar os detalhes desse projeto!


 🧐 Entendimento do Código Original

O código Terraform apresentado tem como objetivo criar uma infraestrutura básica na AWS, composta por uma VPC, uma subnet, um gateway de internet e uma instância EC2 rodando Debian 12. A seguir, estão os principais componentes e suas funcionalidades:
Provider AWS 🌍:
   O bloco provider "aws" especifica que estamos utilizando a AWS como provedor de nuvem e define a região us-east-1, onde todos os recursos serão provisionados.

   ![image](https://github.com/user-attachments/assets/b18234ab-b29f-4b79-a365-afae8c888bd3)

Variáveis 📋:
   As variáveis projeto e candidato permitem personalizar o nome dos recursos criados. O valor padrão de projeto é "VExpenses", enquanto candidato é "SeuNome". Essas variáveis são utilizadas nos nomes dos recursos, facilitando a identificação.
 
   ![image](https://github.com/user-attachments/assets/c311adeb-df29-4786-bdc4-74c9130f8160)

Criação de Chaves 🔑:
   O recurso tls_private_key gera uma chave privada RSA de 2048 bits, que será utilizada para acesso seguro à instância EC2.
        
   ![image](https://github.com/user-attachments/assets/17905435-da31-4907-a6f0-9d298d52829a)

VPC (Virtual Private Cloud) 🌐:
   O recurso aws_vpc cria uma Virtual Private Cloud (VPC) com o bloco CIDR 10.0.0.0/16. A configuração de DNS é ativada, permitindo resolução de nomes dentro da VPC. A VPC é marcada com tags para fácil identificação.

   ![image](https://github.com/user-attachments/assets/a8778cfe-d777-42e5-b580-07248bc32cd9)

Subnet 🗄️:
   O recurso aws_subnet define uma subnet dentro da VPC criada, utilizando o bloco CIDR 10.0.1.0/24. A subnet está localizada na zona de disponibilidade us-east-1a, garantindo alta disponibilidade. Ela também é marcada com tags.

   ![image](https://github.com/user-attachments/assets/e473b450-ead6-4cdf-a9d2-cdfefd85fba6)

        
Gateway de Internet 🌉:
   O recurso aws_internet_gateway cria um gateway de internet associado à VPC, permitindo comunicação entre a VPC e a internet pública. O gateway também é identificado por tags.

   ![image](https://github.com/user-attachments/assets/5775aa29-643d-406a-98b7-273f02199140)

Tabela de Roteamento 📑:
   O recurso aws_route_table define uma tabela de roteamento para a VPC. A tabela contém uma rota padrão (0.0.0.0/0) que direciona todo o tráfego não local para o gateway de internet. Tags são utilizadas para identificação.

   ![image](https://github.com/user-attachments/assets/a609c649-034a-44d8-bb59-14626fdfaa5d)


Associação de Tabela de Roteamento 🔗:
   O recurso aws_route_table_association associa a subnet à tabela de roteamento, permitindo que o tráfego da subnet seja corretamente roteado através do gateway de internet.

   ![image](https://github.com/user-attachments/assets/439254f4-3cee-4895-acc0-29f95ad5b235)

Grupo de Segurança 🔒:
   O recurso aws_security_group define um grupo de segurança que permite o acesso SSH (porta 22) de qualquer lugar e permite todo o tráfego de saída. Isso é crucial para a administração remota da instância EC2.

   ![image](https://github.com/user-attachments/assets/e54b3b7b-583c-4f26-860f-5448c361e0c6)
 
AMI (Amazon Machine Image) 🖼️:
   O bloco data "aws_ami" busca a AMI mais recente do Debian 12. Ele utiliza filtros para garantir que a AMI selecionada seja compatível e recente, melhorando a segurança e o desempenho da instância.

   ![image](https://github.com/user-attachments/assets/ae6fead9-bd11-44c5-aae5-5a8fa740b7b2)
 
Instância EC2 💻:
   O recurso aws_instance cria uma instância EC2 utilizando a AMI do Debian 12 e um tipo de instância t2.micro, que é elegível para o nível gratuito da AWS. A instância é associada à subnet e ao grupo de segurança. O bloco user_data contém um script de           inicialização que atualiza o sistema assim que a instância é iniciada. Tags são aplicadas para identificação.

   ![image](https://github.com/user-attachments/assets/0739dd35-6d53-4ce6-b00b-64d83459d2e6)

Saídas (Outputs) 📊:
   A seção de saídas fornece informações úteis após a execução do código. O output private_key exibe a chave privada gerada, que é sensível e não deve ser compartilhada. O output ec2_public_ip exibe o endereço IP público da instância EC2, permitindo             acesso remoto.

   ![image](https://github.com/user-attachments/assets/b4c4cbc1-d6b5-47f9-a3d1-1d2a260ef5a8)


Este código estabelece uma infraestrutura básica na AWS, permitindo acesso remoto seguro à instância EC2 e conectividade com a internet através da VPC e da subnet.
Críticas e Melhorias Propostas Resolvidas

Críticas e Melhorias Propostas 🛠️

1. Problemas com AMIs 🖥️

       Crítica: O código original não estava configurado para buscar a AMI mais recente de forma adequada, levando a erros na criação da instância EC2.
        
2. Inconsistências em Recursos ⚠️

       Crítica: Algumas associações de recursos, como entre a tabela de rotas e a subnet, estavam causando confusão no estado da infraestrutura.

3. Falta de Modularização 🗂️

       Crítica: O código original era um bloco único, dificultando a manutenção e a leitura.
   
5. Segurança no Grupo de Segurança 🔒

       Crítica: O grupo de segurança permitia acesso SSH de qualquer IP, representando um risco de segurança.

6. Estrutura de Tags 🏷️

       Crítica: As tags nos recursos não eram consistentes, dificultando a organização e a identificação dos mesmos na AWS.

7. Configuração do user_data 📜

       Crítica: O script de inicialização da instância EC2 não estava completo, com apenas atualizações básicas.


9. Problemas de Conectividade 🌐

       Crítica: A configuração inicial não permitia a associação da tabela de rotas corretamente, causando dificuldades na conectividade da instância.

10. Melhorias de Logs e Monitoramento 📈

        Crítica: A falta de monitoramento e logging tornava difícil identificar problemas na infraestrutura.

11. Documentação e Comentários 📝

        Crítica: O código original carecia de comentários e documentação, dificultando a compreensão do que cada parte fazia.


Sobre especificamente de segurança
🚫 Grupo de Segurança com Regra de Entrada Muito Permissiva

    Crítica: A regra de entrada do grupo de segurança permite SSH de um único IP específico, o que pode ser restritivo demais ou tornar-se obsoleto. Essa configuração pode expor a instância a riscos, caso o IP de origem precise ser alterado.
    Contramedida: Utilizar uma variável para o IP de origem e considerar o uso de um range de IPs mais amplo ou um security group separado para acesso SSH.

🔒 Falta de Criptografia em Repouso para a Instância EC2

    Crítica: O código original não menciona a criptografia para os volumes EBS da instância EC2. Isso deixa os dados em repouso vulneráveis a acessos não autorizados e a potenciais violações de segurança.
    Contramedida: Implementar a criptografia para os volumes EBS, garantindo que os dados sejam protegidos em repouso.

⚠️ Uso de AMI Potencialmente Desatualizada

    Crítica: A AMI foi definida como uma variável, mas não há garantia de que a AMI utilizada seja uma imagem atualizada e segura. Isso pode expor a infraestrutura a vulnerabilidades conhecidas.
    Contramedida: Implementar um processo para manter a AMI atualizada e considerar o uso do AWS Systems Manager Parameter Store para gerenciar o ID da AMI.

📉 Falta de Logging e Monitoramento

    Crítica: O código não configura logging ou monitoramento para a infraestrutura, o que dificulta a identificação de atividades suspeitas ou problemas operacionais.
    Contramedida: Implementar o AWS CloudTrail para logging de atividades e o Amazon CloudWatch para monitoramento.

🏷️ Falta de Tags de Segurança

    Crítica: As tags utilizadas são mínimas e não incluem informações relevantes para segurança e conformidade.
    Contramedida: Adicionar tags relevantes para segurança, como ambiente, proprietário e classificação de dados.

💾 Ausência de Backup Automático

    Crítica: Não há configuração de backup automático para a instância EC2, o que pode levar à perda de dados importantes em caso de falhas.
    Contramedida: Configurar o AWS Backup para realizar backups automáticos da instância EC2.

4. Alterações Realizadas ✨
1. Modificação na Busca da AMI 🖥️

   Alteração: Ajustei a configuração do recurso data "aws_ami" para utilizar filtros apropriados na busca pela AMI mais recente do Debian 12.
    Justificativa: Isso garantiu que a instância EC2 fosse criada a partir da imagem mais atualizada, evitando possíveis problemas de compatibilidade e segurança.

2. Correção de Associações de Recursos ⚙️

    Alteração: Revisei e corrigi as associações entre a tabela de rotas e a subnet.
    Justificativa: Essa alteração foi necessária para assegurar que a infraestrutura estivesse corretamente configurada, permitindo a conectividade da instância com a internet.

3. Modularização do Código 🗂️

    Alteração: O código foi dividido em módulos separados, com arquivos distintos para VPC, subnets, instâncias e outros recursos.
    Justificativa: A modularização melhora a legibilidade, facilita a manutenção e permite que mudanças sejam feitas em partes específicas do código sem impactar o restante.

4. Reforço da Segurança no Grupo de Segurança 🔒

    Alteração: O grupo de segurança foi modificado para restringir o acesso SSH a um intervalo de IPs específicos, em vez de permitir acesso irrestrito.
    Justificativa: Essa mudança aumentou a segurança da instância EC2, reduzindo a exposição a ataques externos e protegendo a infraestrutura.

5. Padronização de Tags 🏷️

    Alteração: A nomenclatura das tags em todos os recursos foi padronizada.
    Justificativa: A padronização ajuda na organização e na identificação fácil dos recursos na AWS, facilitando a gestão da infraestrutura.

6. Correção de Erros nas Tags de Anotações ❌

    Alteração: Corrigi um erro que fazia as tags nas anotações falharem, já que as anotações não suportam tags.
    Justificativa: Essa correção garante que o código funcione corretamente, evitando problemas na criação e identificação dos recursos.

7. Aprimoramento do user_data 📜

    Alteração: O script de inicialização (user_data) foi ampliado para incluir a instalação do Nginx:
    Justificativa: Essa melhoria garante que o Nginx seja instalado e iniciado automaticamente após o boot, preparando a instância para servir aplicações web. No entanto, não posso rodar o Nginx no LocalStack, pois ele não oferece suporte a serviços de           servidor como o Nginx.
![image](https://github.com/user-attachments/assets/c88b6950-95dd-445a-b338-7e3cd00b0c68)

8. Adaptação do Código para LocalStack 🛠️

    Alteração: Ajustei as configurações do código para serem compatíveis com o LocalStack, incluindo o uso de recursos simulados.
    Justificativa: Isso permite que a infraestrutura seja testada localmente, facilitando o desenvolvimento sem depender da AWS real.

9. Configuração de Saídas Sensíveis 📊

    Alteração: A saída da chave privada foi marcada como sensitive para evitar que fosse exibida em logs.
    Justificativa: Isso melhorou a segurança, evitando a exposição acidental de informações críticas que poderiam ser utilizadas em ataques.

10. Correção de Problemas de Conectividade 🌐

    Alteração: Realizei ajustes nas associações da tabela de rotas e na configuração de Internet Gateway.
    Justificativa: Garantir que a instância EC2 tenha acesso à internet é crucial para a sua funcionalidade, especialmente se a aplicação precisa se comunicar externamente.

11. Implementação de Monitoramento e Logs 📈

    Alteração: Adicionei configurações para integrar o AWS CloudWatch, permitindo monitoramento e logging.
    Justificativa: O monitoramento eficaz ajuda a identificar e solucionar problemas rapidamente, aumentando a robustez da infraestrutura.

12. Documentação e Comentários Adicionais 📝

    Alteração: Adicionei comentários explicativos em várias partes do código.
    Justificativa: Melhorar a documentação facilita a compreensão do código para outros desenvolvedores e para futuras manutenções, promovendo boas práticas de desenvolvimento.



Descrição do Novo Código 📜

Provider AWS 🌐
    Configuração do Provider: O provider AWS é configurado para interagir com o LocalStack, permitindo simulações locais de serviços da AWS.
    EndPoints: Endpoints são definidos para serviços como EC2, IAM, Route53, CloudFormation e STS, todos apontando para http://localhost:4566, garantindo que todas as requisições sejam redirecionadas para o LocalStack durante os testes.

Chave Privada e Par de Chaves 🔑
    Geração de Chave Privada: Um recurso tls_private_key é utilizado para criar uma chave privada RSA com 2048 bits, que será usada para autenticação.
    Criação de Par de Chaves: Um recurso aws_key_pair é criado, usando a chave pública gerada anteriormente, nomeando-a conforme as variáveis do projeto e do candidato, permitindo acesso seguro à instância EC2.

Módulo VPC 🏗️
    Criação da VPC: Um recurso aws_vpc é definido com um bloco CIDR personalizado e suporte a DNS habilitado, permitindo que a VPC possa se comunicar com a internet.
    Subnet: Uma subnet é criada dentro da VPC, especificando a zona de disponibilidade e o bloco CIDR para alocação de IPs.
    Gateway de Internet: Um aws_internet_gateway é associado à VPC para permitir o tráfego externo.
    Tabela de Rotas: Uma tabela de rotas é configurada para direcionar o tráfego da subnet para o gateway de internet, garantindo que instâncias dentro da VPC possam acessar a internet.

Módulo EC2 💻
    Instância EC2: A instância EC2 é criada utilizando uma AMI especificada, tipo de instância e chave de acesso.
    User Data: Um script de inicialização é incluído na configuração da instância, que executa comandos para atualizar o sistema e instalar o Nginx. No entanto, como o ambiente está rodando no LocalStack, a execução do Nginx não será possível.
    Tags: A instância recebe tags personalizadas, facilitando a identificação e o gerenciamento dentro da AWS.

Segurança 🔒
    Grupo de Segurança: Um recurso aws_security_group é configurado para permitir conexões SSH somente de um IP específico, aumentando a segurança da instância.
    Regras de Ingress: Permissão para conexões na porta 22 (SSH) é restringida ao IP especificado, enquanto regras de saída permitem todo o tráfego para garantir a flexibilidade nas comunicações.

Associação da Subnet à Tabela de Rotas 🌍
    Um recurso aws_route_table_association é criado para associar a subnet à tabela de rotas, garantindo que o tráfego possa ser roteado corretamente através do gateway de internet.

Saídas 📤
    Chave Privada: O valor da chave privada gerada é exposto como uma saída sensível, permitindo o acesso à instância EC2.
    Endereço IP Público: O IP público da instância é disponibilizado como uma saída, facilitando o acesso e a configuração.

Variáveis 📦
    Definição de Variáveis: Várias variáveis são definidas para permitir personalização do código, incluindo o nome do projeto, o CIDR da VPC e da subnet, a AMI a ser usada e o tipo de instância. Isso torna o código flexível e reutilizável em diferentes    cenários.
Instruções de Uso: Como Clonar o Repositório e Executar o Código 🚀
1. Pré-requisitos 📋

  Git: Certifique-se de que o Git está instalado em seu sistema. Você pode baixá-lo aqui.
  Git Bash: Para uma melhor experiência de terminal no Windows, instale o Git Bash, que pode ser encontrado no mesmo link do Git.
  Terraform: Instale o Terraform em sua máquina. Acesse a página oficial do Terraform para obter as instruções de instalação.
  Docker: Instale o Docker para criar e gerenciar containers. Você pode seguir as instruções de instalação disponíveis neste link.
  LocalStack: Instale o LocalStack para simular serviços da AWS localmente. Siga as instruções de instalação disponíveis neste link.

2. Clonar o Repositório 📥

Abra o Git Bash e execute o seguinte comando para clonar o repositório:

    bash

    git clone https://github.com/seu_usuario/nome_do_repositorio.git

Substitua seu_usuario e nome_do_repositorio pelo seu nome de usuário do GitHub e o nome do repositório, respectivamente.
3. Navegar até o Diretório do Projeto 📂

Após clonar o repositório, navegue até o diretório do projeto:

    bash

    cd nome_do_repositorio

4. Configurar e Iniciar o LocalStack 🛠️

  Certifique-se de que o Docker está em execução. Você pode iniciar o Docker Desktop.
  Inicie o LocalStack com o seguinte comando:

      bash

      localstack start

  Verifique se o LocalStack está rodando corretamente, observando os logs no terminal.

5. Inicializar o Terraform 🌱

Antes de aplicar a configuração do Terraform, inicialize o ambiente Terraform:

    bash

    terraform init

6. Modificar Variáveis (Opcional) 📝

Se necessário, edite o arquivo variables.tf para alterar as variáveis padrão, como o nome do projeto ou a AMI desejada.
7. Aplicar a Configuração do Terraform 🚀

Após inicializar, aplique a configuração do Terraform para criar a infraestrutura:

    bash

    terraform apply

  Revise o plano de execução apresentado pelo Terraform e, se tudo estiver correto, confirme a execução digitando yes.

8. Acessar a Instância EC2 🖥️

  Após a execução bem-sucedida, você verá as saídas que incluem a chave privada e o IP público da instância EC2.
  Para acessar a instância via SSH, use o comando:

      bash
    
      ssh -i caminho/para/chave_privada.pem ec2-user@ip_publico

      Substitua caminho/para/chave_privada.pem pelo caminho onde a chave privada foi salva e ip_publico pelo endereço IP público fornecido nas saídas do Terraform.

9. Destruir a Infraestrutura (Opcional) 🏗️

Se você não precisar mais da infraestrutura criada, você pode destruí-la usando o seguinte comando:

    bash

    terraform destroy

  Novamente, confirme digitando yes quando solicitado.

Essas instruções fornecem um guia passo a passo para clonar, configurar e executar o código do projeto Terraform, incluindo a configuração do Docker e o uso do Git Bash. Se precisar de mais informações ou esclarecimentos, estou aqui para ajudar!    


Observações sobre Testes e Ambiente

Devido à minha configuração atual, utilizei o LocalStack para simular os serviços da AWS localmente. Isso me permitiu desenvolver e configurar a infraestrutura definida no código Terraform sem acesso direto à AWS.

Limitações de Teste:
Embora eu tenha implementado o código para criar uma instância EC2 e instalar o Nginx, não pude testar diretamente essas funcionalidades em um ambiente real da AWS. Portanto, as instruções para a execução e verificação da instalação foram baseadas nas melhores práticas e no comportamento esperado do código em um cenário real.
Instruções para Verificação

    Executar o Código: Após configurar o LocalStack e executar o arquivo main.tf, você poderá iniciar os serviços localmente.
    Verificação da Instância EC2: Utilize o comando apropriado do LocalStack para listar as instâncias EC2 e confirmar se a instância foi criada com sucesso.
    Verificação do Nginx: Após a criação da instância, você pode verificar se o Nginx está em execução acessando a URL local configurada.

Sinta-se à vontade para entrar em contato caso tenha perguntas ou precise de mais informações sobre a implementação.

Instruções para Instalação em Ambiente Real da AWS

Se este código fosse executado em um ambiente real da AWS, o processo de instalação da infraestrutura, incluindo a criação de uma instância EC2 e a instalação do Nginx, seria realizado da seguinte forma:
Passo 1: Configuração da AWS CLI

    Instalação da AWS CLI: Certifique-se de que a AWS Command Line Interface (CLI) está instalada no seu sistema. Você pode seguir esta documentação oficial para a instalação.

    Configuração da AWS CLI: Execute o seguinte comando e insira suas credenciais da AWS (Access Key e Secret Key):

    bash

    aws configure

Passo 2: Criação da Instância EC2

    Executar o Código Terraform: Após garantir que o Terraform está instalado e configurado, execute os seguintes comandos para inicializar e aplicar a configuração:

    bash

    terraform init
    terraform apply

    Isso irá provisionar a infraestrutura conforme especificado no arquivo main.tf.

Passo 3: Instalação do Nginx

    Acessar a Instância EC2: Após a criação da instância EC2, você pode acessá-la via SSH. Primeiro, obtenha o endereço IP público da instância com o comando:

    bash

aws ec2 describe-instances --query "Reservations[].Instances[].PublicIpAddress" --output text

Em seguida, acesse a instância usando:

bash

ssh -i "seu-arquivo-chave.pem" ec2-user@<IP_PUBLICO>

Certifique-se de substituir <IP_PUBLICO> pelo endereço IP obtido.

Instalar o Nginx: Uma vez conectado à instância EC2, execute os seguintes comandos para instalar e iniciar o Nginx:

bash

    sudo yum update -y  # Para distribuições baseadas em Amazon Linux
    sudo amazon-linux-extras install nginx1 -y
    sudo systemctl start nginx
    sudo systemctl enable nginx

    Verificação do Nginx: Abra um navegador e acesse o endereço IP público da sua instância EC2. Você deve ver a página padrão do Nginx, indicando que a instalação foi bem-sucedida.

Considerações Finais

    Segurança: Verifique se as regras do grupo de segurança da instância EC2 permitem o tráfego HTTP (porta 80) para que o Nginx possa ser acessado publicamente.

    Limpeza: Para evitar custos, lembre-se de destruir a infraestrutura criada com o comando:

    bash

terraform destroy



Observação sobre o Uso do LocalStack

Devido ao uso do LocalStack como ambiente de teste, algumas funcionalidades e comportamentos podem diferir do ambiente AWS real. Estou ciente de que a implementação de melhorias de segurança é crucial e, embora tenha identificado algumas vulnerabilidades, não consegui aplicar todas as soluções sugeridas neste prazo. Comprometo-me a continuar aprendendo e a melhorar minhas habilidades nesse aspecto no futuro.




