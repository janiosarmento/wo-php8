#!/usr/bin/env bash

declare theDir
theDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
declare -r nginxDir="${theDir}/nginx"
declare tempDir
tempDir="$(mktemp -d -p "${theDir}")"

if [ ! -d "${nginxDir}" ]; then
    echo "Nginx directory not found, verify your download."
    exit 1
fi

if ! type wo > /dev/null 2>&1; then
    echo "WordOps not found, verify your installation."
    exit 1
fi

echo "Cloning patched WO repo"
cd "${tempDir}" || exit 1
git clone https://github.com/janiosarmento/WordOps

echo "Patching WO"
# TODO: Confirm the destination directory (might be a different Python path)
rsync -a --include="*.py" --exclude="*" \
    "${tempDir}/WordOps/wo/" /opt/wo/lib/python3.8/site-packages/wo/

echo "Copying new nginx config files"

rsync -a "${nginxDir}/common/" /etc/nginx/common/
rsync -a "${nginxDir}/conf.d/" /etc/nginx/conf.d/

rm -rf "${tempDir}"

echo ""
echo "Done!"
