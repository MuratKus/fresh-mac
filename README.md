# fresh-mac 
# macOS Setup Automation

This repository contains a setup script to automate the configuration of a new macOS machine. It installs essential tools, applications, and system tweaks to streamline your environment for personal or work use.

---

## **Features**
- **Development Tools**: Node.js, Python, SDKMAN, Flutter, Android Studio.
- **QA Tools**: Cypress, Playwright, Selenium, Appium, HTTPie.
- **Productivity Tools**: Proxyman, Postman, Slack, and various browsers.
- **Window Management**: Rectangle.
- **Shell Configuration**: Zsh, Oh My Zsh, Autosuggestions, Syntax Highlighting.
- **macOS Tweaks**: Finder and Dock customizations.

---

## **Prerequisites**
1. A macOS system with basic internet connectivity.
2. Familiarity with terminal commands.
3. (Optional) A GitHub account to sync dotfiles and preferences.

---

## **Installation Steps**

### 1. Clone this Repository
```bash
git clone https://github.com/your-username/setup-repo.git ~/setup-repo
cd ~/setup-repo
```

### 2. Run the Setup Script
```bash
chmod +x setup.sh
./setup.sh
```

### 3. Restart Your Terminal
Restart your terminal after running the script for all changes to take effect.

---

## **Reminders and Usage Tips**

### **Mackup: Restore Your Preferences**
Mackup syncs application settings across devices. After installation, restore your settings using:
```bash
mackup restore
```
Make sure you’ve backed up your settings previously with:
```bash
mackup backup
```

### **Zsh Configuration**
The script installs **Oh My Zsh** with plugins for autosuggestions and syntax highlighting. You can further customize your shell by editing `~/.zshrc`:
- Add or modify plugins:
  ```bash
  plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
  ```
- Reload Zsh for changes:
  ```bash
  source ~/.zshrc
  ```

### **Testing Tools**
- **Cypress**: Launch with:
  ```bash
  cypress open
  ```
- **Playwright**: Start testing with:
  ```bash
  npx playwright test
  ```
- **HTTPie**: Test APIs easily:
  ```bash
  http GET https://api.example.com
  ```

### **Proxy and Debugging Tools**
- **Proxyman**: Inspect network traffic.
- **Postman**: Test APIs and automate workflows.

### **Mobile Development**
- Use **ADB** for Android debugging:
  ```bash
  adb devices
  ```
- **Flutter Tools**: Pre-installed for cross-platform mobile development.

### **macOS Tweaks**
- Finder displays hidden files by default.
- The Dock is resized and auto-hidden.
- Modify these settings in `setup.sh` as needed.

---

## **Troubleshooting**

### Common Issues
- **Permission Errors**: If you encounter permission issues, run:
  ```bash
  chmod +x setup.sh
  sudo ./setup.sh
  ```
- **Zsh Issues**: Check your `~/.zshrc` for conflicting configurations or plugin issues.

### Updating the Script
As tools and versions change, update your `setup.sh` script and dependencies in this repository. Use pull requests to manage changes if collaborating.

---

## **Future Enhancements**
- Add Ansible for multi-system setups.
- Include Docker containerization for reproducible environments.
- Automate backups and restores using cloud services.

---

Feel free to customize the script and documentation to suit your personal or team workflows. Contributions are always welcome!

