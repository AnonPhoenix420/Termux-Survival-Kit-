# 🛡️ Termux Ultimate Survival Kit (v2.0)


​Automated Environment Provisioning & Dependency Repair

​A professional-grade deployment script designed to transform a stock Termux installation into a fully-equipped development and security environment.

This kit specifically resolves common architecture-specific build errors for Python 3.11/3.12+ and ARM64.



```​🚀 Features```



​Automatic Repository Management: Enables TUR, Root, and X11 repositories.

Compiler Optimization: Pre-configures Clang, CMake, and Ninja for Android.

Dependency Resolution: Fixes the "No installation candidate" error for SSL, FFI, and Sodium headers.

Modern Python Stack: Replaces deprecated PyCrypto with PyCryptodome and forces system-level linking for PyNaCl and PyCurl.

Survival Toolset: Full suite of networking (Nmap, Tor), automation (Python, Go, Rust), and utility tools.




```🛠️ Installation & Usage```



1. Bootstrap the Environment
Clone or create the script and ensure the Termux environment is ready:


```
termux-setup-storage pkg install git nano -y
```


2. Clone the Repository
​Clone the specific Master branch from the official repository:


```
https://github.com/AnonPhoenix420/Termux-Survival-Kit-.git

```

3. Execution
​Navigate into the directory and launch the survival script:


```
cd Termux-packages
chmod +x survival.sh
./survival.sh
```


Layer Components Strategy

**Toolchain Clang, Binutils, Make Native compilation

**Libraries OpenSSL, LibSodium, LibFFI Shared linking via $PREFIX

**Python Pip, Wheel, Setuptools PEP 517 build isolation bypass

**Network Tor, Cloudflared, Nmap Binary




```⚠️ Troubleshooting```


Build Failures (pynacl / cryptography)
If a Python module fails to build, the script automatically exports the following flags to guide the compiler:

1.) SODIUM_INSTALL=system

2.) LDFLAGS="-L${PREFIX}/lib"

3.) CPPFLAGS="-I${PREFIX}/include"



Python 2 Legacy

​Note that Python 2 is end-of-life. The script attempts to install legacy modules but will continue gracefully if they are no longer hosted in the repositories.



```📜 Repository Information```

      Author: AnonPhoenix420
      
         Branch: Master
         
    Source: GitHub Repository





