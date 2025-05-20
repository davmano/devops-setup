#!/bin/bash

# -----------------------
# DevOps Full Setup Script
# -----------------------

FAILED_SERVICES=()

log_error() {
  echo "⚠️ $1 install failed"
  FAILED_SERVICES+=("$1")
}

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y || log_error "System update"

echo "📦 Installing base packages..."
sudo apt install -y \
  curl wget git unzip gnupg2 software-properties-common \
  build-essential apt-transport-https ca-certificates \
  jq tree htop tmux zsh || log_error "Base packages"

echo "🐍 Installing Python 3 and pip..."
sudo apt install -y python3 python3-pip || log_error "Python 3 + pip"

echo "🐳 Installing Docker..."
{
  curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
  sudo usermod -aG docker $USER
  echo "ℹ️ Docker installed. You must logout/login or run: exec su -l \$USER"
} || log_error "Docker"

echo "🧱 Installing Docker Compose..."
{
  sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.2/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
} || log_error "Docker Compose"

echo "🤖 Installing Ansible..."
sudo apt install -y ansible || log_error "Ansible"

echo "☁️ Installing AWS CLI..."
{
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
  unzip -o awscliv2.zip
  sudo ./aws/install
  rm -rf awscliv2.zip aws/
} || log_error "AWS CLI"

echo "🌍 Installing Terraform..."
{
  TERRAFORM_VERSION="1.6.6"
  curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o terraform.zip
  unzip terraform.zip
  sudo mv terraform /usr/local/bin/
  terraform -install-autocomplete || true
  rm -f terraform.zip
} || log_error "Terraform"

echo "⚙️ Installing kubectl..."
{
  KUBECTL_VERSION="v1.29.3"
  curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
} || log_error "kubectl"

echo "⛵ Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash || log_error "Helm"

echo "📦 Installing Minikube..."
{
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  rm -f minikube-linux-amd64
} || log_error "Minikube"

echo "💡 Installing Oh My Zsh..."
{
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sudo apt install -y zsh
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
} || log_error "Oh My Zsh"

echo "🔐 Generating SSH key (ed25519, if missing)..."
{
  if [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
    ssh-keygen -t ed25519 -C "$USER@$(hostname)" -N "" -f "$HOME/.ssh/id_ed25519"
    echo "Public key:"
    cat "$HOME/.ssh/id_ed25519.pub"
  fi
} || log_error "SSH key (ed25519)"

# -----------------------
# Summary
# -----------------------
echo "✅ DevOps setup completed."

if [ ${#FAILED_SERVICES[@]} -ne 0 ]; then
  echo ""
  echo "❌ The following services failed to install:"
  for svc in "${FAILED_SERVICES[@]}"; do
    echo " - $svc"
  done
else
  echo "🎉 All services installed successfully!"
fi

echo ""
echo "⚠️ NOTE: You may need to logout/login or run 'exec su -l \$USER' for Docker group access to apply."
l
