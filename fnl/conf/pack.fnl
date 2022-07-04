(import-macros {: pack
                : pack! : unpack!} :themis.pack)

;;; =========================
;;; Configure Package Manager
;;; =========================
; The max_jobs key is set because of wbthomason/packer.nvim#202
(let [packer (require :packer)]
  (packer.init {:max_jobs 50}))

;;; ==========
;;; Essentials
;;; ==========
;; Plugin Manager
(pack! "wbthomason/packer.nvim")
;; Using Fennel to configure neovim
(pack! "rktjmp/hotpot.nvim" {:branch "nightly"})
;; Dynamic LISP evaluation
(pack! "Olical/conjure")
;; Macros
(pack! "datwaft/themis.nvim")

;;; =========
;;; Aesthetic
;;; =========
;; Colorscheme
(pack! "wuelnerdotexe/vim-enfocado" {:as "colorscheme"
                                     :require* "conf.pack.colorscheme"})
;; Statusline
(pack! "nvim-lualine/lualine.nvim" {:require* "conf.pack.lualine"
                                    :requires ["kyazdani42/nvim-web-devicons"]})
;; Treesitter
(pack! "nvim-treesitter/nvim-treesitter" {:run ":TSUpdate"
                                          :require* "conf.pack.treesitter"})
(pack! "p00f/nvim-ts-rainbow" {:requires ["nvim-treesitter/nvim-treesitter"]})
(pack! "nvim-treesitter/nvim-treesitter-refactor" {:requires ["nvim-treesitter/nvim-treesitter"]})
(pack! "JoosepAlviste/nvim-ts-context-commentstring" {:requires ["nvim-treesitter/nvim-treesitter"]})
;; Dim unused variables and functions
(pack! "narutoxy/dim.lua" {:setup* "dim"
                           :requires ["nvim-treesitter/nvim-treesitter"
                                      "neovim/nvim-lspconfig"]})
;; Preview substitution
(pack! "markonm/traces.vim" {:require* "conf.pack.traces"})
;; Color code highlight
(pack! "rrethy/vim-hexokinase" {:run "make hexokinase"
                                :require* "conf.pack.hexokinase"})
;; Indent lines
(pack! "lukas-reineke/indent-blankline.nvim" {:require* "conf.pack.indent-blankline"})
;; Developer icons
(pack! "kyazdani42/nvim-web-devicons" {:require* "conf.pack.devicons"})
;; Highlight matches
(pack! "kevinhwang91/nvim-hlslens" {:require* "conf.pack.hlslens"})

;;; ============
;;; Text objects
;;; ============
;; General
(pack! "wellle/targets.vim")
;; Indent-level text objects
(pack! "michaeljsmith/vim-indent-object")
;; CamelCase text objects
(pack! "bkad/CamelCaseMotion" {:require* "conf.pack.camel-case-motion"})
;; Whitespace text objects
(pack! "vim-utils/vim-space")

;;; =======
;;; Actions
;;; =======
;; Comment
(pack! "numToStr/Comment.nvim" {:setup* "Comment"})
;; Surround
(pack! "machakann/vim-sandwich")
;; Increment and decrement numbers
(pack! "zegervdv/nrpattern.nvim" {:requires ["tpope/vim-repeat"]
                                  :setup* "nrpattern"})

;;; ========
;;; Commands
;;; ========
;; Subversion and Coercion
(pack! "tpope/vim-abolish")
;; Undo-tree
(pack! "mbbill/undotree")
;; Upload to a paste bin
(pack! "rktjmp/paperplanes.nvim" {:require* "conf.pack.paperplanes"})
;; Create snippet
(pack! "ellisonleao/carbon-now.nvim" {:setup* "carbon-now"})

;;; ===========
;;; Enhancement
;;; ===========
;; Conflicts
(pack! "akinsho/git-conflict.nvim" {:require* "conf.pack.git-conflict"})
;; Quickfix
(pack! "kevinhwang91/nvim-bqf")
(pack! "https://gitlab.com/yorickpeterse/nvim-pqf.git" {:setup* "pqf"})
;; Create missing directories on save
(pack! "jghauser/mkdir.nvim" {:require* "mkdir"})
;; Stabilization
(pack! "luukvbaal/stabilize.nvim" {:setup* "stabilize"})
;; Sorting
(pack! "sQVe/sort.nvim" {:setup* "sort"})
;; Folding
(pack! "kevinhwang91/nvim-ufo" {:setup* "ufo"
                                :requires ["kevinhwang91/promise-async"]})

