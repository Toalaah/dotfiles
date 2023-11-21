{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.lua) rawLua luaFile;
  nnmap = lib.vim.nnoremap;
  nmap = lib.vim.nmap;
in {
  imports = [./common];

  # treesitter
  treesitter = {
    enable = true;
    parsers = ["query" "bash" "markdown" "markdown_inline"];
    opts = {
      auto_install = false;
      highlight.enable = true;
      incremental_selection.enable = true;
      incremental_selection.keymaps = {
        init_selection = "<CR>";
        node_incremental = "<CR>";
        node_decremental = "<BS>";
      };
    };
    extensions.textobjects = {
      src = pkgs.fetchFromGitHub {
        owner = "nvim-treesitter";
        repo = "nvim-treesitter-textobjects";
        rev = "9e519b6146512c8e2e702faf8ac48420f4f5deec";
        sha256 = "sha256-6TLtXRBYCianxn1j+WkcD7EpBYsGC4bTjYrcmaaXTas=";
      };
      opts.select.enable = true;
    };
  };

  # editor
  editor.better-escape.enable = true;
  editor.better-escape.opts.mapping = ["jj" "jk" "kj"];
  editor.comment.enable = true;
  editor.conform.enable = true;

  editor.conform.opts.formatters_by_ft = {
    lua = ["stylua"];
  };

  # statusline
  ui.express-line.enable = true;

  # tools / miscellaneous
  tools.markdown-preview.enable = true;
  tools.clipboard-image.enable = true;
  tools.mini-ai.enable = true;
  tools.mini-pairs.enable = true;
  tools.nvim-surround.enable = true;
  tools.schemastore.enable = true;
  tools.vim-cool.enable = true;
  tools.which-key.enable = true;
  tools.which-key.opts.plugins.spelling = true;
  tools.oil = {
    enable = true;
    keys = [(nnmap "<leader><leader>" "<cmd>Oil<cr>" {desc = "Open file explorer";})];
    opts = {
      keymaps."q" = "actions.close";
      viewoptions.show_hidden = true;
    };
  };

  tools.toggleterm = {
    enable = true;
    keys = [
      (nnmap "<leader>tt" "<cmd>ToggleTerm<cr>" {desc = "Open terminal (vertical)";})
      (nnmap "<leader>tf" "<cmd>ToggleTerm direction=float<cr>" {desc = "Open terminal (floating)";})
      (nnmap "<leader>tv" "<cmd>ToggleTerm direction=vertical<cr>" {desc = "Open terminal (vertical)";})
    ];
  };

  # colorschemes
  colorschemes.gruvbox.enable = true;
  postHooks = ''
    vim.cmd.colorscheme "gruvbox"
  '';

  # git integration
  git.gitsigns.enable = true;
  git.gitsigns.opts = {
    on_attach = luaFile ./gitsigns_on_attach.lua;
    current_line_blame = true;
    current_line_blame_opts.delay = 500;
  };
  git.committia.enable = true;
  git.fugitive.enable = true;

  # language / lsp support
  lsp.lsp-config.enable = true;
  lsp.lsp-config.onAttach = builtins.readFile ./lsp_on_attach.lua;
  lsp.lsp-config.src = pkgs.fetchFromGitHub {
    owner = "neovim";
    repo = "nvim-lspconfig";
    rev = "8f3ddc448769f563248654a5099c943c7139137e";
    sha256 = "1719sbp9w70d6fngmfxrw3bp8ix4icz857f2ba7ig8zfbzbdi4xw";
  };
  lsp.snippets.enable = true;
  lsp.snippets.keys = (import ./lspKeys.nix {inherit lib;}).completion;
  lsp.completion.enable = true;
  lsp.completion.sources.nvim_lsp.opts = {
    max_item_count = 10;
    priority = 20;
  };
  lsp.completion.opts.experimental.ghost_text.hl_group = "Comment";
  lsp.completion.opts.window = {
    completion =
      rawLua
      /*
      lua
      */
      "cmp.config.window.bordered()";
    documentation =
      rawLua
      /*
      lua
      */
      "cmp.config.window.bordered()";
  };
  lsp.completion.opts.mapping =
    rawLua
    /*
    lua
    */
    ''
      cmp.mapping.preset.insert({
        ["<C-L>"] = cmp.mapping.confirm({ select = false }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false, }),
      })
    '';
  lsp.completion.sources = {
    buffer = {
      opts.keyword_length = 5;
      opts.max_item_count = 5;
      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "cmp-buffer";
        rev = "3022dbc9166796b644a841a02de8dd1cc1d311fa";
        sha256 = "sha256-dG4U7MtnXThoa/PD+qFtCt76MQ14V1wX8GMYcvxEnbM=";
      };
    };
    path = {
      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "cmp-path";
        rev = "91ff86cd9c29299a64f968ebb45846c485725f23";
        sha256 = "sha256-thppiiV3wjIaZnAXmsh7j3DUc6ceSCvGzviwFUnoPaI=";
      };
    };
  };
  lsp.nvim-dap.enable = true;
  languages.lua.enable = true;
  languages.java.enable = true;
  languages.python.enable = true;
  languages.c.enable = true;
  languages.terraform.enable = true;
  languages.terraform.settings = {};
  languages.rust.enable = true;
  languages.yaml.enable = true;
  languages.go.enable = true;
  languages.nix.enable = true;

  # telescope
  telescope = {
    enable = true;
    opts.pickers.find_files.find_command = [
      "rg"
      "--color=never"
      "--column"
      "--no-heading"
      "--hidden"
      "--no-ignore"
      "--files"
    ];
    keys = [
      {
        lhs = "<C-p>";
        rhs = "<cmd>Telescope find_files<cr>";
        desc = "Find Files";
      }
      {
        lhs = "<leader>ff";
        rhs = "<cmd>Telescope live_grep<cr>";
        desc = "Search";
      }
      {
        lhs = "<leader>b";
        rhs = "<cmd>Telescope buffers<cr>";
        desc = "Search [b]uffers";
      }
    ];
  };
  telescope.extensions.fzf = {
    opts.override_file_sorter = true;
    src =
      pkgs.vimPlugins.telescope-fzf-native-nvim
      // {
        owner = "nvim-telescope";
        repo = "fzf-native.nvim";
      };
  };

  # navigation
  tools.nvim-tmux-navigation.enable = true; # requires additional setup on tmux side
  tools.nvim-tmux-navigation.keys = [
    (nmap "<C-H>" "<cmd>NvimTmuxNavigateLeft<cr>" {desc = "Navigate left";})
    (nmap "<C-J>" "<cmd>NvimTmuxNavigateDown<cr>" {desc = "Navigate down";})
    (nmap "<C-K>" "<cmd>NvimTmuxNavigateUp<cr>" {desc = "Navigate up";})
    (nmap "<C-L>" "<cmd>NvimTmuxNavigateRight<cr>" {desc = "Navigate right";})
  ];
  tools.harpoon.enable = true;
  tools.harpoon.keys = let
    mkIndexKeymap = i: let
      i' = builtins.toString i;
    in {
      lhs = "<leader>${i'}";
      rhs = "<cmd>lua require('harpoon.ui').nav_file(${i'})<cr>";
      desc = "Navigate to harpoon file ${i'}";
    };
  in
    [
      (nnmap "<leader>m" "<cmd>lua require('harpoon.mark').add_file()<cr>" {desc = "[M]ark file";})
      (nnmap "<leader>h" "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" {desc = "[O]pen harpoon menu";})
      (nnmap "<M-k>" "<cmd>lua require('harpoon.ui').nav_prev()<cr>" {desc = "Navigate to previous file";})
      (nnmap "<M-j>" "<cmd>lua require('harpoon.ui').nav_next()<cr>" {desc = "Navigate to next file";})
    ]
    ++ builtins.map
    mkIndexKeymap
    (lib.lists.range 1 5);
}
