{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     python314
     bazel
     go
     google-cloud-sdk
  ];

}