;;; ============
;;; Text Editing
;;; ============
;; Parentheses inference
(pack! "eraserhd/parinfer-rust" {:run "cargo build --release"
                                 :ft conf.lisp-filetypes})
;; ;; Completion
(pack! "hrsh7th/nvim-cmp" {:require* "conf.pack.cmp"})
(pack! "hrsh7th/cmp-nvim-lsp" {:requires ["hrsh7th/nvim-cmp"]})
(pack! "hrsh7th/cmp-buffer" {:requires ["hrsh7th/nvim-cmp"]})
(pack! "hrsh7th/cmp-path" {:requires ["hrsh7th/nvim-cmp"]})
(pack! "andersevenrud/cmp-tmux" {:requires ["hrsh7th/nvim-cmp"]})
(pack! "hrsh7th/cmp-vsnip" {:requires ["hrsh7th/nvim-cmp"
                                       "hrsh7th/vim-vsnip"]})
(pack! "lukas-reineke/cmp-under-comparator" {:requires ["hrsh7th/nvim-cmp"]})
;; Snippets
(pack! "hrsh7th/vim-vsnip" {:require* "conf.pack.vsnip"
                            :requires ["rafamadriz/friendly-snippets"]})
;; Emmet
(pack! "mattn/emmet-vim" {:require* "conf.pack.emmet"})

;;; ===========
;;; Integration
;;; ===========
;; Sudo
(pack! "lambdalisue/suda.vim" {:require* "conf.pack.suda"})
;; Git
(pack! "lewis6991/gitsigns.nvim" {:require* "conf.pack.gitsigns"
                                  :requires ["nvim-lua/plenary.nvim"]})
(pack! "lambdalisue/gina.vim")
;; TMUX
(pack! "aserowy/tmux.nvim" {:require* "conf.pack.tmux"})
;; Conjure with Clj
(pack! "clojure-vim/vim-jack-in" {:requires ["tpope/vim-dispatch"
                                             "radenling/vim-dispatch-neovim"]})

;;; ==========
;;; Filesystem
;;; ==========
;; Fuzzy Finder
(pack! "nvim-telescope/telescope.nvim" {:require* "conf.pack.telescope"
                                        :requires ["nvim-lua/popup.nvim"
                                                   "nvim-lua/plenary.nvim"
                                                   "nvim-telescope/telescope-fzy-native.nvim"
                                                   (pack "nvim-telescope/telescope-smart-history.nvim" {:requires ["tami5/sqlite.lua"]})]})
;; Filesystem editing
(pack! "elihunter173/dirbuf.nvim")

;;; =======
;;; Preview
;;; =======
;; PlantUML
(pack! "weirongxu/plantuml-previewer.vim" {:requires ["tyru/open-browser.vim"]
                                           :ft [:plantuml]})
;; Markdown
(pack! "ellisonleao/glow.nvim" {:ft [:markdown]})

;;; =========
;;; Filetypes
;;; =========
;; Fennel
(pack! "Olical/aniseed")
;; Git
(pack! "tpope/vim-git")
(pack! "gisphm/vim-gitignore")
;; Kitty
(pack! "fladson/vim-kitty")
;; PlantUML
(pack! "aklt/plantuml-syntax")
;; Corpus
(pack! "datwaft/corpus.vim")
;; Tmux
(pack! "tmux-plugins/vim-tmux")
;; Just
(pack! "NoahTheDuke/vim-just")
;; Svelte
(pack! "evanleck/vim-svelte" {:requires ["othree/html5.vim"
                                         "pangloss/vim-javascript"]})
;; Janet
(pack! "bakpakin/janet.vim")

;;; ==============================
;;; Language Server Protocol (LSP)
;;; ==============================
;; Configuration
(pack! "neovim/nvim-lspconfig")
;; Typescript
(pack! "jose-elias-alvarez/typescript.nvim")
;; Lua Neovim Development
(pack! "folke/lua-dev.nvim")
;; SchemaStore
(pack! "b0o/schemastore.nvim")
;; Extensions
(pack! "nvim-lua/lsp_extensions.nvim")
;; Signature
(pack! "ray-x/lsp_signature.nvim")
;; Integrate with non-LSP
(pack! "jose-elias-alvarez/null-ls.nvim" {:require* "conf.pack.null-ls"
                                          :requires ["nvim-lua/plenary.nvim"
                                                     "neovim/nvim-lspconfig"]})
;; Report progress
(pack! "j-hui/fidget.nvim" {:setup* "fidget"})

;;; ==========
(unpack!)
