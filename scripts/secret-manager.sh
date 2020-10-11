#!/usr/bin/env bash
set -euox pipefail
SCRIPT_DIR=$(dirname "$0")
echo "${SCRIPT_DIR}"
cd "${SCRIPT_DIR}" && cd ../secret-manager

cmd=${1:-}

if [ -z "${cmd}" ]; then
  echo -n "Select command(create/list): "
  read cmd
fi

project=$(gcloud secrets versions access latest --secret="project-id")
if [[ -z "${project}" ]]; then
  echo -n "need project"
  exit 1
fi

case "${cmd}" in
  "create" ) go run ./*.go create -p "${project}" ;;
  "list"   ) go run ./*.go list -p "${project}" ;;
  *        ) echo "invalid command: ${cmd}"
             exit 1;;
esac
