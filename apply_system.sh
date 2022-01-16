#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

pushd $SCRIPTPATH
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd
