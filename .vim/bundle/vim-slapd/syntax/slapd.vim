" Vim syntax file
" Language: slapd.conf (OpenLDAP) configuration file
" Maintainer: Stanislaw Klekot <vim@jarowit.net>
" Last Change: 2012-02-01
" TODO:
"   - richer syntax highlighting for casual slapd.conf (non-schema directives,
"     like rootdn, suffix, index, directory or dbconfig)
"   - special syntax after "backend" keyword
"   - special syntax after "overlay" keyword
"   - syntax for "limit", "ldapsyntax" and "ditcontentrule"
"   - more consistent highlighting for schema definitions

" My syntax detection propsal:
"   au BufRead,BufNewFile /etc/*ldap*/*.schema,/etc/*ldap*/*.conf
"         \ set filetype=slapd

"-----------------------------------------------------------------------------
" setup {{{

if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif

syn case match
setlocal iskeyword=a-z,A-Z,48-57,45,

" }}}
"-----------------------------------------------------------------------------
" general directives {{{

syn match slComment "^\s*#.*"
syn match slString contained /\S\+/
syn match slString contained /"\([^"]\|\\.\)\*"/

" NOTE: top-level directives are case-insensitive
syn match  slOption contained "^\k\+"
syn region slDirective start="^\k" skip="\n\s" end="\n" contains=slOption,slString
syn region slIncludeDirective matchgroup=slPreProc start="^include\s"he=e-1 end="$"

" }}}
"-----------------------------------------------------------------------------
" "access to" directives {{{

syn region  slAccessDirective start="^access\s\+to\>" skip="\n\s" end="\n" keepend contains=slAccessOption,slAccessSpec
syn match   slAccessOption contained "^access\s\+to\>" nextgroup=slAccessToWhat skipwhite skipnl skipempty
syn region  slAccessSpec   contained start="by" skip="\n\s" end="\n" contains=slAccessWho,slAccessPerm

syn match   slAccessToWhat contained "dn\(\.[a-z]\+\)\?="he=e-1 nextgroup=slString
syn match   slAccessToWhat contained "filter="he=e-1            nextgroup=slString
syn match   slAccessToWhat contained "attrs="he=e-1             nextgroup=slString
syn match   slAccessToWhat contained "\*"

syn keyword slAccessWho contained self realself
syn keyword slAccessWho contained anonymous realanonymous
syn keyword slAccessWho contained users realusers
syn match   slAccessWho contained "\*"
syn match   slAccessWho contained "\(real\)\?dn\(\.[a-z]\+\(,[a-z]\+\)\?\)\?="he=e-1 nextgroup=slString
syn match   slAccessWho contained "\(real\)\?dnattr="he=e-1 nextgroup=slString

syn keyword slAccessPerm contained none disclose auth compare search read
syn keyword slAccessPerm contained write add delete manage
syn match   slAccessPerm contained "[=+-][0dxcsrwazm]\+"

" }}}
"-----------------------------------------------------------------------------
" "limit" directives {{{

" TODO: fill me; should be similar to "access to"

" }}}
"-----------------------------------------------------------------------------
" "backend" directives {{{

" TODO: fill me

" }}}
"-----------------------------------------------------------------------------
" "database" directives {{{

" TODO: fill me
" special highlighting:
"   * rootdn
"   * rootpw
"   * suffix
" special highlighting (backend opts):
"   * index
"   * dbconfig
"   * directory
" overlays (next section)

" }}}
"-----------------------------------------------------------------------------
" "overlay" directives {{{

" TODO: fill me

" }}}
"-----------------------------------------------------------------------------
" OID/schema definition {{{

" list of syntax object types in schema definition {{{

" OID name, (single) quoted name bare string
syn match  slOID contained "[a-zA-Z0-9-]\+\(:\d\+\(\.\d\+\)*\)\?"
syn match  slOID contained "'[a-zA-Z0-9-]\+'"
syn match  slOID contained "\d\+\(\.\d\+\)\+"

" length limit part, used for SYNTAX option in attributetype
syn match  slOIDLength contained "{\d\+}"

" string used in DESC and similars (should be displayed the same way as
" slString)
syn match  slOIDString contained "'[^']*'"

