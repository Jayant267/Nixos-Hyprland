# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #Linux Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Intel CPU microcode updates
  hardware.cpu.intel.updateMicrocode = true;

  # CPU Profile
  powerManagement.cpuFreqGovernor = "performance";

  # GPU Setup
  services.xserver.videoDrivers = [ "nouveau" "modesetting" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable Flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.lightdm.enable = true;  
  services.xserver.desktopManager.cinnamon.enable = true;
  
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jayant = {
    isNormalUser = true;
    description = "Jayant";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    vlc
    exfat
    ntfs3g
    fastfetch
    exfatprogs
    tor-browser
    qbittorrent
    mission-center
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-vdagent
    spice-protocol
    libguestfs
    qemu_full
    virtiofsd
    OVMFFull
    hdparm
    virglrenderer
    mesa
    mesa-demos
    vulkan-loader
    vulkan-tools
    intel-media-driver
    intel-vaapi-driver
    nerd-fonts.hack
    brightnessctl
    pavucontrol
    waybar
    hyprpaper
    hyprcursor
    hyprshot
    hyprlock
    alacritty
    rofi-wayland
    material-cursors
    nwg-look
    nwg-displays
    vim-full
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  environment.shellAliases = {
    ll = "ls -lh";
    nrs = "sudo nixos-rebuild switch --upgrade";
    ncg = "sudo nix-collect-garbage -d && sudo nix-store --optimise -vv";
    bb = "watch cat /sys/class/power_supply/BAT0/capacity"; 
  };

  # List services that you want to enable:
  
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["jayant"];
  hardware.graphics.enable = true; 
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt" ];  
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_full; # Use KVM for better performance
      swtpm.enable = true;     # Enable TPM support (optional)
      ovmf.enable = true;      # Enable UEFI support
      ovmf.packages = [ pkgs.OVMFFull ]; # OVMF for UEFI
    };
  };
 
  services.ollama.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
