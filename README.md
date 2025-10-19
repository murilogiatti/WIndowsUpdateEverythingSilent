# UpdateEverythingSilent

## Overview
`UpdateEverythingSilent.ps1` is a PowerShell script for Windows 10/11 (including 25H2) that automatically updates **Winget applications** and **Windows updates**. At the end, it opens the **Microsoft Store updates page** for manual app updates. Reboot prompts only appear if required.

## Features
- Checks for **Administrator privileges** and requests elevation.
- Ensures **ExecutionPolicy** is `RemoteSigned`.
- Updates all **Winget apps** automatically.
- Applies **Windows updates**.
- Opens **Microsoft Store updates page** for manual app updates.
- Prompts for reboot only if necessary.

## Requirements
- Windows 10 or 11
- PowerShell 5.1 or newer
- Winget installed
- Internet connection

## Usage
1. Open PowerShell
2. Run the script
3.The script will:
  - Update Winget apps
  - Apply Windows updates
  - Prompt for reboot if needed
  - Open Microsoft Store updates page


**## Notes**

  - Microsoft Store apps cannot be updated automatically; click Get updates manually.
  - The script sets ExecutionPolicy for current user only.

**## License**
MIT License
