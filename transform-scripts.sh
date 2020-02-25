#!/bin/sh

# set -x # verbose
set -o pipefail # exit on pipeline error
set -e # exit on error
set -u # variable must exist

ROOT=$(git rev-parse --show-toplevel)


function main(){
    _module "scripts" "samples-scripts"
    _module "cloud" "samples-cloud"
}


function _module() {
    local TARGET="${1}"; shift
    local SOURCE="${1}"; shift

    mkdir -p "${ROOT}/content/${TARGET}"
    # _node "/content/${TARGET}" "${TARGET}"

    ls "${ROOT}/static/${SOURCE}/" | while read SECTION; do
        mkdir -p "${ROOT}/content/${TARGET}/${SECTION}"
        # _node "/content/${TARGET}/${SECTION}" "${SECTION}"

        ls "${ROOT}/static/${SOURCE}/${SECTION}/" | while read NAME; do
            _leaf "/content/${TARGET}/${SECTION}" "${NAME}" "/${SOURCE}/${SECTION}/${NAME}"
        done
    done
}


function _node() {
    local DIRECTORY="${1}"; shift
    local NAME="${1}"; shift

cat <<EOF > "${ROOT}/${DIRECTORY}/_index.md"
---
title: ${NAME}
weight: 999
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: false

---
EOF
}



function _leaf() {
    local DIRECTORY="${1}"; shift
    local NAME="${1}"; shift
    local OBJECT="${1}"; shift
    local LANGUAGE="$(_file_language "${DIRECTORY}/${NAME}.md")"

cat <<EOF > "${ROOT}/${DIRECTORY}/${NAME}.md"
---
title: ${NAME}
weight: 999
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: false

---

{{< code file="${OBJECT}" language="${LANGUAGE}" download="true" >}}
EOF
}


function _file_language() {
    local FILENAME="${1}"; shift
    local DEFAULT="${1:-"sh"}"
    case "${FILENAME}" in
        /content/scripts/utils/simple-https.md)
            echo "python3"
            ;;
        /content/scripts/utils/ftpython.md)
            echo "python3"
            ;;
        /content/scripts/golang/*.md)
            echo "go"
            ;;
        /content/cloud/kubernetes/*.yaml.md)
            echo "yaml"
            ;;
        *)
            echo "${DEFAULT}"
            ;;
    esac
}


main
