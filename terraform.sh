#!/usr/bin/env bash

function getProjectDir() {
  MY_PATH="$(dirname "$0")"         # relative
  MY_PATH="$(cd "$MY_PATH" && pwd)" # absolutized and normalized
  if [ -z "$MY_PATH" ]; then
    # error; for some reason, the path is not accessible
    # to the script (e.g. permissions re-evaled after suid)
    exit 1 # fail
  fi
  echo "$MY_PATH"
}

set -e

#
PROJECT_DIR=$(getProjectDir)
GLOBAL_PATH=$PROJECT_DIR/global
WORKSPACE=$1
STACK=$2
ACTION=$3

if [ ! $ACTION ]; then
  echo "too few arguments"
  exit 1
fi

ACTION_ARGS=$(echo "$@" | awk '{first = $1; second = $2; third = $3; $1 = ""; $2 = ""; $3 = ""; print $0 }')
OS_SHORTNAME=$(uname | awk '{print tolower($0)}')

echo ""
echo "=============================================================================="
echo " Executing terraform $ACTION against the $STACK stack in $WORKSPACE. "
echo "=============================================================================="
echo ""

export STACK

export TARGET_DIR=$PROJECT_DIR/workspaces/$WORKSPACE/$STACK

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Stack \"$STACK\" does not exist in workspace \"$WORKSPACE\"."
  exit 1
fi

cd $TARGET_DIR

export CMD="terraform $ACTION $ACTION_ARGS"

if command -v tfswitch &>/dev/null; then
  if test -f "versions.tf"; then
    tfswitch
  else
    echo "Invalid module - missing 'versions.tf' file. Required by tfswitch to select the terraform version."
    exit 1
  fi
else
  echo "Could not find tfswitch. Please install https://github.com/warrensbox/terraform-switcher"
  exit 1
fi

if [ ! -d "$PROJECT_DIR/workspaces/$WORKSPACE/$STACK/.terraform" ]; then
  echo "initalizing stack"
  terraform init
fi

terraform get -update

set +e
terraform workspace select $WORKSPACE >/dev/null 2>&1
if [ "$?" -eq "1" ]; then
  echo "creating new workspace: $WORKSPACE for stack $STACK"
  terraform workspace new $WORKSPACE
fi
set -e

$CMD
