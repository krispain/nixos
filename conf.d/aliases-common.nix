{

  environment.shellAliases = {
    gs="git status";
    myip="dig +short myip.opendns.com @resolver1.opendns.com";
    view="vim -R";
    changes="if test \$(stat -c %Y -- \$(ls -trd /nix/var/nix/profiles/*-link|tail -n 1)) -gt \$(($EPOCHSECONDS - 120))  ; then nvd diff \$(ls -trd /nix/var/nix/profiles/*-link|tail -n 2); else echo 'No recent changes' ; fi";
    changes-force="nvd diff \$(ls -trd /nix/var/nix/profiles/*-link|tail -n 2)";
    nixos-update="cd /etc/nixos/chris/ && git pull && nixos-rebuild switch --upgrade && echo && changes ; echo ; date";
    nixos-clean="time nix-collect-garbage --delete-older-than 7d && time nix-store --optimize";
  };

  environment.sessionVariables = {
    HISTCONTROL="ignoreboth";
    HISTTIMEFORMAT="%F %T ";
    HISTSIZE="10000";
    HISTFILESIZE="20000";
  };

}
