#!/bin/bash

# Bootstraps and installs in one go (required for devcontainers dotfiles.installCommand)

set -e

DIR="$HOME/.dotfiles/script"

# GIT_AUTHOR_NAME=${GIT_AUTHOR_NAME:=gitname} GIT_AUTHOREMAIL=${GIT_AUTHOREMAIL:=gitemail} \
OVERWRITE_ALL=true ${DIR}/bootstrap

${DIR}/install