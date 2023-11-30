#!/run/current-system/sw/bin/bash


# Add flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

######################################
# wwphone installed via flatpak from #
# Dan's github repository            #
# ####################################

# Clone Dan's repo
cd ~
git clone https://gitlab.com/shieldwed/ch.wwcom.wwphone.git
cd ch.wwcom.wwphone/

# need to explicitly clone shared-modules dependancy
git clone https://github.com/flathub/shared-modules

# flatpak dependencies
flatpak install flathub org.freedesktop.Sdk/x86_64/23.08
flatpak install org.freedesktop.Sdk/x86_64/23.08
flatpak install org.freedesktop.Platform/x86_64/23.08

# build flatpak
flatpak-builder --repo=/home/cpayne/flatpaks/ build-dir ch.wwcom.wwphone.yaml --force-clean

# add user repository
flatpak --user remote-add --no-gpg-verify chris-repo /home/cpayne/flatpaks

# install the flatpak from local repo
flatpak --user install chris-repo ch.wwcom.wwphone

# create config file to set English
mkdir -p /home/cpayne/.var/app/ch.wwcom.wwphone/.config/wwphone
cat <<EOF > /home/cpayne/.var/app/ch.wwcom.wwphone/.config/wwphone/wwphone.cfg
<?xml version="1.0" emcpdomgs="UTF-8"?>
<CONFIG lang="en" Server="nine.smartpbx.ch"/>
EOF

# first run
flatpak run ch.wwcom.wwphone 

# If this file is secured.... add all details
#
# cat <<EOF > /home/cpayne/.var/app/ch.wwcom.wwphone/.config/wwphone/wwphone.cfg
# <?xml version="1.0" emcpdomgs="UTF-8"?>
# <CONFIG lang="en" Server="nine.smartpbx.ch" User="cpayne" Password="PUT THE PASSWORD HERE!!!!!!" mode="1" prefix1="0041" preventTLS="0" active_identity="1" numListViews="1" isExpanded="0" MainFormX="1086" MainFormY="61" lv0w="250"/>
# EOF
