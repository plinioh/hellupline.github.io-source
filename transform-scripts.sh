#!/bin/sh

# set -x # verbose
set -o pipefail # exit on pipeline error
set -e # exit on error
set -u # variable must exist

ROOT=$(git rev-parse --show-toplevel)


function main(){
    module "scripts" "samples-scripts"
    module "cloud" "samples-cloud"
}


function script_language() {
    local FILENAME="${1}"; shift
    local DEFAULT="${1:-"sh"}"
    case "${FILENAME}" in
        /content/docs/scripts/utils/simple-https.md)
            echo "python3"
            ;;
        /content/docs/cloud/kubernetes/*.yaml.md)
            echo "yaml"
            ;;
        *)
            echo "${DEFAULT}"
            ;;
    esac
}


function module() {
    local TARGET="${1}"; shift
    local SOURCE="${1}"; shift

    mkdir -p "${ROOT}/content/docs/${TARGET}"
    node "/content/docs/${TARGET}" "${TARGET}"

    ls "${ROOT}/static/${SOURCE}/" | while read DIR; do
        mkdir -p "${ROOT}/content/docs/${TARGET}/${DIR}"
        node "/content/docs/${TARGET}/${DIR}" "${DIR}"

        ls "${ROOT}/static/${SOURCE}/${DIR}/" | while read NAME; do
            leaf "/content/docs/${TARGET}/${DIR}" "${NAME}" "/${SOURCE}/${DIR}/${NAME}"
        done
    done
}


function node() {
    local DIRECTORY="${1}"; shift
    local NAME="${1}"; shift

cat <<EOF > "${ROOT}/${DIRECTORY}/_index.md"
---
title: ${NAME}
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: false

---
EOF
}



function leaf() {
    local DIRECTORY="${1}"; shift
    local NAME="${1}"; shift
    local OBJECT="${1}"; shift
    local LANGUAGE="$(script_language "${DIRECTORY}/${NAME}.md")"

cat <<EOF > "${ROOT}/${DIRECTORY}/${NAME}.md"
---
title: ${NAME}
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: false

---

{{< code file="${OBJECT}" language="${LANGUAGE}" download="true" >}}
EOF
}


main
