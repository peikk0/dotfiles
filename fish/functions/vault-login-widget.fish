function vault-login-widget --argument-names role --description "Spawn Vault login command in a Tmux popup (if possible)"
  set -q role[1]; or set role 'user'

  if test -z $VAULT_ADDR
    commandline -f redraw
    return
  end

  if set -q TMUX
    tmux display-popup -E -h 20 "
      printf %b '$(set_color blue)"'[vault]'"$(set_color normal) 󱥸 Logging into Vault at $(set_color cyan)$VAULT_ADDR$(set_color normal) with role $(set_color magenta)$role$(set_color normal)...\n';
      vault login -no-print -address $(string escape $VAULT_ADDR) -method oidc role=$(string escape $role) || read
      "
    return
  else
    echo "$(set_color blue)"'[vault]'"$(set_color normal) 󱥸 Logging into Vault at $(set_color cyan)$VAULT_ADDR$(set_color normal) with role $(set_color magenta)$role$(set_color normal)..."
    commandline -r "vault login -no-print -address $(string escape $VAULT_ADDR) -method oidc role=$(string escape $role)"
    commandline -f execute
  end
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
