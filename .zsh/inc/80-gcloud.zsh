
# {{{ google-cloud-sdk

GOOGLE_CLOUD_SDK="${HOME}/.local/opt/google-cloud-sdk"

if [ -f "${GOOGLE_CLOUD_SDK}/path.zsh.inc" ]; then
    . "${GOOGLE_CLOUD_SDK}/path.zsh.inc"
fi
if [ -f "${GOOGLE_CLOUD_SDK}/completion.zsh.inc" ]; then
    . "${GOOGLE_CLOUD_SDK}/completion.zsh.inc"
fi

# For loading the optional Numpy dependency
CLOUDSDK_PYTHON_SITEPACKAGES=1; export CLOUDSDK_PYTHON_SITEPACKAGES

# For kubectl with GKE
USE_GKE_GCLOUD_AUTH_PLUGIN=True; export USE_GKE_GCLOUD_AUTH_PLUGIN

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
