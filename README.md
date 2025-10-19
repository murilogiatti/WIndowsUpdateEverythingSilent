# UpdateEverythingSilent

## Overview
UpdateEverythingSilent.ps1 is a PowerShell script for Windows 10/11 (including 25H2) that automatically updates **Winget applications** and **Windows updates**. At the end, it opens the **Microsoft Store updates page** for manual app updates. Reboot prompts only appear if required.

---

## Features
- Checks for **Administrator privileges** and requests elevation  
- Ensures **ExecutionPolicy** is set to `RemoteSigned`  
- Updates all **Winget apps** automatically  
- Applies **Windows updates**  
- Opens **Microsoft Store updates page** for manual updates  
- Prompts for reboot only if necessary  

---

## Requirements
- Windows 10 or Windows 11  
- PowerShell 5.1 or newer  
- Winget installed  
- Internet connection  

---
## Usage
To run the script, copy and paste the following command into a PowerShell window. This will download and execute the script as **Administrator**:

```powershell
Start-Process powershell -ArgumentList "iwr https://raw.githubusercontent.com/murilogiatti/WindowsUpdateEverythingSilent/main/UpdateEverythingSilent.ps1 | iex" -Verb RunAs
``
---

## Notes
- Microsoft Store apps **cannot be updated automatically**; click **Get updates** manually  
- ExecutionPolicy is set for the **current user only**  
- For automatic scheduling, use **Windows Task Scheduler** with administrator privileges  

---

## License
MIT License
