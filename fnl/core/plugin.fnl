(module core.plugin
  {autoload {packer packer}})

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well.

  This is just a helper / syntax sugar function to make interacting with packer
  a little more concise."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (use (assoc opts 1 name))))))))

(defn- req [name]
  "A shortcut to building a require string for your plugin
  configuration. Intended for use with packer's config or setup
  configuration options. Will prefix the name with `core.plugin.`
  before requiring."
  (.. "require('core.plugin." name "')"))

; Declaration and configuration of the plugins
(use
  ;;; =========
  ;;; Aesthetic
  ;;; =========

  ;; -----------
  ;; Colorscheme
  ;; -----------
  "sainnhe/edge" {:as :colorscheme
                  :config (req :colorscheme)}
  ;; -----------
  ;; Status line
  ;; -----------
  "datwaft/bubbly.nvim" {:as :statusline
                         :config (req :statusline)}

  ;; ---------- 
  ;; Treesitter 
  ;; ---------- 
  "nvim-treesitter/nvim-treesitter" {:as :treesitter
                                     :run ":TSUpdate"
                                     :config (req :treesitter)}
  "nvim-treesitter/nvim-treesitter-refactor" {:requires :treesitter}
  "nvim-treesitter/nvim-treesitter-textobjects" {:requires :treesitter}
  "p00f/nvim-ts-rainbow" {:requires :treesitter}
  "JoosepAlviste/nvim-ts-context-commentstring" {:requires :treesitter}
  "windwp/nvim-ts-autotag" {:requires :treesitter}

  ;; --------------------
  ;; Substitution preview
  ;; --------------------
  "markonm/traces.vim" {:config (req :traces)}

  ;; ---------------
  ;; Color highlight
  ;; ---------------
  "rrethy/vim-hexokinase" {:run "make hexokinase"
                           :config (req :hexokinase)}

  ;; ------------
  ;; Indent lines
  ;; ------------
  "lukas-reineke/indent-blankline.nvim" {:config (req :indent-blankline)}

  ;; ---------------
  ;; Developer icons
  ;; ---------------
  "kyazdani42/nvim-web-devicons" {:config (req :devicons)}

  ;; ----------------------
  ;; Better match highlight
  ;; ----------------------
  "kevinhwang91/nvim-hlslens" {:config (req :hlslens)}

  ;;; ============
  ;;; Text objects
  ;;; ============

  ;; ------------------------
  ;; General-use text objects
  ;; ------------------------
  "wellle/targets.vim" {}

  ;; -----------------------------
  ;; Indentation level text object
  ;; -----------------------------
  "michaeljsmith/vim-indent-object" {}

  ;; ---------------------
  ;; CameCase text objects
  ;; ---------------------
  "bkad/CamelCaseMotion" {:config (req :camel-case-motion)}

  ;; ----------------------
  ;; Whitespace text object
  ;; ----------------------
  "vim-utils/vim-space" {}

  ;;; =======
  ;;; Actions
  ;;; =======

  ;; -------
  ;; Comment
  ;; -------
  "tpope/vim-commentary" {}

  ;; --------
  ;; Surround
  ;; --------
  "machakann/vim-sandwich" {}

  ;; -------------------------------
  ;; Increment and decrement numbers
  ;; -------------------------------
  "zegervdv/nrpattern.nvim" {:config (req :nrpattern)
                             :requires ["tpope/vim-repeat"]}

  ;; -------------------
  ;; Lightspeed movement
  ;; -------------------
  "ggandor/lightspeed.nvim" {:config (req :lightspeed)
                             :requires ["tpope/vim-repeat"]}

  ;;; ========
  ;;; Commands
  ;;; ========

  ;; -----------------------
  ;; Subversion and Coercion
  ;; -----------------------
  "tpope/vim-abolish" {}

  ;; ---------
  ;; Undo tree
  ;; ---------
  "mbbill/undotree" {}

  ;;; ===========
  ;;; Integration
  ;;; ===========

  ;; ---------------
  ;; Git integration
  ;; ---------------
  ; Show changes
  "lewis6991/gitsigns.nvim" {:config (req :gitsigns)
                             :requires ["nvim-lua/plenary.nvim"]}
  ; Execute commands
  "lambdalisue/gina.vim" {}

  ;; ----------------
  ;; Tmux integration
  ;; ----------------
  "aserowy/tmux.nvim" {:config (req :tmux)}

  ;; ---------------
  ;; FZF integration
  ;; ---------------
  "junegunn/fzf" {:run "./install --all"}

  ;; ----------------------------
  ;; Markdown with Pandoc preview
  ;; ----------------------------
  "davidgranstrom/nvim-markdown-preview" {}

  ;; ----------------
  ;; REPL integration
  ;; ----------------
  "jpalardy/vim-slime" {:config (req :slime)}

  ;;; =====================
  ;;; Files and directories
  ;;; =====================

  ;; ------------
  ;; Fuzzy Finder
  ;; ------------
  "nvim-telescope/telescope.nvim" {:config (req :telescope)
                                   :requires ["nvim-lua/popup.nvim"
                                              "nvim-lua/plenary.nvim"]}

  ;; -------------
  ;; File Explorer
  ;; -------------
  "kyazdani42/nvim-tree.lua" {:config (req :file-explorer)}

  ;;; =============
  ;;; Miscellaneous
  ;;; =============

  ;; ---------------
  ;; Window movement
  ;; ---------------
  "https://gitlab.com/yorickpeterse/nvim-window.git" {:config (req :window)}

  ;; ------------
  ;; Better paste
  ;; ------------
  "AckslD/nvim-anywise-reg.lua" {:config (req :anywise-reg)}

  ;; ---------
  ;; Auto save
  ;; ---------
  "Pocco81/AutoSave.nvim" {}

  ;; ----------------------
  ;; Better quickfix window
  ;; ----------------------
  "kevinhwang91/nvim-bqf" {}

  ;; -----------------------------
  ;; Parentheses balance for Lisps
  ;; -----------------------------
  "kovisoft/paredit" {:config (req :paredit)}

  ;;; ==============================
  ;;; Language Server Protocol (LSP)
  ;;; ==============================
  
  ;; -------------
  ;; Configuration
  ;; -------------
  "neovim/nvim-lspconfig" {}

  ;; ------------
  ;; Installation
  ;; ------------
  "anott03/nvim-lspinstall" {}

  ;; ------
  ;; Status
  ;; ------
  "nvim-lua/lsp-status.nvim" {}

  ;; ----------
  ;; Completion
  ;; ----------
  "hrsh7th/nvim-compe" {:as :compe
                        :config (req :compe)}
  ; Conjure source
  "tami5/compe-conjure" {:requires :compe}

  ;; ---------
  ;; Signature
  ;; ---------
  "ray-x/lsp_signature.nvim" {}

  ;; ---------------
  ;; Lua development
  ;; ---------------
  "folke/lua-dev.nvim" {}

  ;; ---------
  ;; Aesthetic
  ;; ---------
  "kosayoda/nvim-lightbulb" {:config (req :lightbulb)}

  ;; -------
  ;; Actions
  ;; -------
  "glepnir/lspsaga.nvim" {:config (req :lspsaga)}
  
  ;; ----------
  ;; Navigation
  ;; ----------
  "ray-x/guihua.lua" {:run "cd lua/fzy && make"}
  "ray-x/navigator.lua" {:config (req :navigator)
                         :requires [:nvim-lspconfig
                                    :guihua.lua]}

  ;;; =========
  ;;; Essential
  ;;; =========

  ;; -------------------------
  ;; Configure Vim with Fennel
  ;; -------------------------
  "Olical/aniseed" {}

  ;; ---------------
  ;; REPL for Fennel
  ;; ---------------
  "Olical/conjure" {}

  ;; --------------
  ;; Plugin manager
  ;; --------------
  "wbthomason/packer.nvim" {})
