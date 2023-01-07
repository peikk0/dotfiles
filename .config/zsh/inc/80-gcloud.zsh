
# {{{ google-cloud-sdk

gcloud_paths=(
    "${HOME}/.local/opt/google-cloud-sdk" \
    /opt/google-cloud-sdk \
    /usr/local/google-cloud-sdk \
    "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
  )

for gcloud_path in ${gcloud_paths}; do
  if [[ -d "${gcloud_path}" ]]; then
    GOOGLE_CLOUD_SDK="${gcloud_path}"
    break
  fi
done

unset gcloud_paths gcloud_path

if [[ -n "${GOOGLE_CLOUD_SDK}" ]]; then
  . "${GOOGLE_CLOUD_SDK}/path.zsh.inc"
  . "${GOOGLE_CLOUD_SDK}/completion.zsh.inc"
fi

# For loading the optional Numpy dependency
export CLOUDSDK_PYTHON_SITEPACKAGES=1

# For kubectl with GKE
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
