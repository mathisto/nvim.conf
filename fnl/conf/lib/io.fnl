(lambda echo! [msg]
  "Print a vim message without any format."
  (vim.notify msg vim.log.levels.INFO))

(lambda warn! [msg]
  "Print a vim message with a warning format."
  (vim.notify msg vim.log.levels.WARN))

(lambda err! [msg]
  "Print a vim message with an error format."
  (vim.notify msg vim.log.levels.ERROR))

{: echo!
 : warn!
 : err!}
