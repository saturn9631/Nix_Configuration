## Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking = { 
		networkmanager.enable = true; # Enable networking
		hostName = "ShakarisEyeOfSurveilance"; # Define your hostname.
	};
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	#Filesystem
	boot.tmp.useTmpfs = true;
	#fileSystems."/nix/store" = {
		#device = "/dev/nvme0n1p2";
		#fsType = "ext4";
	#}
	#fileSystems."/home" = {
		#device = "/dev/nvme1n1p1";
		#fsType = "ext4";
	#};

	# Set your time zone.
	time.timeZone = "America/Los_Angeles";

	# Select internationalisation properties.
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
	
	security = {
		#sudo.extraRules = [
			#groups = [ "wheel" ];
			#commands = [{ command = "ALL"; options = ["PASSWD"]; }];
		#];
		polkit = {
			enable = true;
			debug = true;
			#package = pkgs.soteria;
			adminIdentities = [ "unix-group:wheel" "unix-user:saturnfulcrum" "unix-user:root"];
		};
		soteria.enable = true;
		rtkit.enable = true;
	};


	# Desktop
	services.xserver = {
		enable = true;
		#displayManager.lightdm.enable = true;
		#desktopManager.cinnamon.enable = true;
		windowManager.qtile = {
			enable = true;
			extraPackages = python3Packages: with python3Packages; [ qtile-extras ]; #maybe use "qtile start -b wayland"
		};
		#Configure keymap in X11
		xkb = {
			layout = "us";
			variant = "";
		};
		videoDrivers = [ "nvidia" ];
		#Enable touchpad support (enabled default in most desktopManager).
	};
	services.libinput.enable = true;
	#Hardware Setup
	hardware = {
		#opengl = {
			#enable = true;
			#driSupport = true;
		nvidia = {
			open = true;
			#prime = {
				#sync.enabled = true;
				#offload = {
					#enable = true;
					#enableOffloadCmd = true;
				#};
				#nvidiaBusId = "PCI:01:0:0";
				#intelBusId = "PCI:00:02:0";
			};
			#modesetting.enable = true;
			#powerManagement.enable = false;
			#powerManagement.finegrained = false;
			#open = true;
			#nvidiaSettings = true;
		#};
		bluetooth = {
			enable = true;
			powerOnBoot = true;
			#General.Enable = "Source,Sink,Media,Socket";
		};
	};
	services = {
		pulseaudio = {
			enable = false;
			package = pkgs.pulseaudioFull;
		};
		printing.enable = true;
		# Enable CUPS to print documents.
		avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};
		pipewire = {
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
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.root = {
		#group = "root";
		packages = with pkgs; [
		];
	};

	users.users.saturnfulcrum = {
		isNormalUser = true;
		description = "Shakari Wade";
		extraGroups = [ "networkmanager" "wheel" "libvirtd" "lp" ];
		packages = with pkgs; [
			thunderbird
			birdtray
			librewolf
			firefox-devedition
			firefox
			keepassxc
			alacritty
			ardour
			audacity
			vlc
			protonup
			steam
			wine
			bottles
			mangohud
			heroic
			sl
			libreoffice
			inkscape
			godot_4
			blender
			gpick
			geogebra6
			qalculate-gtk

			nb
			nomacs
		];
	};

	# Install firefox.
	#programs.firefox.enable = true;

	# Allow unfree packages

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.permittedInsecurePackages = [ "electron-33.4.11" ];
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = [];
	environment.systemPackages = with pkgs; [
		#Window Manager Tool
		rofi
		brightnessctl
		alsa-utils
		fuse
		simple-mtpfs
		android-file-transfer
		spaceFM

		#System Services
		clamav
		clamtk

		#Virtualization
		qemu
		qemu_kvm
		#qemu_full
		OVMFFull
		virt-manager
		libvirt
		#iproute2/bridge-utils #For using networking in qemu vm
		docker
		kubernetes
		podman
		#distrobox

		#Bash Tools
		home-manager
		neovim
		wget
		curl
		gnutar
		zip
		unzip
		gzip
		gnumake
		cmake
		git
		gitg
		tmux
		ncdu
		nushell
		gparted
		htop
		nvtopPackages.full
		powertop
		btop
		bat
		eza
		tldr
		ripgrep
		ripgrep-all
		fselect
		hardinfo2
		fastfetch
		w3m
		ranger
		yazi
		fzf
		nmap
		ffmpeg
		mdcat
		rink
		kalker
		paging-calculator
		taskwarrior3
		hexcurse
		#srccpy
		pciutils
		wl-clipboard
		wl-clipboard-x11
		clipboard-jh
		wiki-tui

		#Languages
		ghidra
		nasm
		glibc
		gcc
		binutils
		libgccjit
		libgcc
		gdb
		clang_14
		libclang
		llvm-manpages
		llvm_18
		libllvm
		rustup
		cargo
		rustc
		cargo-binutils
		cargo-llvm-cov #5 previous are for rust
		python311Full
		python311Packages.pip
		python311Packages.cython
		python311Packages.virtualenv
		python311Packages.ipython
		haskell.compiler.native-bignum.ghc984
		perl
		go
		zig
		erlang
		sbcl
		bend
		nodejs_24 #neovim plugin dependency
		jdk24 #libreoffice dependency
		scala
		postgresql
		cudaPackages.cudatoolkit
		cdk
		glade
		qtcreator
		

		#Shared Programs
		system-config-printer
		#clipboard-jh
		ollama-cuda
	];

	#Some programs need SUID wrappers, can be configured further or are
	#started in user sessions.
	#programs.mtr.enable = true;
	#programs.gnupg.agent = {
	       # enable = true;
	       # enableSSHSupport = true;
	#};

	#Steam Setup
	programs.steam = {
		enable = true;
		gamescopeSession.enable = true;
	};
	programs.gamemode.enable = true;

	#Services/Daemons
	virtualisation.libvirtd.enable = true;
	programs.virt-manager.enable = true;


	#services.mysql = {
		#enable = true;
		#package = pkgs.mariadb;
	#};
	#config.services.postgresql = {
		#enable = true;
		#identMap = ''
		#'';
	#};

	systemd.services = {
		clamd = {
			description = "ClamAV Daemon";
			after = [ "network.target" ];
			wantedBy = [ "multi-user.target" ];
			serviceConfig = {
				ExecStart = "${pkgs.clamav}/bin/clamd --foreground=yes";
				Restart = "on-failure";
				User = "clamav";
				Group = "clamav";
				PrivateTmp = true;
				RuntimeDirectory = "clamav";
				RunetimeDirectoryMode = "0755";
			};
		};
		freshclam = {
			description = "Clam Update";
			after = [ "network.target" ];
			wantedBy = [ "multi-user.target" ];
			serviceConfig = {
				ExecStart = "${pkgs.clamav}/bin/clamd --foreground=yes";
				Restart = "on-failure";
				User = "clamav";
				Group = "clamav";
				PrivateTmp = true;
				RuntimeDirectory = "clamav";
				RunetimeDirectoryMode = "0755";
			};
		};
	};

	systemd.user.services.mpris-proxy = {
		description = "Mpris proxy";
		after = [ "network.target" "sound.target" ];
		wantedBy = [ "default.target" ];
		serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
	};

	users.users.clamav = {
		isNormalUser = false;
		isSystemUser = true;
		group = "clamav";
	};

	users.groups.clamav = {};

	#Enable the OpenSSH daemon.
	#services.openssh.enable = true;

	#Open ports in the firewall.
	#networking.firewall.allowedTCPPorts = [ ... ];
	#networking.firewall.allowedUDPPorts = [ ... ];
	#Or disable the firewall altogether.
	#networking.firewall.enable = false;

	#This value determines the NixOS release from which the default
	#settings for stateful data, like file locations and database versions
	#on your system were taken. It‘s perfectly fine and recommended to leave
	#this value at the release version of the first install of this system.
	#Before changing this value read the documentation for this option
	#(e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.05"; # Did you read the comment?
}
