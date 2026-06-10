{

  # Big storage at home
  fileSystems."/mnt/WDNFS" =
    { device = "172.16.1.74:/nfs/WDNFS";
      fsType = "nfs";
      options = [
          "x-systemd.automount"
	  "noauto"
	  "x-systemd.idle-timeout=600"
      ];
    };
  fileSystems."/mnt/storage-3" =
    { device = "172.16.1.250:/mnt/array1/storage-3";
      fsType = "nfs";
      options = [
          "x-systemd.automount"
	  "noauto"
	  "x-systemd.idle-timeout=600"
      ];
    };
}
