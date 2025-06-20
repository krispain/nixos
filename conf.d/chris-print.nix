{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     hplipWithPlugin
     system-config-printer
  ];
  
  # Printer Configuration
  hardware.printers.ensureDefaultPrinter = "LesiaHP";
  hardware.printers.ensurePrinters = [{
    name = "LesiaHP";
    deviceUri = "ipps://172.16.1.53"; # <- Set print URI here
    #description = "";
    #location = "";
    model = "HP/hp-deskjet_3650.ppd.gz"; 
    ppdOptions = {
      Duplex = "DuplexNoTumble";
      PageSize = "Letter";
      auth-info-required = "username,password"; # <- Literly the string "username,password" (do not provide actual username and password here! You will be asced when you print)
    };
  }];
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint hplip splix ];
    #extraConf = ''
    #  DefaultAuthType Negotiate
    #'';
  };
  services.system-config-printer.enable = true;
  programs.system-config-printer.enable = true;

}
