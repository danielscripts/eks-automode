# EKS Auto Mode - Terraform

Infraestrutura como código para provisionar um cluster Amazon EKS 1.32 com **Auto Mode** na região **us-east-2 (Ohio)** usando Terraform.

## 📋 Sobre o Projeto

Este projeto cria um cluster EKS com Auto Mode habilitado, que gerencia automaticamente a infraestrutura de compute (nodes) sem necessidade de configurar node groups manualmente.

### Recursos Criados

- ✅ Amazon EKS Cluster v1.32 com Auto Mode
- ✅ VPC com subnets públicas, privadas e intra
- ✅ NAT Gateway (single)
- ✅ Internet Gateway
- ✅ Security Groups
- ✅ IAM Roles e Policies
- ✅ EBS CSI StorageClass (default)
- ✅ EKS Pod Identity (substitui IRSA)

---


---

## 🔐 Pré-requisitos

### 1. Credenciais AWS

Este projeto utiliza o profile AWS `tf_lar`. Configure suas credenciais via env se desejar:


### 2. Permissões IAM Necessárias

O usuário/role AWS precisa de permissões para criar:
- EKS Clusters
- VPC, Subnets, Route Tables
- Security Groups
- IAM Roles e Policies
- EC2 (NAT Gateway, Internet Gateway)
- CloudWatch Logs

### 3. Verificar Versões

```bash
# Verificar Terraform
terraform --version

# Verificar AWS CLI
aws --version

# Verificar kubectl
kubectl version --client
```

---

## 🚀 Como Usar

### 1️⃣ Clone e Acesse o Diretório

```bash
cd eks-automode
```

### 2️⃣ Inicialize o Terraform

```bash
terraform init
```

Isso vai:
- Baixar os providers (AWS, Helm, kubectl)
- Baixar os módulos (EKS, VPC, KMS)

### 3️⃣ Valide a Configuração

```bash
terraform validate
```

### 4️⃣ Visualize o Plano de Execução

```bash
terraform plan
```

Revise os recursos que serão criados:
- VPC com subnets (públicas, privadas, intra)
- EKS cluster 1.32 com Auto Mode
- NAT Gateway
- Security Groups
- IAM Roles
- StorageClass EBS CSI

### 5️⃣ Aplique as Mudanças

```bash
terraform apply
```

Digite `yes` quando solicitado.

⏱️ **Tempo estimado:** 10-15 minutos

### 6️⃣ Configure o kubectl

Após o apply completar com sucesso:

```bash
aws eks update-kubeconfig --region us-east-2 --name eks-automode
```

### 7️⃣ Verifique o Cluster

```bash
# Ver nodes (Auto Mode cria automaticamente quando necessário)
kubectl get nodes

# Ver storage classes
kubectl get storageclass

# Ver todos os pods do sistema
kubectl get pods -A

# Informações do cluster
kubectl cluster-info
```

---

## 📁 Estrutura do Projeto

```
eks-automode/
├── access.tf          # Gestão de usuários IAM e access entries
├── eks.tf             # Configuração do cluster EKS
├── kubernetes.tf      # Recursos Kubernetes (StorageClass)
├── main.tf            # Locals e data sources
├── provider.tf        # Configuração de providers
├── variables.tf       # Variáveis do projeto
├── versions.tf        # Versões Terraform e providers
├── vpc.tf             # Configuração VPC
└── README.md          # Este arquivo
```

---

## ⚙️ Configuração

### Variáveis Principais

As variáveis podem ser customizadas em `variables.tf`:

| Variável | Descrição | Valor Padrão |
|----------|-----------|--------------|
| `region` | Região AWS | `us-east-2` (Ohio) |
| `eks_name` | Nome do cluster EKS | `eks-automode` |
| `eks_version` | Versão do Kubernetes | `1.32` |
| `cidr` | CIDR block da VPC | `10.0.0.0/16` |

### Access Entries

Para adicionar usuários ao cluster, edite o arquivo `access.tf`:

```hcl
locals {
  users = [
    "daniel.correa",
    "seu-usuario-iam"  # Adicione aqui
  ]
}
```

---

## 🗑️ Destruir Infraestrutura

Para remover todos os recursos criados:

```bash
terraform destroy
```

Digite `yes` quando solicitado.

⚠️ **Atenção:** Esta ação é irreversível e apagará todo o cluster e recursos relacionados.

---

## 🔗 Links Úteis

- [EKS Auto Mode - Terraform Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest/examples/eks-auto-mode)
- [AWS EKS Cluster Resource](https://registry.terraform.io/providers/hashicorp/aws/6.18.0/docs/resources/eks_cluster)
- [EKS Auto Mode Documentation](https://docs.aws.amazon.com/eks/latest/userguide/automode.html)
- [Terraform AWS EKS Module v21 Upgrade Guide](https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/UPGRADE-21.0.md)

