#!/data/data/com.termux/files/usr/bin/bash

# ==========================================================
# Termux Auto-Setup & Repair Script (v2.0)
# Optimized for Python 3.11/3.12+ and ARM64
# ==========================================================

set -e # Exit immediately if a critical command fails

echo "🚀 Starting Termux Survival Kit Setup..."

# 1. CORE SYSTEM UPDATE
echo "🔄 Updating system packages..."
apt update --fix-missing && apt upgrade -y
termux-setup-storage

# 2. REPOSITORY SETUP
echo "📦 Enabling extra repositories..."
pkg install tur-repo root-repo x11-repo -y || true
apt update

# 3. COMPILER & BUILD TOOLS
echo "🛠️ Installing build essentials..."
pkg install build-essential clang cmake ninja binutils pkg-config make \
python libffi openssl libsodium libandroid-execinfo \
libopenblas -y

# 4. LANGUAGES & RUNTIMES
echo "🐍 Installing programming languages..."
pkg install python perl ruby golang php rust -y

# 5. NETWORKING & SURVIVAL TOOLS
echo "🌐 Installing networking and system tools..."
pkg install wget curl git nano tmux termux-api proot-distro \
tor cloudflared subversion openssh nmap proxychains-ng torsocks -y

# 6. SYSTEM-LEVEL PYTHON PACKAGES
echo "📊 Installing scientific Python modules..."
pkg install python-numpy python-pandas python-cryptography python-bcrypt -y

# 7. ENVIRONMENT EXPORTS
export SODIUM_INSTALL=system
export PYCURL_SSL_LIBRARY=openssl
export LDFLAGS="-L${PREFIX}/lib"
export CPPFLAGS="-I${PREFIX}/include"
export CFLAGS="-I${PREFIX}/include"

# 8. PIP MODULE INSTALLATION (--break-system-packages for PEP 668)
echo "📦 Installing Python modules..."
pip install --upgrade pip setuptools wheel --break-system-packages
pip install pyproject_metadata cython beautifulsoup4 slowloris sshmaster --break-system-packages

# Critical Fixes: PyNaCl, PyCurl, PyCryptodome
echo "🔐 Installing PyNaCl, PyCurl, and PyCryptodome..."
pip install pynacl pycurl pycryptodome --break-system-packages

# 9. LEGACY PYTHON 2 CHECK
if command -v python2 &> /dev/null; then
    echo "📜 Attempting legacy Python 2 installs..."
    pip2 install python-ping python-geoip pycrypto || echo "Note: Python 2 packages failed (EOL)."
else
    echo "ℹ️ Python 2 not detected. Skipping legacy step."
fi

# 10. FINAL CLEANUP
echo "🧹 Cleaning up cache..."
apt autoremove -y && apt clean

echo "==============================================="
echo "✅ SETUP COMPLETE!"
echo "Python Version: $(python --version)"
echo "Tip: Use 'pycryptodome' for encryption operations."
echo "==============================================="
