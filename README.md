# nixos
# Nixos Configuration

(inspred by: https://git.nickyeoman.com/nick/nixos.git :-) )

On a new install you can just get git:

```bash
nix-env -i git
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

Then run:
```nixos-rebuild switch```
