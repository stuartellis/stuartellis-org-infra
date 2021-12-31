#!/bin/bash

set -euo pipefail

### Configuration

export BIN_DIR="bin"
export TMP_DIR="tmp"

TFLINT_VERSION=$(jq -r .config.tflint.version package.json)
export TFLINT_VERSION
export TFLINT_EXE=tflint

TERRAGRUNT_VERSION=$(jq -r .config.terragrunt.version package.json)
export TERRAGRUNT_VERSION
export TERRAGRUNT_EXE=terragrunt

### Functions

function specify_arch () {
  CPU_TYPE=$(uname -m)

  if [ "$CPU_TYPE" == "x86_64" ]; then
    ARCH="amd64"
  elif [ "$CPU_TYPE" == "arm64" ]; then
    ARCH="arm64"
  else
    ARCH="386"
  fi
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

  export TFLINT_FILE=tflint_"$OS"_"$ARCH.zip"
  TFLINT_URL="https://github.com/terraform-linters/tflint/releases/download/v$TFLINT_VERSION/$TFLINT_FILE"
  export TFLINT_URL
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
    echo "Expected Terragrunt version: $TERRAGRUNT_VERSION"
    echo "Expected TFLint version: $TFLINT_VERSION"
    echo "Detected CPU architecture: $ARCH"
    echo "Detected Operating system: $OS"
    echo "Terragrunt download URL: $TERRAGRUNT_URL" 
    echo "TFLint download URL: $TFLINT_URL" 
    ./"$BIN_DIR"/"$TERRAGRUNT_EXE" --version
  ;;
  clean)
   [ -d $BIN_DIR ] && rm -r $BIN_DIR 
   [ -d $TMP_DIR ] && rm -r $TMP_DIR 
  ;;
  setup)
    specify_arch
    specify_os
    specify_download_urls
    [ -d "$BIN_DIR" ] || mkdir "$BIN_DIR"
    [ -d "$TMP_DIR" ] || mkdir "$TMP_DIR"

    # Terragrunt
    if [ ! -x "$BIN_DIR/$TERRAGRUNT_EXE" ]; then 
      curl -L "$TERRAGRUNT_URL" > $BIN_DIR/$TERRAGRUNT_EXE 
      chmod +x "$BIN_DIR"/"$TERRAGRUNT_EXE"
    fi

    # TFLint
    if [ ! -x "$BIN_DIR/$TFLINT_EXE" ]; then 
      curl -L "$TFLINT_URL" > $TMP_DIR/$TFLINT_EXE.zip
      unzip $TMP_DIR/$TFLINT_EXE.zip -d $TMP_DIR
      mv $TMP_DIR/$TFLINT_EXE $BIN_DIR/$TFLINT_EXE
      chmod +x "$BIN_DIR"/"$TFLINT_EXE"
    fi

  ;;
  *)
    echo "$1 is not a valid command"
  ;;
esac
