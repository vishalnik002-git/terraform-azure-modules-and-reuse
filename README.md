# 📦 Modular Infrastructure as Code: Parent & Child Modules in Terraform

![Terraform Version](https://img.shields.io/badge/Terraform-1.5%2B-blue.svg?logo=terraform)
![Azure Provider](https://img.shields.io/badge/AzureRM-3.100%2B-0078D4.svg?logo=microsoft-azure)
![IaC](https://img.shields.io/badge/IaC-Reusable%20Modules-623CE4.svg)
![Validation](https://img.shields.io/badge/Validation-Pass-success.svg)

> **Repository 07 of 08 in the Terraform + Microsoft Azure Professional Learning Series**

---

## 📌 Navigation
| ⏪ Previous Repository | 📚 Current Repository | ⏩ Next Repository |
| :--- | :---: | :--- |
| [← 06. terraform-azure-state-management](https://github.com/vishalnik002-git/terraform-azure-state-management) | **07. terraform-azure-modules-and-reuse** | [08. terraform-azure-production-best-practices →](https://github.com/vishalnik002-git/terraform-azure-production-best-practices) |

---

## 📖 Project Overview

As cloud infrastructure expands, copying resource blocks across projects leads to code divergence and maintenance nightmares.
**Terraform Modules** solve this by enabling software engineering principles such as **DRY (Don't Repeat Yourself)**, encapsulation, and composability.

This repository demonstrates:
- How to author clean, self-contained **Child Modules** (`modules/resource-group` and `modules/storage-account`).
- How the **Root / Parent Module** calls child modules, injects parameters via input variables, and consumes return values via outputs.
- How to build a fully self-contained repository with local relative module sources.

> ℹ️ **Learning Note**: This repository contains learning configurations and documentation. Automated validation checks verify HCL syntax without provisioning live Azure cloud resources.

---

## 🎯 Learning Objectives

By exploring this repository, you will understand:
1. The architectural role of **Root Modules** vs **Child Modules**.
2. How to design clean module contracts with typed `variables.tf` and exported `outputs.tf`.
3. How to reference local module sources (`source = "./modules/resource-group"`).
4. How module outputs establish implicit dependencies between disparate infrastructure modules.
5. How multiple module invocations allow provisioning multiple environments (Dev, QA, Staging) from identical blueprints.

---

## 🏗️ Parent-Child Module Architecture

```
+-------------------------------------------------------------------------+
|                      Parent / Root Module (main.tf)                     |
+-------------------------------------------------------------------------+
            |                                           |
    Inputs  |  Outputs                           Inputs |  Outputs
            v  ^                                        v  ^
  +-------------------------+                 +-------------------------+
  | Child Module 1          |                 | Child Module 2          |
  | modules/resource-group/ |                 | modules/storage-account/|
  | - main.tf               | --- Output ---> | - main.tf               |
  | - variables.tf          |   (RG Name)     | - variables.tf          |
  | - outputs.tf            |                 | - outputs.tf            |
  +-------------------------+                 +-------------------------+
```

---

## 📂 Repository Structure

```
terraform-azure-modules-and-reuse/
├── .github/
│   └── workflows/
│       └── validate.yml          # GitHub Actions CI validation pipeline
├── modules/
│   ├── resource-group/           # Reusable Resource Group child module
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── storage-account/          # Reusable Storage Account child module
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── versions.tf
├── examples/
│   └── multi-environment-calling/# Multiple module calls from a single root
│       ├── main.tf
│       ├── outputs.tf
│       └── versions.tf
├── .gitignore                    # Standard exclusion rules
├── main.tf                       # Root module composing the child modules
├── outputs.tf                    # Root module outputs
├── providers.tf                  # AzureRM provider configuration
├── terraform.tfvars.example      # Example input parameters
├── variables.tf                  # Root module input parameters
├── versions.tf                   # Version constraint declarations
└── README.md                     # Comprehensive documentation
```

---

## 🧩 Technical Design Patterns

### 1. Child Module Encapsulation
A child module must be generic and reusable. It should not contain hardcoded environment names or hardcoded regions. All environment-specific values are injected through variables:
```hcl
# modules/resource-group/main.tf
resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
```

### 2. Composing Modules in Root `main.tf`
```hcl
module "resource_group" {
  source   = "./modules/resource-group"
  name     = "rg-${var.environment}-modular-demo"
  location = var.location
}

module "storage_account" {
  source              = "./modules/storage-account"
  name                = var.storage_account_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}
```

---

## 🛠️ Step-by-Step Getting Started Guide

### Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (v1.5.0+).

### 1. Format Code
```bash
terraform fmt -recursive
```

### 2. Initialize Working Directory
```bash
terraform init -backend=false
```
*Note: `terraform init` inspects local module sources and indexes child module blocks.*

### 3. Validate Configuration
```bash
terraform validate
```

### 4. Review Plan (Educational Documentation)
```bash
terraform plan -var-file="terraform.tfvars.example"
```

### 5. Apply Changes (Educational Documentation)
```bash
terraform apply
```
> ⚠️ **IMPORTANT**: In production, `terraform apply` requires manual confirmation. In this educational repository, no cloud deployment is executed.

---

## 🔄 Terraform Resource Lifecycle & Destruction Concepts

1. **Modular Destruction**:
   Calling `terraform destroy` on a modular root configuration tears down resources in reverse dependency order: child storage accounts are safely deleted before child resource groups.
2. **Removing Module Blocks**:
   Removing a `module "storage_account"` block from `main.tf` and running `terraform apply` instructs Terraform to destroy all resources managed by that child module. Always review the plan to verify scope.

---

## 🤖 CI/CD Automation (GitHub Actions)

This repository includes a continuous integration workflow in `.github/workflows/validate.yml` that validates the root module, each individual child module, and the multi-environment example directory on every push and pull request.

---

## 👨‍💻 Author Information

- **Developer**: Vishal Yadav (`vishalnik002-git`)
- **Education**: MCA @ Galgotias University (2025–2027) | BCA @ MGKVP (2022–2025)
- **Role**: DevOps Intern @ DevOps Insiders
- **GitHub Profile**: [https://github.com/vishalnik002-git](https://github.com/vishalnik002-git)
