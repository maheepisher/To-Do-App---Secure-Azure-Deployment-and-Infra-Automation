# Azure Infrastructure Automation & Secure App Deployment

**Project overview (1-line):**  
Automated, secure Azure infrastructure provisioning and containerized app deployment showcasing ARM templates, Terraform, Azure networking (VNet, NSG, Bastion), RBAC-ready patterns, and a sample Dockerized To‑Do app for end-to-end demos and CI/CD integration.

---
## Project goals & success criteria
- **Repeatable infrastructure**: deploy identical environments using Terraform and ARM templates.
- **Secure admin access**: avoid public SSH/RDP exposure — provide Bastion host for admin connectivity.
- **Least-privilege operations**: demonstrate RBAC patterns for separating duties (owners/operators/read-only).
- **PaaS container hosting**: run a Dockerized single-page To‑Do app on Azure App Service (Linux container).
- **Developer experience**: provide Cloud Shell scripts and CI-ready layout for GitHub Actions integration.

---
## Architecture (what is provisioned)
1. **Resource Group** — logical container for related resources and lifecycle management.
2. **Virtual Network (VNet)** with two subnets:
   - **app-subnet**: houses PaaS endpoints and can host internal services.
   - **AzureBastionSubnet**: reserved subnet required by Azure Bastion (/26 minimum recommended).
3. **Network Security Group (NSG)** — controls inbound/outbound traffic for the app-subnet and VM.
4. **Bastion Host** — browser-based RDP/SSH to VMs without a public IP; secures admin access.
5. **Virtual Machine (Linux)** — example admin/utility VM (no public IP; accessed via Bastion).
6. **Azure Container Registry (ACR)** — optional private image registry to store container images.
7. **App Service Plan + Web App (Linux, Container)** — PaaS hosting for the Dockerized To‑Do app.
8. **RBAC guidance** — templates include guidance and placeholders to assign built-in roles (Owner, Contributor, Reader) to users/service principals.

---
## Layout 
```
azure-infra-automation/
│── README.md
│── architecture-diagram.png
│── /app/
│     ├── package.json
│     ├── index.js
│     ├── Dockerfile
│     ├── public/index.html
│── /arm-templates/
│     ├── azure-deploy.json
│     ├── parameters.json
│── /terraform/
│     ├── main.tf
│     ├── variables.tf
│     ├── outputs.tf
│── /scripts/
│     ├── azure-cli-commands.sh
│     ├── cloud-shell-setup.sh

```

---
## How to deploy (concise, repeatable steps)

### Option A — ARM (deploy via Cloud Shell or Portal)
1. `az group create --name rg-todo-final --location eastus`
2. `az deployment group create --resource-group rg-todo-final --template-file arm-templates/azure-deploy.json --parameters arm-templates/parameters.json`
3. Follow outputs to find Web App hostname and Bastion status.

### Option B — Terraform
```bash
cd terraform
terraform init
terraform plan -var="resource_group_name=rg-todo-final" -var="location=eastus"
terraform apply -var="resource_group_name=rg-todo-final" -var="location=eastus"
```
Terraform will create the same set of resources and output the web app hostname and ACR login server.

### Local app testing (before pushing image)
```bash
cd app
docker build -t todo-sample:latest .
docker run -p 8080:8080 todo-sample:latest
# Open http://localhost:8080
```

---

## Files with explanations (quick)
- **arm-templates/azure-deploy.json** — one ARM template that provisions VNet, subnets, NSG, public IP (for Bastion), Bastion Host, VM, App Service Plan & Web App. Parameterized for location and naming.
- **terraform/main.tf** — Terraform equivalent with comments and variables. Also contains ACR, App Service, VM and Bastion pieces.
- **app/** — sample Node.js To‑Do app + Dockerfile (ready for local run and containerization).
- **scripts/** — helper scripts to speed manual validation and ACR image push.

---
## Security & cost notes
- The ARM/Terraform defaults are small (Basic/SKU) to reduce cost during demos. Always validate pricing for your subscription/region before running.  
- The VM uses a small size (e.g., Standard_B1s) and the App Service plan uses B1 by default in the templates. These are for demos only.
