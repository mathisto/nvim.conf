(import-macros {: as->} :core.macro.core)

(local {: inc
        : empty?
        : nil?
        : mapv
        : conj
        :some some?} (require :cljlib))
(local {: ->str} (require :core.utils.core))
(local {: fn?} (require :core.macro.utils))
(local rex ((require :rex_pcre2)))

(global core/id 0)
(fn core/gensym []
  "Generates a new symbol to use as a global variable name.
  The returned symbol follows the structure '__core_%d_' where `%d` is the
  symbol number"
  (global core/id (inc core/id))
  (sym (string.format "__core_%d_" core/id)))

(fn vlua [symbol]
  "Returns a symbol mapped to `v:lua.%s()` where %s is the symbol"
  (.. "v:lua." (->str symbol) "()"))

(fn set! [...]
  "Set one or multiple vim options using the `vim.opt` API.
  The name of the option must be a symbol.
  If the option doesn't have a value, if it begins with 'no' the value becomes
  false, and true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (fn set!/expr [name ?value]
    (let [name (->str name)
          value (or ?value (not (rex.match name "^no")))
          name (rex.match name "^(?:no)?(.+)$")]
      (if (fn? value)
        (let [fsym (core/gensym)]
          `(do
             (global ,fsym ,value)
             (tset vim.opt ,name ,(vlua fsym))))
        (match (name:sub -1)
          :+ `(: (. vim.opt ,(name:sub 1 -2)) :append ,value)
          :- `(: (. vim.opt ,(name:sub 1 -2)) :remove ,value)
          :^ `(: (. vim.opt ,(name:sub 1 -2)) :prepend ,value)
          _ `(tset vim.opt ,name ,value)))))
  (fn set!/exprs [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value))) [(set!/expr name value)
                                                      (unpack (set!/exprs (unpack rest)))]
      [name & rest] [(set!/expr name)
                     (unpack (set!/exprs (unpack rest)))]
      _ []))
  (let [exprs (set!/exprs ...)]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

(fn bufset! [...]
  "Set one or multiple vim options using the `vim.opt_local` API.
  The name of the option must be a symbol.
  If the option doesn't have a value, if it begins with 'no' the value becomes
  false, and true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (fn bufset!/expr [name ?value]
    (let [name (->str name)
          value (or ?value (not (rex.match name "^no")))
          name (rex.match name "^(?:no)?(\\w+)$")]
      (if (fn? value)
        (let [fsym (core/gensym)]
          `(do
             (global ,fsym ,value)
             (tset vim.opt_local ,name ,(vlua fsym))))
        (match (name:sub -1)
          :+ `(: (. vim.opt_local ,(name:sub -1 -2)) :append ,value)
          :- `(: (. vim.opt_local ,(name:sub -1 -2)) :remove ,value)
          :^ `(: (. vim.opt_local ,(name:sub -1 -2)) :prepend ,value)
          _ `(tset vim.opt_local ,name ,value)))))
  (fn bufset!/exprs [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value))) [(bufset!/expr name value)
                                                      (unpack (bufset!/exprs (unpack rest)))]
      [name & rest] [(bufset!/expr name)
                     (unpack (bufset!/exprs (unpack rest)))]
      _ []))
  (let [exprs (bufset!/exprs ...)]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

(fn let! [...]
  "Set a vim variable using the `vim.[gbwt]` API.
  The name can be either a symbol or a string.
  If the name begins with `[gbwt]/`, `[gbwt]:` or `[gbwt].` the
  name is scoped to the respective scope:
  g -> global (default)
  b -> buffer
  w -> window
  t -> tab"
  (fn let!/expr [name value]
    (let [name (->str name)
          scope (when (some? #(= $ (name:sub 1 2)) ["g/" "b/" "w/" "t/"
                                                    "g." "b." "w." "t."
                                                    "g:" "b:" "w:" "t:"])
                  (name:sub 1 1))
          name (if (nil? scope) name (name:sub 3))]
      `(tset ,(match scope
                :b 'vim.b
                :w 'vim.w
                :t 'vim.t
                _ 'vim.g) ,name ,value)))
  (fn let!/exprs [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      [name value & rest] [(let!/expr name value)
                           (unpack (let!/exprs (unpack rest)))]
      _ []))
  (let [exprs (let!/exprs ...)]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

(fn augroup! [name ...]
  "Defines an autocommand group using the `vim.cmd` API"
  `(do
     ,(unpack
        (-> [`(vim.cmd ,(string.format "augroup %s" name))
             `(vim.cmd "autocmd!")]
            (conj ...)
            (conj `(vim.cmd "augroup END"))))))

(fn bufaugroup! [name ...]
  "Defines a buffer-local autocommand group using the `vim.cmd` API"
  `(do
     ,(unpack
        (-> [`(vim.cmd ,(string.format "augroup %s" name))
             `(vim.cmd "autocmd! * <buffer>")]
            (conj ...)
            (conj `(vim.cmd "augroup END"))))))

(fn autocmd! [events pattern command]
  "Defines an autocommand using the `vim.cmd` API"
  (let [events (as-> events $
                     (if (sequence? $) $ [$])
                     (mapv ->str $)
                     (table.concat $ ","))
        pattern (as-> pattern $
                      (if (sequence? $) $ [$])
                      (mapv ->str $)
                      (table.concat $ ","))]
    (if (fn? command)
      (let [fsym (core/gensym)]
        `(do
           (global ,fsym ,command)
           (vim.cmd ,(string.format "autocmd %s %s call %s"
                                    events pattern (vlua fsym)))))
      `(vim.cmd ,(string.format "autocmd %s %s %s"
                                events pattern command)))))

(fn t [combination]
  "Returns the string with the termcodes replaced"
  `(vim.api.nvim_replace_termcodes ,(->str combination) true true true))

(fn colorscheme! [name]
  "Sets a vim colorscheme.
  The name can be either a symbol or a string"
  `(vim.cmd ,(string.format "colorscheme %s" (->str name))))

{: set!
 : bufset!
 : let!
 : augroup!
 : bufaugroup!
 : autocmd!
 : t
 : colorscheme!}
