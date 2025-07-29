{
  # allow for temporary edits
  environment.etc.hosts.mode = "0644";

  networking.extraHosts = ''
  172.16.1.71	pi4
  172.16.1.74	wdnfs
  217.150.240.27	housing fedora rocky
'';
}
