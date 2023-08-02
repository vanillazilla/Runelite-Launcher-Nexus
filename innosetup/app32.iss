[Setup]
AppName=Nexus Launcher
AppPublisher=Nexus
UninstallDisplayName=Nexus
AppVersion=${project.version}
AppSupportURL=https://nexus.net/
DefaultDirName={localappdata}\Nexus

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Nexus.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=NexusSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\native-win32\Nexus.exe"; DestDir: "{app}"
Source: "${basedir}\native-win32\Nexus.jar"; DestDir: "{app}"
Source: "${basedir}\native\build32\Release\launcher_x86.dll"; DestDir: "{app}"
Source: "${basedir}\native-win32\config.json"; DestDir: "{app}"
Source: "${basedir}\native-win32\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Nexus\Nexus"; Filename: "{app}\Nexus.exe"
Name: "{userprograms}\Nexus\Nexus (configure)"; Filename: "{app}\Nexus.exe"; Parameters: "--configure"
Name: "{userprograms}\Nexus\Nexus (safe mode)"; Filename: "{app}\Nexus.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Nexus"; Filename: "{app}\Nexus.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Nexus.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Nexus.exe"; Description: "&Open Nexus"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Nexus.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.nexus\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"