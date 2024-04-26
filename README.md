
# Projeto do Módulo *Orquestração*

## Treinamento Jornada Digital ADA-Caixa

### Descrição

Solução proposta para o projeto do módulo *Orquestração* do treinamento Jornada Digital Devops ADA-Caixa.  

A solução foi preparada para executar em cluster de Kubernetes e testada em ambiente Debian e WSL com openSUSE.

Os scripts executam em deployments próprios como a seguir:

- `preparar-ambiente`:
  - Cria os objetos JSON com os números das contas e uma lista de transações no Redis.
  - Cria a exchange, a fila e o biding no RabbitMQ
  - Cria o bucket no MinIO.
- `producer`: Gera transaçoes aleatórias e envia para o RabbitMQ.
- `consumer`: Consome a fila no RabbitMQ, grava o cache e gera o relatório de fraude, caso seja identificado.

Os demais deployments são os serviços do Minio, RabbitMQ e Redis.  

O critério para fraude foi a mudança de cidades em um intervalo menor do que duas horas.  
  
### Instruções

1. **Instalar o Docker e o Docker Compose**  

    - [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/ )
    - [https://docs.docker.com/compose/install/standalone/](https://docs.docker.com/compose/install/standalone/)  

2. **Instalar o git (a partir daqui os passos deverão ser realizados apenas em ambiente Linux ou WSL)**

    - [https://git-scm.com/book/en/v2/Getting-Started-Installing-Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

3. **Clonar o repositório para seu laboratório**

```bash
git clone https://github.com/rfrezende/projeto_orquestracao.git
cd projeto_orquestracao
```

4. **Preparar o Minikube (pode executar mesmo que já esteja instalado)**

```bash
./instalar_minikube.sh
```

5. **Subir o ambiente no Minikube**
```bash
./apply.sh
```  
O ambiente pode levar algum tempo para subir. Uma nova instalação demora um pouco mais do que 2 minutos.

Para ver manualmente os logs do consumer, poderá executar o seguinte comando:
```bash
minikube kubectl -- logs --follow $(minikube kubectl -- get pods | grep consumer | cut -d' ' -f 1) --namespace=projeto-orquestracao
```

6. **Remover o laboratório**

```bash
./delete.sh  
```

```bash
cd ..  
```

```bash
sudo rm -r projeto_orquestracao  
```

```bash
minikube delete
```
