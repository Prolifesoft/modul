#!/bin/bash
# Script to install and test the Veresiye Defteri module on Odoo 17
# It clones the module, copies it into the addons path, and installs it.
# Environment variables can override defaults:
#   REPO_URL, ADDONS_PATH, DB_NAME, ODOO_BIN

set -e

REPO_URL=${REPO_URL:-"https://github.com/prolifesoft/veresiye_defteri.git"}
MODULE_DIR="veresiye_defteri"
ADDONS_PATH=${ADDONS_PATH:-"$HOME/odoo_addons"}
DB_NAME=${DB_NAME:-"veresiye_db"}
ODOO_BIN=${ODOO_BIN:-"odoo"}

if [ ! -d "$MODULE_DIR" ]; then
  git clone "$REPO_URL" "$MODULE_DIR"
fi

mkdir -p "$ADDONS_PATH"
cp -r "$MODULE_DIR" "$ADDONS_PATH"

$ODOO_BIN -d "$DB_NAME" -i veresiye_defteri --stop-after-init
$ODOO_BIN -d "$DB_NAME" -i veresiye_defteri --test-enable --stop-after-init

