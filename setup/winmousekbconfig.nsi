; WindowsMouseKBConfig.nsi
;
; This script is for creating setup for Windows 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install into a directory that the user selects.
;

;--------------------------------

; The name of the installer
Name "Windows Mouse Keyboard Configurator Setup"

; The file to write
OutFile "winmousekbconfigsetup.exe"

; Request application privileges for Windows Vista and higher
RequestExecutionLevel admin

; Build Unicode installer
Unicode True

; The default installation directory
InstallDir $PROGRAMFILES\WinMouseKBConfig

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\WinMouseKBConfig" "Install_Dir"

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "Windows Disable Mouse Buttons (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File "disablemousebuttons.exe"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\WinMouseKBConfig "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\WinMouseKBConfig" "DisplayName" "Windows Mouse KB Configurator Uninstall"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\WinMouseKBConfig" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\WinMouseKBConfig" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\WinMouseKBConfig" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\WinMouseKBConfig"
  CreateShortcut "$SMPROGRAMS\WinMouseKBConfig\Uninstall.lnk" "$INSTDIR\uninstall.exe"
  CreateShortcut "$SMPROGRAMS\WinMouseKBConfig\Disable Mouse Buttons.lnk" "$INSTDIR\disablemousebuttons.exe"

SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\WinMouseKBConfig"
  DeleteRegKey HKLM SOFTWARE\WinMouseKBConfig

  ; Remove files and uninstaller
  Delete $INSTDIR\disablemousebuttons.exe
  Delete $INSTDIR\uninstall.exe

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\WinMouseKBConfig\*.lnk"

  ; Remove directories
  RMDir "$SMPROGRAMS\WinMouseKBConfig"
  RMDir "$INSTDIR"

SectionEnd
