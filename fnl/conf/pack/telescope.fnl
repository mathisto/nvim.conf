(import-macros {: map!} :themis.keybind)

(local {: setup
        : load_extension} (require :telescope))
(local actions (require :telescope.actions))
(local {:find_files find-files!
        :live_grep live-grep!
        :buffers buffers!
        :help_tags help-tags!
        :quickfix quickfix!
        :loclist loclist!} (require :telescope.builtin))
(local {: mkdir
        : expand} vim.fn)

;; Search file by name
(map! [n] "<leader>ff" find-files!)

;; Search file by content
(map! [n] "<leader>fg" live-grep!)

;; Search buffer list
(map! [n] "<leader>fb" buffers!)

;; Search help tags
(map! [n] "<leader>fh" help-tags!)

;; Search quickfix list
(map! [n] "<leader>fq" quickfix!)

;; Search location list
(map! [n] "<leader>fk" loclist!)

;; Configure telescope
(setup {:defaults {:mappings {:i {"<C-h>" actions.which_key
                                  "<ESC>" actions.close
                                  "<C-q>" actions.smart_send_to_qflist
                                  "<C-k>" actions.smart_send_to_loclist
                                  "<C-Up>" actions.cycle_history_prev
                                  "<C-Down>" actions.cycle_history_next}}
                   :history {:path (.. conf.databases-folder "/telescope_history.sqlite3")
                             :limit 100}
                   :prompt_prefix "   "
                   :selection_caret "  "
                   :layout_config {:horizontal {:prompt_position "top"
                                                :preview_width 0.55
                                                :results_width 0.8}
                                   :vertical {:mirror false}
                                   :width 0.87
                                   :height 0.80
                                   :preview_cutoff 120}
                   :sorting_strategy "ascending"}})
(load_extension :fzy_native)
(load_extension :smart_history)
