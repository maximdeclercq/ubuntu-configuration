#!/bin/bash

### Init ###
mkdir -p .temp
cd .temp


### Drivers ###
## Nvidia ##
if [[ ! type "nvidia-settings" &> /dev/null ]]; then
  sudo add-apt-repository -y ppa:graphics-drivers/ppa > /dev/null
  sudo apt-get -qq update
  LATEST_DRIVER=$(sudo apt-cache search nvidia-driver | egrep -o "nvidia-driver-[0-9]{3}" | tail -1)
  sudo apt-get -qqy install ${LATEST_DRIVER} nvidia-prime
fi


### Settings ###
## Adwaita Dark Theme ##
sudo apt-get -qqy install adwaita-icon-theme-full
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
## Gnome Tweaks ##
sudo apt -qqy install gnome-tweaks


### Development ###
## Sublime Text ##
if [[ ! type "subl" &> /dev/null ]]; then
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get -qq update
  sudo apt-get -qqy install sublime-text
fi
## Jetbrains Toolbox ##
if [[ ! type "jetbrains-toolbox" &> /dev/null ]]; then
  curl -s https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash > /dev/null
fi


### Gaming ###
## Lutris ##
if [[ ! type "lustris" &> /dev/null ]]; then
  sudo add-apt-repository -y ppa:lutris-team/lutris > /dev/null
  sudo apt-get -qq update
  sudo apt-get -qqy install lutris
fi


### Other ###
## Gimp, Krita, Snap Store, Spotify and VLC ##
sudo snap install gimp krita snap-store spotify vlc
## Insync ##
if [[ ! type "insync" &> /dev/null ]]; then
  sudo apt-key -y adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C > /dev/null
  echo "deb http://apt.insync.io/ubuntu eoan non-free contrib" | sudo tee /etc/apt/sources.list.d/insync.list
  sudo apt-get -qq update
  sudo apt-get -qqy install insync-nautilus
fi
## WPS Office ##
if [[ ! type "wps" &> /dev/null ]]; then
  curl -sL http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/8865/wps-office_11.1.0.8865_amd64.deb -o wps.deb
  sudo dpkg -i wps.deb
fi


### Cleanup ###
cd ..
rm -r .temp
sudo reboot
