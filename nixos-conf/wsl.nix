# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "rtannady";
  wsl.wslConf.network.generateResolvConf = false;


  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  networking.hostName = "delo-nixos"; # Define your hostname.

users.users.rtannady = {
	isNormalUser = true;
	description = "rtannady delloite";
    	extraGroups = ["wheel"];
	packages = with pkgs; [
	ani-cli
	];
};

users.users.solum = {
    isNormalUser = true;
    description = "Solum";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
  #hac
  openvpn
  ligolo-ng
  radare2
  exploitdb
  wpscan
  thc-hydra
  metasploit
  rustscan
  ffuf
  nmap
  python311Packages.impacket
  nfs-utils
  samba
  sqlcmd
  enum4linux-ng
  crackmapexec


    ];
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  # any graphical interface program should not be here

  oh-my-zsh
  wget
  git
  kitty
  neofetch
  openssl
  zip
  unzip
  gzip
  inetutils

  #nvim
  neovim
  ripgrep
  lua
  luajit

  #dev
  gcc
  libgccjit
  python3
  pyenv #to use python2 if needed
  go
  rustc
  rustup
  nodejs
  postgresql
  mysql
  openjdk
  gnumake
  glibc
  redis
  kafkactl

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
 

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
