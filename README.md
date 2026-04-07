# 🛡️ UV-Guardian (uv-safe)

**A simple security wrapper for `uv` to help prevent installing malicious packages.**
Built after realizing how easy it is to accidentally install compromised dependencies.

---

## 🛑 The Problem: PyPI Supply Chain Attacks

Modern Python development relies on thousands of external dependencies. Recently, the ecosystem has seen a rise in:

1. **Typosquatting**  
   Malicious packages with names almost identical to popular ones  
   _(e.g., `reqvests` instead of `requests`)._

2. **Zero-Day Malware**  
   Hackers taking over a library and releasing a "poisoned" version that executes immediately.

3. **Malicious Build Scripts**  
   Code hidden inside `setup.py` designed to steal `.env` credentials or SSH keys during installation.

---

## ✨ The Solution: UV-Guardian

This started as a personal safety layer while working with Python dependencies.
`UV-Guardian` (via the `uv-safe` command) acts as a security checkpoint.

It enforces a **Defense in Depth** strategy, combining the extreme speed of `uv` with architectural safety patterns.

---

## 🚀 Installation

To install **UV-Guardian** in your PowerShell environment:

### 1. Open your PowerShell profile
```powershell
notepad $PROFILE
```

### 2. Paste the `uv-safe` function
Add your function into the file and save it.

### 3. Reload your profile
```powershell
. $PROFILE
```

---

## ⚠️ Platform Support

Currently supported:

- 🪟 Windows (PowerShell Desktop) — fully tested

May work on Linux/macOS with PowerShell Core (pwsh), but not officially supported.

---

## 🛠️ Usage

Replace your standard `uv add` with:

```powershell
uv-safe <package-name>
```

---

## ⚙️ What Happens Under the Hood?

### 🔍 Vulnerability Scan
Automatically checks for outdated or vulnerable packages in your current project.

### ⏳ 7-Day Quarantine
Defaults to versions released at least **7 days ago** to avoid zero-day malicious releases.

### ⚖️ Human Audit
Provides a direct link to the PyPI history for manual verification before installation.

### 🛡️ Environment Shield
Detects `.env` files and warns about potential credential leaks.

---

## 🔒 Why Is It Secure?

| Feature | Implementation | Purpose |
|--------|---------------|--------|
| **Time-Based Vetting** | `--exclude-newer` | Waits for the community to detect malicious updates |
| **No Build Execution** | `--no-build` | Prevents arbitrary code execution during install |
| **Project Guard** | `pyproject.toml` | Avoids global/system contamination |
| **Leak Prevention** | `.env` | Warns about sensitive files |

---

## 🏗️ Architecture Philosophy

This tool follows **Clean Architecture** principles.

By separating:
- **Validation Logic (Domain)**
- **Package Execution (Infrastructure)**

UV-Guardian ensures that security is not an afterthought, but a core part of the development workflow.

---

## 🤝 Contributing

Contributions are welcome.

- Report bugs or suggest improvements via issues  
- Submit pull requests with enhancements or fixes  

Small improvements, ideas, or security suggestions are always welcome.

## 👨‍💻 Author

Developed by **CrackNicolas**  
Focused on security and developer tooling.