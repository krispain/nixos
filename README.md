# nixos
# Nixos Configuration

(inspred by: https://git.nickyeoman.com/nick/nixos.git :-) )

This configuration assumes you have installed with no GUI selected, otherwise there will be conflicts when you add this configuration.

On a laptop, get wifi up and running
```bash
nmcli dev status
nmcli radio wifi
nmcli dev wifi list
nmcli --ask dev wifi connect <YOUR SSID>
```

On a new install you can just get git:

```bash
nix-shell -p git vim
```

Then you can pull this repo as root:

```bash
cd /etc/nixos
git clone https://github.com/krispain/nixos.git /etc/nixos/chris
```

Include repo by changing /etc/nixos/configuration.nix to include ```chris/conf.d/chris.nix``` like so:
```bash
imports = 
  [
    ./hardware-configuration.nix
    ./chris/conf.d/chris.nix
  ];
```

For VMs also include the file
```./chris/conf.d/vm.nix``` 
to add the vdagent for clipboard copy/paste between host and guest.

Also need to enable the unstable channel for a few packages:
```bash
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
```

Then run:
```nixos-rebuild switch --upgrade```

