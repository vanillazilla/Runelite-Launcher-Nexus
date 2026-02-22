[Setup]
AppName=Carnage Launcher
AppPublisher=Carnage
UninstallDisplayName=Carnage
AppVersion=${project.version}
AppSupportURL=https://carnage.horrordev.com/
DefaultDirName={localappdata}\Carnage

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Carnage.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=CarnageSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\native-win32\Carnage.exe"; DestDir: "{app}"
Source: "${basedir}\native-win32\Carnage.jar"; DestDir: "{app}"
Source: "${basedir}\native\build32\Release\launcher_x86.dll"; DestDir: "{app}"
Source: "${basedir}\native-win32\config.json"; DestDir: "{app}"
Source: "${basedir}\native-win32\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Carnage\Carnage"; Filename: "{app}\Carnage.exe"
Name: "{userprograms}\Carnage\Carnage (configure)"; Filename: "{app}\Carnage.exe"; Parameters: "--configure"
Name: "{userprograms}\Carnage\Carnage (safe mode)"; Filename: "{app}\Carnage.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Carnage"; Filename: "{app}\Carnage.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Carnage.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Carnage.exe"; Description: "&Open Carnage"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Carnage.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.carnage\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"