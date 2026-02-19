#!/data/data/com.termux/files/usr/bin/bash

# ==========================================================
# Termux Auto-Setup & Repair Script
# Optimized for Python 3.11/3.12+ and ARM64
# ==========================================================

echo "🚀 Starting the Ultimate Termux Setup..."

# 1. CORE SYSTEM UPDATE
echo "🔄 Updating system packages..."
apt update --fix-missing && apt upgrade -y
termux-setup-storage

# 2. REPOSITORY SETUP
echo "📦 Enabling extra repositories..."
pkg install tur-repo root-repo x11-repo -y

# 3. COMPILER & BUILD TOOLS (Corrected for Termux Naming)
# Note: We use 'libffi' and 'openssl' directly as headers are bundled.
echo "🛠️ Installing build essentials..."
pkg install build-essential clang cmake ninja binutils \
python libffi openssl libsodium libandroid-execinfo \
libopenblas -y

# 4. LANGUAGES & RUNTIMES
echo "🐍 Installing programming languages..."
pkg install python python2 python3 perl ruby golang php rust -y

# 5. NETWORKING & SURVIVAL TOOLS
echo "🌐 Installing networking tools..."
pkg install wget curl tor cloudflared subversion openssh \
nmap proxychains-ng -y

# 6. SYSTEM-LEVEL PYTHON PACKAGES
# Installing these via 'pkg' is 10x faster and more stable than 'pip'
echo "📊 Installing scientific Python modules..."
pkg install python-numpy python-pandas python-cryptography python-bcrypt -y

# 7. ENVIRONMENT EXPORTS (The "Magic Sauce" for Pip)
# These flags tell the compiler where to find the libraries installed above.
export SODIUM_INSTALL=system
export PYCURL_SSL_LIBRARY=openssl
export LDFLAGS="-L${PREFIX}/lib"
export CPPFLAGS="-I${PREFIX}/include"

# 8. PIP MODULE INSTALLATION
echo "📦 Installing Python modules..."
pip install --upgrade pip setuptools wheel
pip install pyproject_metadata cython beautifulsoup4 slowloris sshmaster

# Critical Fix: Pynacl and PyCurl
echo "🩹 Patching PyNaCl and PyCurl..."
pip install pynacl pycurl

# Critical Fix: PyCryptodome (Modern replacement for PyCrypto)
# This allows scripts using 'from Crypto.Cipher import...' to work.
echo "🔐 Installing PyCryptodome..."
pip install pycryptodome

# 9. LEGACY SUPPORT (Python 2)
echo "📜 Attempting legacy Python 2 installs..."
pip2 install python-ping python-geoip pycrypto || echo "Note: Some Python 2 packages failed (EOL)."

# 10. FINAL CLEANUP
echo "🧹 Cleaning up cache..."
apt autoremove -y && apt clean

echo "==============================================="
echo "✅ SETUP COMPLETE!"
echo "Python Version: $(python --version)"
echo "Tip: Use 'pycryptodome' for all your encryption needs."
echo "==============================================="
