{ config, pkgs, inputs, ... }:
{
  #Important system setup
  imports = 
  [ ./hardware-configuration.nix ]; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8 * 1000;
  } ];


  #Network setup
  networking.hostName = "shakarisviewerofcarnage";
  networking.networkmanager.enable = true;

  #Time and location setup
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  #Security Setup
  security = {
    sudo.extraRules = [
      {
        groups = ["wheel"];
        commands = [{ command = "ALL"; options = ["PASSWD"];}];
      }
    ];
    polkit = {
      enable = true;
   #   extraConfig = ''
   #   '';
    };
  };

  #Desktop Setup
  services.xserver = {
    enable = true;
    displayManager = {

      sddm = {
        enable = false;
      };

      lightdm = {
        enable = true;
        #extraConfig = ''
          #logind-check-graphical = true
        #'';
      };
    };
    desktopManager = {
      #gnome.enable = true;
      plasma5.enable = true;
      xfce.enable = true;
      cinnamon.enable = false;
    };
    windowManager.qtile.enable = true;
    #layout = "us";
    #xkbVariant = "";
  };
  
  environment.sessionVariables = {
    WL_NO_HARDWARE_CURSOR = "1";
    NIXOS_OZONE_WL = "1";
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  #I/O and Driver Setup
  hardware.opengl = {
    enable = true;
    driSupport = true;
    #driSupport32bit = true;
  };
  #services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio = {
      enable = false;
    };
  };
  services.printing.enable = true;
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  #services.xserver.libinput.enable = true;

  #User Setup
  users.users.saturnfulcrum = {
    isNormalUser = true;
   description = "Shakari Wade";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox-devedition
      librewolf
      thunderbird
      birdtray
      keepassxc
      libreoffice
      godot_4
      gimp
      audacity
      blender
      openrgb
      steam
      vlc
      nushell
    ];
  };

  
  #users.users.family = {
  #  isNormalUser = true;
  #  description = "Family member use.";
  #  packages = with pkgs; [
  #    chrome
  #    libreoffice
  #    vlc
  #    steam
  #    gimp
  #  ]
  #}
  
  #Packages Setup
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    #Desktop Environment tools
    polkit_gnome #Ensure that polkit is installed
    blueman
    bluez
    bluez-alsa
    lightdm
    rofi
    brightnessctl


    #Bash Tools
    home-manager
    nix-output-monitor
    nvd
    alacritty
    kitty
    git
    gitg
    neovim
    fzf
    wget
    curl
    gnutar
    zip
    unzip
    gzip
    python311Packages.cmake
    #neovim-gtk
    clipboard-jh
    #neovim-qt
    #flatpak
    #flatpak-builder
    distrobox
    podman
    docker
    htop
    btop
    bat
    eza
    tldr
    #neofetch
    ranger
    w3m
    links2
    hardinfo
    qtcreator
    glade
    tmux
    clamav
    clamtk
    clamsmtp
    openssl_3_1
    hollywood
    ffmpeg_4-full
    nmap
    ncdu
    thefuck
    powertop
    #scrcpy
    
    #Programming Languages
    libgccjit
    gcc9
    binutils
    libllvm
    clang_17
    llvm-manpages
    rustc
    cargo
    python3Full
    python311Packages.cython_3
    python311Packages.pip
    python311Packages.virtualenv
    jupyter-all
    haskell.compiler.native-bignum.ghc981
    go
    luajit_openresty
    luajitPackages.luarocks
    jdk21
    clojure
    perl
    nodejs_21
    ruby
    R
    julia_18
    cmucl_binary #common-lisp
    mysql80
    dgraph
    erlang
    rabbitmq-server
    gleam
    
    #User Shared Programs
    #gnome.gnome-tweaks

  ];
  
  
  system.stateVersion = "24.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #Services and Daemon Setup
  #services.openssh.enable = true;
  #services.flatpak.enable = true;
  services.blueman.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];


  #Notes:
}
