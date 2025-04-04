{ pkgs, ... }:
{
# setup the routing for the nine wireguard VPNs
      networking.networkmanager.dispatcherScripts = [ 
	{ 
          source = ./scripts/dispatcher.sh;
	  type = "basic";
     	} 
     ];
}
