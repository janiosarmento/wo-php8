# wo-php8
Unofficial support to PHP 8 on WordOps

This is an unofficial patch to add WordOps support to PHP 8.0 and 8.1.

## Disclaimer

This script serves to _my_ purposes, and there's no way I can guarantee it will
work in your environment or meet your expectations.

I can't provide any support for it. Its source code is entirely published in
GitHub so that anyone can inspect it before deciding to run it.

## Installation

**Make backups of your server before trying this script. It may ruin your server
and I can't help you to recover, neither can I take any responsibility for any
unexpected results. Be responsible!**

You should be root to run this script.

```bash
cd /home
git clone https://github.com/janiosarmento/wo-php8
cd wo-php8
```

## Run the patch

```bash
./install.sh
```

## Cleanup

At this point, your WO should be patched. Just delete the temporary directory.

```bash
cd /home
rm -rf wo-php8
```

## Test the patch

```Terminal
# wo --version
WordOps v3.13.3-fork
Copyright (c) 2020 WordOps.
```

Notice the "fork" tag beside the version number.

## Install PHP 8

```bash
wo stack install --php81
wo site update yourdomain.com --php81
```
