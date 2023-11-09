[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$appdata = "C:\Users\$env:username\AppData\Roaming"

#Welcome
$title = "Wyatt's wonderful Minecraft Installer"
$type = "SystemModal"
[Microsoft.VisualBasic.Interaction]::MsgBox('Welcome! this is the installer for Wyatt''s wonderful Minecraft. Get ready!', $type, $title)

#Set username
$msg = "What would you like your username to be?"
$defaultvalue = "real"
$mcuser = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title, $defaultvalue)

#Main install
[Microsoft.VisualBasic.Interaction]::MsgBox('It may take up to 5 minutes to install! You''ll know its finished once minecraft opens. Press [OK] to start.', $type, $title)
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=1niF4hZU2j1TCDAxIZ_xLN7OQ3yIBHfSX&confirm=t&uuid=38cd2b09-b2f7-4bdc-bc47-86c74ea700e1&at=AB6BwCA987ev-p9FAF1t0e0OTjoo:1699507109061" -OutFile "$appdata\wwmc.zip"

#Unzip
Expand-Archive "$appdata\wwmc.zip" -DestinationPath "$appdata" -Force
Remove-Item -Path "$appdata\wwmc.zip"

# Append username to file
$fileName = "$appdata\wwmc\accounts.json"
(Get-Content $fileName) -replace "real", "$mcuser" | Set-Content $fileName

#Create desktop shortcut
$whatshortcut = "C:\Users\$env:username\Desktop\minecraft.lnk"

$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($whatshortcut)
$shortcut.TargetPath = "$appdata\wwmc\wwmc.exe"
$Shortcut.Arguments = "-d ""$appdata\wwmc"" -l ""wwmc"" -s """" -a ""$mcuser"" -o"
$Shortcut.WorkingDirectory = "$appdata\wwmc"
$Shortcut.IconLocation = "$appdata\wwmc\icons\shortcut-icon.ico"
$shortcut.Save()

#Open up that shortcut
invoke-item $whatshortcut