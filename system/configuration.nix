
{ config, pkgs, lib, ... }:
{

  imports = [
    "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz" }/raspberry-pi/4"
    ./users/admin.nix
    <home-manager/nixos>
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    tmpOnTmpfs = true;
    loader.raspberryPi = {
      enable = true;
      version=4;
    };
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = "hammer";
    wireless = {
      enable = true;
      networks."thundercougarfalconbird".psk = "breezywindow208";
      interfaces = [ "wlan0" ];
    };
  };

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  services.openssh.enable = true;

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;
  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

}
