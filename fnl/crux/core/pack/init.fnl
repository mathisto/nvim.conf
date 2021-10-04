(import-macros {: pack
                : pack!
                : rock!
                : unpack!} :crux.lib.macro.pack)

;;; Essential
;; Plugin Manager
(pack! "wbthomason/packer.nvim")
;; Using Fennel for configuration
(pack! "rktjmp/hotpot.nvim")
;; Regex PCRE2 Library
(rock! "lrexlib-pcre2")

;;; Aesthetic
;; Colorscheme
(pack! "Pocco81/Catppuccino.nvim" {:as "colorscheme"
                                   :req "colorscheme"})
;; Treesitter
(pack! "nvim-treesitter/nvim-treesitter" {:run ":TSUpdate"
                                          :req "treesitter"
                                          :requires ["p00f/nvim-ts-rainbow"
                                                     "nvim-treesitter/nvim-treesitter-refactor"
                                                     "JoosepAlviste/nvim-ts-context-commentstring"]})
;; Preview substitution
(pack! "markonm/traces.vim")
;; Color codes highlight
(pack! "rrethy/vim-hexokinase" {:run "make hexokinase"
                                :req "hexokinase"})
;; Indent lines
(pack! "lukas-reineke/indent-blankline.nvim" {:req "indent-blankline"})
;; Developer icons
(pack! "kyazdani42/nvim-web-devicons" {:req "devicons"})
;; Highlight matches
(pack! "kevinhwang91/nvim-hlslens" {:req "hlslens"})

;;; Text objects
;; Intent-level text object
(pack! "michaeljsmith/vim-indent-object")
;; CamelCase text objects
(pack! "bkad/CamelCaseMotion" {:req "camel-case-motion"})
;; Whitespace text objects
(pack! "vim-utils/vim-space")

;;; Actions
;; Comment
(pack! "tpope/vim-commentary")
;; Surround
(pack! "machakann/vim-sandwich")
;; Increment and decrement numbers
(pack! "zegervdv/nrpattern.nvim" {:requires ["tpope/vim-repeat"]
                                  :init "nrpattern"})

;;; Commands
;; Subversion and Coercion
(pack! "tpope/vim-abolish")
;; Undo-tree
(pack! "mbbill/undotree")

;;; Enhancement
;; Quickfix
(pack! "kevinhwang91/nvim-bqf")
;; Mapping
(pack! "folke/which-key.nvim" {:req "which-key"})
;; Wildmenu
(pack! "gelguy/wilder.nvim" {:run ":UpdateRemotePlugins"
                             :req "wilder"})

;;; Text Editing
;; Parentheses Inference
(pack! "eraserhd/parinfer-rust" {:run "cargo build --release"
                                 :ft [:fennel :clojure :lisp]})
;; Completion
(pack! "hrsh7th/nvim-cmp" {:req "cmp"
                           :requires ["hrsh7th/cmp-buffer"
                                      "hrsh7th/cmp-nvim-lsp"
                                      (pack "hrsh7th/cmp-vsnip" {:requires "hrsh7th/vim-vsnip"})]})

;;; REPL
;; Lisp REPL
(pack! "Olical/conjure" {:req "conjure"
                         :ft [:fennel :clojure :lisp]})

;;; Integration
;; Git
(pack! "lewis6991/gitsigns.nvim" {:init "gitsigns"
                                  :requires ["nvim-lua/plenary.nvim"]})
(pack! "lambdalisue/gina.vim")
;; Tmux
(pack! "aserowy/tmux.nvim" {:req "tmux"})

;;; Files and directories
;; Fuzzy Finder
(pack! "nvim-telescope/telescope.nvim" {:req "telescope"
                                        :requires ["nvim-lua/popup.nvim"
                                                   "nvim-lua/plenary.nvim"
                                                   "nvim-telescope/telescope-fzy-native.nvim"]})
;; File explorer
(pack! "kyazdani42/nvim-tree.lua" {:as "file-explorer"
                                   :req "file-explorer"})

;;; Language Server Protocol (LSP)
;; Configuration
(pack! "neovim/nvim-lspconfig")
;; Lua Neovim Development
(pack! "folke/lua-dev.nvim")

;;; Filetypes
;; Fennel
(pack! "bakpakin/fennel.vim" {:ft [:fennel]})
;; Dockerfile
(pack! "ekalinin/Dockerfile.vim" {:ft [:Dockerfile :dockerfile]})

;;; --------------------

; Initialize declared plugins
(unpack!)