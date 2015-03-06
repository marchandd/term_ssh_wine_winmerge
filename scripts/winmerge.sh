#!/bin/bash
#DM*20150306Running from install to launch (not alias in absence of source command)

#Common for all Windows PortableApps registry
wineCommand=$(which wine)
wineDirectory=~/.wine
winetricksCommand=$(which winetricks)
driveCDirectory=$wineDirectory/drive_c
installDirectory=~/.wine/drive_c/Installers
installFilePath=$installDirectory/$pafStandardProgramName
portableAppsDirectory=~/.wine/drive_c/PortableApps
targetDirectory=$portableAppsDirectory/$winProgramName
aliasFileLog="/start$winProgramName.log.txt"
#Specific Windows PortableApps registry
winProgramName="WinMergePortable"
pafStandardProgramName="WinMergePortable.paf.exe"
programName="winmerge"
winestartpath='C:\PortableApps\WinMergePortable\WinMergePortable.exe'
function installScriptCommand()
{
  if [ -d $targetDirectory ];
    then
      echo "install_WinmergePortable.sh passed"
    else
      echo "install_WinmergePortable.sh running..."
      install_WinmergePortable.sh
      exit
  fi
}
function postInstallAliasScriptCommand()
{
  if [ -n "$(grep "$programName" ~/.bash_aliases)" ];
    then
      echo "postInstall_AliasForWinmergePortable.sh passed"
    else
      echo "postInstall_AliasForWinmergePortable.sh running..."
      postInstall_AliasForWinmergePortable.sh
      echo "postInstall_AliasForWinmergePortable.sh passed"
  fi
}

#Common script
displaygrep=$(echo $DISPLAY | grep localhost:10.0)
function wineStartCommand()
{
  wine start $winestartpath > "$targetDirectory""$aliasFileLog" 2>&1
}
if [[ "$displaygrep" == "localhost:10.0" ]];
  then
    echo ""
  else
    echo "You are not inside a GUI shell. Installation aborted !"
    exit
fi
if [ ! $wineCommand ];
  then
    echo "Failed to find wine in computer. Installation aborted !"
    exit
fi
if [ ! $winetricksCommand ];
  then
    echo "Failed to find winetricks in computer. Installation aborted !"
    exit
fi
if [ -d $driveCDirectory ];
  then
    echo "_installFirst_winetricksOptions.sh passed"
  else
    echo "_installFirst_winetricksOptions.sh running..."
    _installFirst_winetricksOptions.sh
    exit
fi
installScriptCommand
postInstallAliasScriptCommand
echo "$programName running direct (without alias)"
wineStartCommand
