#!/bin/bash
# Script to merge NetHunter kernel config options into existing defconfig

set -e

NETHUNTER_CONFIG="$(cd "$(dirname "${BASH_SOURCE[0]}")/../nethunter-configs/nethunter_defconfig" && pwd)"
TARGET_CONFIG="${1:-.config}"

if [ ! -f "$TARGET_CONFIG" ]; then
    echo "Error: Target config $TARGET_CONFIG does not exist"
    exit 1
fi

if [ ! -f "$NETHUNTER_CONFIG" ]; then
    echo "Error: NetHunter config not found at $NETHUNTER_CONFIG"
    exit 1
fi

echo "Merging NetHunter config options into $TARGET_CONFIG..."

# Merge configs - NetHunter options will override existing ones
scripts/kconfig/merge_config.sh -m -O "$(dirname "$TARGET_CONFIG")" "$TARGET_CONFIG" "$NETHUNTER_CONFIG"

echo "✅ NetHunter config merged successfully"