" list of OIDs (mainly quoted names), used for NAME option
syn region slOIDList contained start="(" skip="'[^']*'" end=")" contains=slOID

" }}}

" toplevel syntax entities
syn case ignore
syn keyword slOption contained attributetype objectclass ldapsyntax ditcontentrule
syn keyword slOption contained attributeoptions objectidentifier
syn region slOIDAttrType    start="^attributetype[[:space:]\n]\+(" end=")" contains=slOption,slOID,slOIDAttrTypeOption
syn region slOIDObjectClass start="^objectclass[[:space:]\n]\+("   end=")" contains=slOption,slOID,slOIDObjectClassOption
" XXX: attributeoptions are highlighted well enough for me to be happy with it
" XXX: this could be done that ldapsyntax could be valid identifier in
" objectidentifier directive, but I'm not sure if OpenLDAP even supports this
syn match  slOIDObjectIdentifier "^objectidentifier[[:space:]\n]\+\S\+" contains=slOption nextgroup=slOID skipwhite
syn case match

" options defined in attributetype
syn keyword slOIDAttrTypeOption NAME          contained nextgroup=slOID,slOIDList skipwhite skipnl
syn keyword slOIDAttrTypeOption DESC          contained nextgroup=slOIDString     skipwhite skipnl
syn keyword slOIDAttrTypeOption OBSOLETE      contained
syn keyword slOIDAttrTypeOption SUP           contained nextgroup=slOID,slOIDList skipwhite skipnl
syn keyword slOIDAttrTypeOption EQUALITY      contained nextgroup=slOID skipwhite skipnl
syn keyword slOIDAttrTypeOption ORDERING      contained nextgroup=slOID skipwhite skipnl
syn keyword slOIDAttrTypeOption SUBSTR        contained nextgroup=slOID skipwhite skipnl
syn keyword slOIDAttrTypeOption SYNTAX        contained nextgroup=slOID,slOIDLength skipwhite skipnl
syn keyword slOIDAttrTypeOption SINGLE-VALUE  contained
syn keyword slOIDAttrTypeOption COLLECTIVE    contained
syn keyword slOIDAttrTypeOption NO-USER-MODIFICATION contained

" options defined in objectclass
syn keyword slOIDObjectClassOption NAME          contained nextgroup=slOID,slOIDList skipwhite skipnl
syn keyword slOIDObjectClassOption DESC          contained nextgroup=slOIDString     skipwhite skipnl
syn keyword slOIDObjectClassOption OBSOLETE      contained
syn keyword slOIDObjectClassOption SUP           contained nextgroup=slOID,slOIDList skipwhite skipnl
" not sure if this option should have special group name, as it is mandatory
syn keyword slOIDObjectClassOption ABSTRACT STRUCTURAL AUXILIARY contained
syn keyword slOIDObjectClassOption MUST          contained nextgroup=slOID,slOIDList skipwhite skipnl
syn keyword slOIDObjectClassOption MAY           contained nextgroup=slOID,slOIDList skipwhite skipnl

" TODO: highlighting:
"   * ldapsyntax ( ... )
"   * ditcontentrule ( ... )

" }}}
"-----------------------------------------------------------------------------
" colour binding {{{

" highlighting debugging
hi def link slDebug         Error

hi def link slComment       Comment
hi def link slString        Constant
hi def link slPreProc       PreProc
hi def link slOption        Statement

hi def link slAccessOption  Statement
hi def link slAccessToWhat  Type
hi def link slAccessWho     Type
hi def link slAccessPerm    Type

" these colours are to be settled
" directives
hi def link slOIDObjectClass Normal
hi def link slOIDAttrType    Normal
hi def link slOIDObjectIdentifier Identifier
" data types
hi def link slOID            Special
hi def link slOIDList        PreProc
hi def link slOIDLength      Identifier
hi def link slOIDString      slString
" options in complex directives
hi def link slOIDAttrTypeOption    Identifier
hi def link slOIDObjectClassOption Identifier

"hi def link slHip           Type
"hi def link slDesc          PreProc
"hi def link slNumber        Constant

" }}}
"-----------------------------------------------------------------------------

let b:current_syntax = "slapd"

"-----------------------------------------------------------------------------
" vim:foldmethod=marker:nowrap
