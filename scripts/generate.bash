#!/usr/bin/env bash

# credit for the script goes to https://github.com/openshift/cluster-monitoring-operator/blob/master/hack/build-jsonnet.sh

set -e
set -x
# only exit with zero if all commands of the pipeline exit successfully
set -o pipefail

# Ensure that we use the binaries from the versions defined in hack/tools/go.mod.
PATH="$(pwd)/tmp/bin:${PATH}"

prefix="assets"
rm -rf $prefix || :
mkdir $prefix

TMP=$(mktemp -d -t tmp.XXXXXXXXXX)
echo "Created temporary directory at $TMP"

jsonnet -J jsonnet/vendor jsonnet/main.jsonnet > "${TMP}/main.json"

while IFS= read -r line; do
    files+=("$line")
done < <(jq -r 'keys[]' "${TMP}/main.json")

for file in "${files[@]}"
do
    dir=$(dirname "${file}")
    path="${prefix}/${dir}"
    mkdir -p "${path}"
    # convert file name from camelCase to snake-case
    fullfile=$(echo "${file}" | sed 's/\(.\)\([A-Z]\)/\1-\2/g' | tr '[:upper:]' '[:lower:]')
    jq -r ".[\"${file}\"]" "${TMP}/main.json" | gojsontoyaml > "${prefix}/${fullfile}.yaml"
done

