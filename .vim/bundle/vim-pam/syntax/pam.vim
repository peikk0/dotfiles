" Vim syntax file
" Language: Linux-PAM - Pluggable Authentication Modules
" Maintainer: David Ne\v{c}as (Yeti) <yeti@physics.muni.cz>
" License: This file can be redistribued and/or modified under the same terms
"          as Vim itself.
" Last Change: 2006-04-24
" URL: http://trific.ath.cx/Ftp/vim/syntax/pam.vim

" Setup {{{
" React to possibly already-defined syntax.
" For version 5.x: Clear all syntax items unconditionally
" For version 6.x: Quit when a syntax file was already loaded
if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif

syn case match
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Comments {{{
syn match pamComment "#.*$" contains=pamTodo,pamVersionTag
syn keyword pamTodo TODO FIXME NOT XXX contained
syn match pamVersionTag "%PAM-\d\+\(\.\d\+\)\+" contained
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Base constructs {{{
syn match pamBOL "^" nextgroup=pamType,pamComment skipwhite
syn keyword pamType auth account password session contained nextgroup=pamControlOld skipwhite
syn keyword pamControlOld requisite required sufficient optional include contained
syn region pamControlBracket start="\[" end="\]" contains=pamControl,pamAction
syn keyword pamControl abort acct_expired auth auth_err contained
syn keyword pamControl authinfo_unavail authtok_disable_aging contained
syn keyword pamControl authtok_expired authtok_lock_busy contained
syn keyword pamControl authtok_recover_err bad_item buf_err contained
syn keyword pamControl conv_err cred_err cred_expired contained
syn keyword pamControl cred_insufficient cred_unavail contained
syn keyword pamControl default ignore maxtries module_unknown contained
syn keyword pamControl new_authtok_reqd no_module_data open_err contained
syn keyword pamControl perm_denied service_err session_err contained
syn keyword pamControl success symbol_err system_err tok_err contained
syn keyword pamControl try_again user_unknown contained
syn keyword pamAction ignore ok done bad die reset contained
syn match pamAction "\<[1-9]\d*\>" contained
syn match pamVariable "\$\w\+"
syn match pamSpecial "\\$"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" [standard] Module names {{{
syn match pamModule "\<pam_\w\+\.so\>" contains=pamModuleName
syn keyword pamModuleName pam_access pam_chroot pam_console contained
syn keyword pamModuleName pam_cracklib pam_deny pam_env pam_filter contained
syn keyword pamModuleName pam_ftp pam_group pam_issue pam_lastlog contained
syn keyword pamModuleName pam_limits pam_listfile pam_localuser contained
syn keyword pamModuleName pam_mail pam_mkhomedir pam_module pam_motd contained
syn keyword pamModuleName pam_nologin pam_permit pam_pwdb pam_radius contained
syn keyword pamModuleName pam_rhosts pam_rootok pam_rhosts_auth contained
syn keyword pamModuleName pam_securetty pam_shells pam_stack contained
syn keyword pamModuleName pam_stress pam_tally pam_time pam_timestamp contained
syn keyword pamModuleName pam_unix pam_unix_acct pam_unix_auth contained
syn keyword pamModuleName pam_unix_passwd pam_unix_session pam_userdb contained
syn keyword pamModuleName pam_warn pam_wheel pam_xauth contained
syn keyword pamModuleName pam_krb4 contained
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Module options {{{
" pam_access
syn keyword pamOptionAccess accessfile
" pam_chroot
syn keyword pamOptionChroot debug onerr
" pam_cracklib
syn keyword pamOptionCracklib debug type retry difok minlen dcredit
syn keyword pamOptionCracklib ucredit lcredit ocredit use_authtok dictpath
" pam_env
syn keyword pamOptionEnv debug conffile envfile readenv
" pam_filter
syn keyword pamOptionFilter debug new_term non_term run1 run2
" pam_ftp
syn keyword pamOptionFtp debug users ignore
" pam_issue
syn keyword pamOptionIssue issue noesc
" pam_krb4
syn keyword pamOptionKrb4 use_first_pass try_first_pass
" pam_lastlog
syn keyword pamOptionLastlog debug nodate noterm nohost silent
syn keyword pamOptionLastlog never nowtmp
" pam_limits
syn keyword pamOptionLimits debug conf change_uid utmp_early
" pam_listfile
syn keyword pamOptionListfile onerr sense file item apply
" pam_localuser
syn keyword pamOptionLocaluser debug file
" pam_mail
syn keyword pamOptionMail debug dir nopen close noenv empty hash
syn keyword pamOptionMail standard quiet
" pam_mkhomedir
syn keyword pamOptionMkhomedir debug skel umask
" pam_motd
syn keyword pamOptionMotd debug motd
" pam_nologin
syn keyword pamOptionNologin file successok
" pam_pwdv
syn keyword pamOptionPwdb debug use_first_pass try_first_pass
syn keyword pamOptionPwdb nullok nodelay likeauth not_set_pass
syn keyword pamOptionPwdb use_authtok md5 bigcrypt shadow radius
syn keyword pamOptionPwdb unix
" pam_radius
syn keyword pamOptionRadius debug
" pam_rhosts
syn keyword pamOptionRhosts debug no_hosts_equiv no_rhosts
syn keyword pamOptionRhosts no_warn privategroup promiscuous
syn keyword pamOptionRhosts suppress
" pam_root_ok
syn keyword pamOptionRootOk debug
" pam_rps
syn keyword pamOptionRps debug throw
" pam_selinux
syn keyword pamOptionSelinux close debug nottys verbose open
" pam_stack
syn keyword pamOptionStack debug service
" pam_stress
syn keyword pamOptionStress debug no_warn use_first_pass try_first_pass rootok
" pam_succeed_if
syn keyword pamOptionSucceedIf debug use_uid quiet quiet_fail quiet_success
syn keyword pamOptionSucceedIf uid gid logic shell home
syn keyword pamOperator eq ne ingroup notingroup innetgr notinnetgr
" pam_tally
syn keyword pamOptionTally onerr file no_magic_root deny reset
syn keyword pamOptionTally no_reset even_deny_root_account
syn keyword pamOptionTally per_user no_lock_time
" pam_tally2
syn keyword pamOptionTally2 onerr file audit deny lock_time unlock_time
syn keyword pamOptionTally2 magic_root even_deny_root root_unlock_time
syn keyword pamOptionTally2 quiet
" pam_timestamp
syn keyword pamOptionTimestamp debug timestampdir verbose
syn keyword pamOptionTimestamp timestamp_timeout
" pam_unix
syn keyword pamOptionUnix debug audit use_first_pass md5 shadow
syn keyword pamOptionUnix try_first_pass nis nullok nodelay bigcrypt
syn keyword pamOptionUnix not_set_pass use_authtok remember
syn keyword pamOptionUnix broken_shadow
" Debian?
syn keyword pamOptionUnix obscure min max
" pam_userdb
syn keyword pamOptionUserdb debug icase dump db use_authtok
syn keyword pamOptionUserdb unknown_ok key_only
" pam_wheel
syn keyword pamOptionWheel debug use_uid trust deny group root_only
" pam_xauth
syn keyword pamOptionXauth debug xauthpath systemuser targetuser
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Define the default highlighting {{{
" For version 5.7 and earlier: Only when not done already
" For version 5.8 and later: Only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_pam_syntax_inits")
  if version < 508
    let did_pam_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pamComment           Comment
  HiLink pamTodo              Todo
  HiLink pamVersionTag        Preproc
  HiLink pamOption            Function
  HiLink pamOptionAccess      pamOption
  HiLink pamOptionChroot      pamOption
  HiLink pamOptionCracklib    pamOption
  HiLink pamOptionDebug       pamOption
  HiLink pamOptionEnv         pamOption
  HiLink pamOptionFilter      pamOption
  HiLink pamOptionFtp         pamOption
  HiLink pamOptionIssue       pamOption
  HiLink pamOptionKrb         pamOption
  HiLink pamOptionLastlog     pamOption
  HiLink pamOptionLimits      pamOption
  HiLink pamOptionListfile    pamOption
  HiLink pamOptionLocaluser   pamOption
  HiLink pamOptionMail        pamOption
  HiLink pamOptionMkhomedir   pamOption
  HiLink pamOptionMotd        pamOption
  HiLink pamOptionNologin     pamOption
  HiLink pamOptionPwdb        pamOption
  HiLink pamOptionRadius      pamOption
  HiLink pamOptionRhosts      pamOption
  HiLink pamOptionRootOk      pamOption
  HiLink pamOptionRps         pamOption
  HiLink pamOptionSelinux     pamOption
  HiLink pamOptionStack       pamOption
  HiLink pamOptionStress      pamOption
  HiLink pamOptionSucceedIf   pamOption
  HiLink pamOptionTally       pamOption
  HiLink pamOptionTally2      pamOption
  HiLink pamOptionTimestamp   pamOption
  HiLink pamOptionUnix        pamOption
  HiLink pamOptionUserdb      pamOption
  HiLink pamOptionWheel       pamOption
  HiLink pamOptionXauth       pamOption
  HiLink pamType              Type
  HiLink pamControlOld        pamControl
  HiLink pamControl           Keyword
  HiLink pamAction            Constant
  HiLink pamModule            Constant
  HiLink pamModuleName        Constant
  HiLink pamVariable          Function
  HiLink pamControlBracket    Special
  HiLink pamSpecial           Special
  HiLink pamOperator          Operator
  delcommand HiLink
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
let b:current_syntax = "pam"

