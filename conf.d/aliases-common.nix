{

  environment.shellAliases = {
    gs="git status";
    myip="dig +short myip.opendns.com @resolver1.opendns.com";
    view="vim -R";
    changes="nvd diff $(ls -trd /nix/var/nix/profiles/*-link|tail -n 2)";
  };

  environment.sessionVariables = {
    HISTCONTROL="ignoreboth";
    HISTTIMEFORMAT="%F %T ";
    HISTSIZE="10000";
    HISTFILESIZE="20000";
  };

}
