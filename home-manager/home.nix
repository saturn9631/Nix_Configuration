{ config, pkgs, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readfile file}\nEOF\n";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "saturnfulcrum";
  home.homeDirectory = "/home/saturnfulcrum";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/init.lua}
    '';
    
    plugins = with pkgs.vimPlugins; [
    
    #launguge editing plugins
     
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-lua
        ]));
        config = toLua "require(\"nvim-treesitter.configs\").setup()";
      }

      {
        plugin = nvim-lspconfig;
        config = toLua "require(\"lspconfig\").setup()";
      }

      {
        plugin = mason-lspconfig-nvim;
        config = toLua "require(\"mason-lspconfig\").setup()";
      }
    
      {
        plugin = none-ls-nvim;
        config = toLua "require(\"null-ls\").setup()";
      }
      {
        plugin = nvim-dap;
        config = toLua "require(\"dap\").setup()";
      }
      {
        plugin = nvim-dap-ui;
        config = toLua "require(\"dapui\").setup()";
      }
      {
        plugin = luasnip;
        config = toLua "require(\"luasnip\").setup()";
      }
      {
        plugin = cmp_luasnip;
        config = toLua "require(\"cmp_luasnip\").setup()";
      }
      {
        plugin = friendly-snippets;
        config = toLua "require(\"friendly-snippets\").setup()";
      }
      {
        plugin = nvim-cmp;
        config = toLua "require(\"cmp\").setup()";
      }
      {
        plugin = cmp-nvim-lsp;
        config = toLua "require(\"cmp\").setup()";
      }
    
    #assitant plugins
      {
        plugin = telescope-nvim;
        config = toLua "require(\"telescope\").setup()";
      }
      {
        plugin = plenary-nvim;
        #config = toLua "require(\"plenary\").setup()";
      }
      {
        plugin = telescope-fzf-naive-nvim;
        #config = toLua "require(\"\").setup()";
      }
      {
        plugin = neo-tree-nvim;
        config = toLua "require(\"neo-tree\").setup()";
      }
      {
        plugin = nvim-web-devicons;
        #config = toLua "require(\"\").setup()";
      }
      {
        plugin = nui-nvim;
        #config = toLua "require(\"\").setup()";
      }
      {
        plugin = telescope-ui-select-nvim;
        config = toLua "require(\"\").setup()";
      }

    #appearence plugins
      {
        plugin = onedark-nvim;
        config = toLua "require(\"\").setup()";
      }
      {
        plugin = lualine-nvim;
        config = toLua "require(\"\").setup()";
      }
    ];
  };
  

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/saturnfulcrum/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
