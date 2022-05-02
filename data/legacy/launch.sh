#!/bin/bash

export GAMEDIR=Games/riot-games
export BINDIR=/opt/wine-tkg-staging-git/bin
export PATH=$BINDIR:$PATH
export LD_LIBRARY_PATH=$BINDIR/../lib64:$BINDIR/../lib32:$BINDIR/../lib:$LD_LIBRARY_PATH

export WINEPREFIX=$HOME/$GAMEDIR/pfx/
export WINEDLLOVERRIDES="mscoree,mshtml,winemenubuilder.exe="
export WINEDEBUG=-all

if [ $1 = "lol" ]; then
  echo "[+] info:: lunion-play: Preparing to launch League of Legends..."
elif [ $1 = "lor" ]; then
  echo "[+] info:: lunion-play: Preparing to launch Legends of Runeterra..."
elif [ -z $1 ]; then
  echo "[+] info:: lunion-play: Preparing to launch Riot Client..."
fi
wineboot &> /dev/null && wineserver --wait

unset WINEDLLOVERRIDES
unset WINEDEBUG

export WINEDLLOVERRIDES="winemenubuilder.exe="
#export WINEESYNC=1
export WINEFSYNC=1
#export WINEDEBUG=fixme-all
#export WINEDEBUG=-all

# For log error
#export WINEDEBUG=+seh,+pid,+tid,+loaddll,+kernelbase,+relay

# DXVK
#export DXVK_HUD=devinfo,fps,version,api
#export DXVK_HUD=full
export DXVK_LOG_LEVEL=none

export __GL_SHADER_DISK_CACHE=1
export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
export __GL_SHADER_DISK_CACHE_PATH=$HOME/$GAMEDIR/shaders

#export MANGOHUD=1
export MANGOHUD_CONFIGFILE=$HOME/Games/mangohud.config

# Prevention en reference au probleme que j'ai eu avec The Witcher 3

arg="$1"
case $arg in
	lol)
		export MANGOHUD_CONFIGFILE=$HOME/$GAMEDIR/mangohud-lol.config
		
		#cd $HOME/Games/riot-games/Riot\ Games/Riot\ Client
		cd $HOME/Games/riot-games/pfx/drive_c/Riot\ Games/Riot\ Client
		#cd $HOME/Games/riot-games/pfx/drive_c/Riot\ Games/League\ of\ Legends/
		echo "[+] info:: lunion-play: Starting..."
		wine RiotClientServices.exe --launch-product=league_of_legends --launch-patchline=live
		#wine LeagueClient.exe
		
		# PBE LoL
		#cd $HOME/$GAMEDIR/pfx/drive_c/Riot\ Games/League\ of\ Legends
		#wine RiotClientServices.exe --launch-product=league_of_legends --launch-patchline=pbe
		#wine LeagueClient.exe
		;;
	lor)
		#cd $HOME/$GAMEDIR/pfx/drive_c/Riot\ Games/Riot\ Client
		cd $HOME/$GAMEDIR/Riot\ Games/Riot\ Client
		#cd $HOME/$GAMEDIR/pfx/drive_c/Riot\ Games/LoR/live/Game
		#wine RiotClientServices.exe --launch-product=bacon --launch-patchline=live
		echo "[+] info:: lunion-play: Starting..."
		wine RiotClientServices.exe --launch-product=bacon --launch-patchline=live
		#wine64 LoR.exe
		;;
	val)
		#cd $HOME/$GAMEDIR/pfx/drive_c/Riot\ Games/Riot\ Client
		#wine64 RiotClientServices.exe --launch-product=valorant --launch-patchline=live
		;;
	-h)
		echo "Usage: $0 [lol|lor|val]"
		echo "  lol     League of Legends"
		echo "  lor     League of Runeterra"
		echo "  val     Valorant - (don't work)"
		exit 1
		;;
	--help)
		echo "Usage: $0 [lol|lor|val]"
		echo "  lol     League of Legends"
		echo "  lor     League of Runeterra"
		echo "  val     Valorant - (don't work)"
		exit 1
		;;
	*)
		echo "Unknown argument: -h or --help for help"
		echo "Usage: $0 [lol|lor|val]"
		exit 1
		;;
esac
################################################################################

wineserver --wait
