(import-macros {: let!} :themis.var)
(import-macros {: set!} :themis.opt)
(import-macros {: augroup! : autocmd! : clear!} :themis.event)
(import-macros {: highlight!} :themis.highlight)

(let! [g] tokyodark_transparent_background true
          tokyodark_enable_italic_comment true
          tokyodark_enable_italic false
          tokyodark_color_gamma "5.0")
(vim.cmd.colorscheme "tokyodark")
