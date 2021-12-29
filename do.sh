#!/bin/bash

set -euo pipefail

### Configuration

export BIN_DIR="bin"

TERRAGRUNT_VERSION=$(jq -r .config.terragrunt.version package.json)
export TERRAGRUNT_VERSION
export TERRAGRUNT_EXE=terragrunt

### Functions

function specify_arch () {
  ARCH="amd64"
  export ARCH
}

function specify_os () {
  OS_ID="$(uname -a)"
  MACOS_ALIAS=Darwin
  if [[ $OS_ID == *"$MACOS_ALIAS"* ]]; then
    export OS=darwin
  else
    export OS=linux
  fi
}

function specify_download_urls () {
  specify_arch
  specify_os
  export TERRAGRUNT_FILE=terragrunt_"$OS"_"$ARCH"
  TERRAGRUNT_URL="https://github.com/gruntwork-io/terragrunt/releases/download/v$TERRAGRUNT_VERSION/$TERRAGRUNT_FILE"
  export TERRAGRUNT_URL
}

function require_config () {
  if [ ! "${TERRAGRUNT_CONFIG:-}" ]; then 
    echo "Specify a configuration file."
    exit 1
  fi
}

### Main

if [ ! "${1:-}" ]; then 
  echo "Specify a subcommand."
  exit 1
fi

case $1 in
  info)
    specify_arch
    specify_os
    specify_download_urls
    echo "CPU arch: $ARCH"
    echo "Operating system: $OS"
    echo "Expected Terragrunt version: $TERRAGRUNT_VERSION"
    echo "Terragrunt download URL: $TERRAGRUNT_URL" 
    ./"$BIN_DIR"/"$TERRAGRUNT_EXE" --version
  ;;
  clean)
   [ -d $BIN_DIR ] && rm -r $BIN_DIR 
  ;;
  setup)
    specify_arch
    specify_os
    specify_download_urls
    [ -d "$BIN_DIR" ] || mkdir "$BIN_DIR"

    # Terragrunt
    if [ ! -x "$TERRAGRUNT_EXE" ]; then 
      curl -L "$TERRAGRUNT_URL" > $BIN_DIR/$TERRAGRUNT_EXE 
      chmod +x "$BIN_DIR"/"$TERRAGRUNT_EXE"
    fi

  ;;
  *)
    echo "$1 is not a valid command"
  ;;
esac
