#!/usr/bin/env bash

declare theDir
theDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
declare -r nginxDir="${theDir}/nginx"
declare tempDir
tempDir="$(mktemp -d -p "${theDir}")"
declare pythonVersion
pythonVersion="$(
    python3 --version |
    awk '{print $2}' |
    awk -F. '{print $1"."$2}'
    )"

echo ''
echo "Detected Python version: ${pythonVersion}"
echo ''

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

rsync -a --include="*.py" \
    "${tempDir}/WordOps/wo/" "/opt/wo/lib/python${pythonVersion}/site-packages/wo/"

echo "Copying new nginx config files"

rsync -a "${nginxDir}/common/" /etc/nginx/common/
rsync -a "${nginxDir}/conf.d/" /etc/nginx/conf.d/

rm -rf "${tempDir}"

echo ''
echo 'Reconfiguring PHP-CLI back to 7.4 to avoid error when installing WP'

update-alternatives --set php /usr/bin/php7.4
update-alternatives --set phar /usr/bin/phar7.4
update-alternatives --set phar.phar /usr/bin/phar.phar7.4
update-alternatives --set phpize /usr/bin/phpize7.4
update-alternatives --set php-config /usr/bin/php-config7.4

echo ""
echo "Done!"
