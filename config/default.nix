{
  # Import all your configuration modules here
  imports = [ ./bufferline.nix ];

  colorschemes.tokyonight.enable = true;

  plugins.lualine.enable = true;
  plugins.godot.enable = true;
  plugins.lazy.enable = true;
  plugins.neoscroll.enable = true;
  plugins.fzf-lua.enable = true;
  plugins.nix.enable = true;
  plugins.nix-develop.enable = true;
  plugins.dap.enable = true;

  plugins.nvim-tree = {
    enable = true;
    openOnSetup = true;
    openOnSetupFile = true;
  };

  plugins.noice = {
    enable = true;
    popupmenu.enabled = true;
  };

  plugins.cmake-tools = {
    enable = true;
    settings = {
      cmake_build_directory = "build/${variant:buildtype}";
      cmake_dap_configuration = {
        cwd = "\${workspaceFolder}";
        name = "Launch file";
        program = {
          __raw = ''
            function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end
          '';
        };
        request = "launch";
        stopOnEntry = false;
        type = "codelldb";
      };
      cmake_executor = {
        name = "toggleterm";  # Use toggleterm for executing CMake commands within Neovim
      };
      cmake_notifications = {
        refresh_rate_ms = 80;
        spinner = [
          "▱▱▱▱▱▱▱"
          "▰▱▱▱▱▱▱"
          "▰▰▱▱▱▱▱"
          "▰▰▰▱▱▱▱"
          "▰▰▰▰▱▱▱"
          "▰▰▰▰▰▱▱"
          "▰▰▰▰▰▰▱"
          "▰▰▰▰▰▰▰"
        ];
      };
      cmake_regenerate_on_save = false;
      cmake_runner = {
        name = "toggleterm";
      };
      cmake_soft_link_compile_commands = false;
    };
  };

  plugins.telescope = {
    enable = true;
    settings = {
      defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];
        layout_config = {
          prompt_position = "top";
        };
        mappings = {
          i = {
            "<A-j>" = {
              __raw = "require('telescope.actions').move_selection_next";
            };
            "<A-k>" = {
              __raw = "require('telescope.actions').move_selection_previous";
            };
          };
        };
        selection_caret = "> ";
        set_env = {
          COLORTERM = "truecolor";
        };
        sorting_strategy = "ascending";
      };
    };
  };

  plugins.dashboard = {
    enable = true;
    settings = {
      change_to_vcs_root = true;
      config = {
        footer = [
          "Made with ❤️"
        ];
        header = [
          "Your Custom Header Here"
        ];
        mru = {
          limit = 20;
        };
        project = {
          enable = true;
        };
        shortcut = [
          {
            action = {
              __raw = "function(path) vim.cmd('Telescope find_files') end";
            };
            desc = "Files";
            group = "Label";
            icon = " ";
            icon_hl = "@variable";
            key = "f";
          }
          {
            action = "Telescope app";
            desc = " Apps";
            group = "DiagnosticHint";
            key = "a";
          }
          {
            action = "Telescope dotfiles";
            desc = " dotfiles";
            group = "Number";
            key = "d";
          }
        ];
        week_header = {
          enable = false;
        };
      };
      theme = "hyper";
    };
  };

  plugins.lsp = {
    enable = true;
    servers = {
      csharp-ls.enable = true;
      cmake.enable = true;
      clangd.enable = true;
      gdscript.enable = true;
      nixd.enable = true;
      lua-ls.enable = true;
    };
  };

  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };

      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
        {name = "luasnip";}
      ];
    };
  };

  plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "float";
      float_opts = {
        border = "curved";
        height = 30;
        width = 130;
      };
      open_mapping = "[[<c->]]";
    };
  };
}
