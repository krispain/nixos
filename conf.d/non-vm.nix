{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # gstream HW accel
    gst_all_1.gst-vaapi
    dmidecode
    gnome.gnome-power-manager
    virtiofsd
    lm_sensors
    pciutils
  ];
}
