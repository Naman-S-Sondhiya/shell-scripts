#!/bin/bash
# install_python.sh
# Script to install Python (default: 3.11)

set -e

PY_VERSION="3.11"

echo "🚀 Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

echo "📦 Installing dependencies..."
sudo apt install -y software-properties-common curl wget build-essential

echo "➕ Adding deadsnakes PPA (for latest Python versions)..."
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update -y

echo "🐍 Installing Python $PY_VERSION..."
sudo apt install -y python${PY_VERSION} python${PY_VERSION}-venv python${PY_VERSION}-dev python3-pip

echo "🔗 Setting python3 -> python${PY_VERSION}"
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PY_VERSION} 1

echo "✅ Verifying installation..."
python3 --version
pip3 --version
