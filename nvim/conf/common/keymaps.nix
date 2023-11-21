{lib, ...}: let
  inherit (lib.vim) mkKeymap nnoremap inoremap vnoremap;
in {
  keymaps = [
    # various toggles and quick-actions
    (nnoremap "<leader>M" "<Cmd>make<CR>" {desc = "Make";})
    # escape terminal mode
    (mkKeymap "t" "<C-k><C-j>" "<C-\\\\><C-n>")
    # virtual line qol
    (nnoremap "j" "v:count == 0 ? 'gj' : 'j'" {
      desc = "Move down line";
      expr = true;
    })
    (nnoremap "k" "v:count == 0 ? 'gk' : 'k'" {
      desc = "Move up line";
      expr = true;
    })
    (nnoremap "$" "v:count == 0 ? 'g$' : '$'" {
      desc = "Move to end of line";
      expr = true;
    })
    (nnoremap "^" "v:count == 0 ? 'g^' : '^'" {
      desc = "Move to start of line";
      expr = true;
    })
    # center screen between jumps
    (nnoremap "<C-d>" "<C-d>zz" {desc = "Move down half page";})
    (nnoremap "<C-u>" "<C-u>zz" {desc = "Move up half page";})
    (nnoremap "n" "nzz" {desc = "Next match";})
    (nnoremap "N" "Nzz" {desc = "Previous match";})
    # qol bindings
    (nnoremap "Y" "y$" {desc = "Yank to end of line";})
    (vnoremap ">" ">gv" {desc = "Increase indent level";})
    (vnoremap "<" "<gv" {desc = "Decrease indent level";})
    # move lines
    (nnoremap "<A-k>" "<Esc>:m .-2<CR>==" {desc = "Move line up";})
    (nnoremap "<A-j>" "<Esc>:m .+1<CR>==" {desc = "Move line down";})
    (inoremap "<A-k>" "<Esc>:m .-2<CR>==gi" {desc = "Move line up";})
    (inoremap "<A-j>" "<Esc>:m .+1<CR>==gi" {desc = "Move line down";})
    (vnoremap "<A-j>" ":m '>+1<CR>gv=gv" {desc = "Move line up";})
    (vnoremap "<A-k>" ":m '<-2<CR>gv=gv" {desc = "Move line down";})
    # move between splits
    (nnoremap "<C-h>" "<C-w>h" {desc = "Move to left split";})
    (nnoremap "<C-j>" "<C-w>j" {desc = "Move to bottom split";})
    (nnoremap "<C-k>" "<C-w>k" {desc = "Move to upper split";})
    (nnoremap "<C-l>" "<C-w>l" {desc = "Move to right split";})
  ];
}
