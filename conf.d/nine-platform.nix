{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     python314
     bazel
     go
     google-cloud-sdk
     kubectl
     glab
     eget
  ];

  environment.sessionVariables = {
    GOPRIVATE="gitlab.nine.ch";
    GO_REPOSITORY_USE_HOST_CACHE="1";
  };

}
