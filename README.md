# ⚙️ DevOps Environment Setup Script

This script automates the setup of a full **DevOps development environment** on a fresh Ubuntu Linux system. It installs popular DevOps tools like Docker, Kubernetes (Minikube), Terraform, Ansible, AWS CLI, and more — in a single run.

---

## 📂 Files

- `setup-devops.sh`: The full automation script

---

## 🧰 Tools Installed

| Tool               | Purpose                                       |
|--------------------|-----------------------------------------------|
| `curl`, `wget`, etc. | Essential system utilities                 |
| **Python 3 + pip** | Scripting & automation                        |
| **Docker**         | Containerization platform                     |
| **Docker Compose** | Multi-container Docker management             |
| **Ansible**        | Agentless configuration management            |
| **AWS CLI**        | Interact with AWS services via CLI            |
| **Terraform**      | Infrastructure as Code (IaC)                  |
| **kubectl**        | Kubernetes CLI tool                           |
| **Helm**           | Kubernetes package manager                    |
| **Minikube**       | Local Kubernetes cluster                      |
| **Oh My Zsh**      | Improved terminal experience                  |
| **SSH key**        | Secure Git or server authentication           |

---

## 🚀 Usage

### 1. Clone this repository (or copy the script):

```bash
git clone https://github.com/davmano/devops-setup-script.git
cd devops-setup
cd devops-setup-script
```

### 2. Run the script:

```bash
chmod +x setup-devops.sh
./setup-devops.sh
```

> ⚠️ You may need to enter your sudo password during installation.

---

## 🔍 Features

- Tracks failed installations and reports them at the end
- Automatically generates an SSH key if one doesn't exist
- Adds current user to the Docker group
- Clean and readable terminal output with status icons
- Installs pinned versions of Terraform and kubectl for consistency
- Uses idempotent checks where possible (e.g., avoids re-generating SSH keys or Oh My Zsh)

---

## 📌 System Requirements

- Ubuntu 20.04 or higher (tested on 22.04+)
- At least 4 GB RAM and 10 GB free disk space
- Internet access

---

## 📎 Post-Install Notes

- You may need to **logout/login** or run:
  ```bash
  exec su -l $USER
  ```
  to apply Docker group permissions.

- Run `zsh` to start using Oh My Zsh.

---

## 📥 Sample Output

```bash
✅ DevOps setup completed.

🎉 All services installed successfully!
```

Or:

```bash
❌ The following services failed to install:
 - Docker
 - AWS CLI
```

---

## 👨‍💻 Author

**David Mano**  
DevOps Engineer | CI/CD | Cloud Automation

---

## 🪪 License

MIT License
