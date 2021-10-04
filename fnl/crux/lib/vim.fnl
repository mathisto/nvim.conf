(fn cmd! [s]
  "Execute ex command and capture the output."
  (vim.cmd s))

(fn extcmd! [s]
  "Execute external command and capture the output."
  (let [output (vim.fn.system s)]
    (if (not= output "") (output:sub 1 -2)
      nil)))

(fn ui? []
  (not= 0 (length (vim.api.nvim_list_uis))))

(fn has? [property]
  "Returns if vim has a property"
  (match (vim.fn.has property)
    1 true
    0 false
    _ nil))

{: cmd!
 : extcmd!
 : ui?
 : has?}