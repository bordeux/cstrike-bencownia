#!/bin/bash
# Links folders to persistent storage

PERSISTENT_STORAGE=/storage/data


persistent_dir() {
    local SRC="$1"
    local DST="$2"

    if [[ -z "$SRC" || -z "$DST" ]]; then
        echo "❌ Usage: link_logs <source_dir> <destination_dir>"
        return 1
    fi
    DST="${PERSISTENT_STORAGE}${DST}"

    # Create destination directory if it does not exist
    if [[ ! -d "$DST" ]]; then
        echo "📁 Creating destination directory: $DST"
        mkdir -p "$DST" || {
            echo "❌ ERROR: Failed to create destination directory"
            return 1
        }
    fi

    # Copy existing source files to destination if DST is empty and SRC has files
    if [[ -d "$SRC" && ! -L "$SRC" ]]; then
        # Check if destination is empty and source has files
        if [[ -z "$(ls -A "$DST" 2>/dev/null)" && -n "$(ls -A "$SRC" 2>/dev/null)" ]]; then
            echo "📋 Copying existing files from $SRC to $DST"
            cp -r "$SRC"/* "$DST"/ || {
                echo "❌ ERROR: Failed to copy files to destination"
                return 1
            }
            echo "✅ Files copied successfully"
        fi
    fi

    # Remove source directory if it exists (directory or symlink)
    if [[ -e "$SRC" || -L "$SRC" ]]; then
        echo "🗑️  Removing source path: $SRC"
        rm -rf "$SRC" || {
            echo "❌ ERROR: Failed to remove source directory"
            return 1
        }
    fi

    # Ensure parent directory of source exists
    local SRC_PARENT=$(dirname "$SRC")
    if [[ ! -d "$SRC_PARENT" ]]; then
        echo "📁 Creating parent directory: $SRC_PARENT"
        mkdir -p "$SRC_PARENT" || {
            echo "❌ ERROR: Failed to create parent directory"
            return 1
        }
    fi

    # Create symlink
    echo "🔗 Creating symlink: $SRC -> $DST"
    ln -s "$DST" "$SRC" || {
        echo "❌ ERROR: Failed to create symlink"
        return 1
    }
    echo "✅ Symlink created successfully: $SRC -> $DST"
}

persistent_file() {
    local SRC="$1"
    local DST="$2"

    if [[ -z "$SRC" || -z "$DST" ]]; then
        echo "❌ Usage: persistent_file <source_file> <destination_file>"
        return 1
    fi
    DST="${PERSISTENT_STORAGE}${DST}"

    # Create destination directory if it does not exist
    local DST_DIR=$(dirname "$DST")
    if [[ ! -d "$DST_DIR" ]]; then
        echo "📁 Creating destination directory: $DST_DIR"
        mkdir -p "$DST_DIR" || {
            echo "❌ ERROR: Failed to create destination directory"
            return 1
        }
    fi

    # Copy existing source file to destination if source exists and destination doesn't
    if [[ -f "$SRC" && ! -L "$SRC" && ! -f "$DST" ]]; then
        echo "📋 Copying existing file from $SRC to $DST"
        cp "$SRC" "$DST" || {
            echo "❌ ERROR: Failed to copy file to destination"
            return 1
        }
        echo "✅ File copied successfully"
    elif [[ ! -f "$DST" ]]; then
        # Create empty destination file if it doesn't exist
        echo "📝 Creating empty file: $DST"
        touch "$DST" || {
            echo "❌ ERROR: Failed to create destination file"
            return 1
        }
    fi

    # Remove source file if it exists (file or symlink)
    if [[ -e "$SRC" || -L "$SRC" ]]; then
        echo "🗑️  Removing source file: $SRC"
        rm -f "$SRC" || {
            echo "❌ ERROR: Failed to remove source file"
            return 1
        }
    fi

    # Ensure parent directory of source exists
    local SRC_PARENT=$(dirname "$SRC")
    if [[ ! -d "$SRC_PARENT" ]]; then
        echo "📁 Creating parent directory: $SRC_PARENT"
        mkdir -p "$SRC_PARENT" || {
            echo "❌ ERROR: Failed to create parent directory"
            return 1
        }
    fi

    # Create symlink
    echo "🔗 Creating symlink: $SRC -> $DST"
    ln -s "$DST" "$SRC" || {
        echo "❌ ERROR: Failed to create symlink"
        return 1
    }
    echo "✅ Symlink created successfully: $SRC -> $DST"
}

persistent_dir ${CSTRIKE_PATH}/addons/amxmodx/logs /amxmod_logs
persistent_dir ${CSTRIKE_PATH}/addons/yapb/logs /yapb_logs
persistent_dir ${CSTRIKE_PATH}/addons/yapb/train /yapb_train
persistent_dir ${CSTRIKE_PATH}/logs /hlds_logs
persistent_file ${CSTRIKE_PATH}/addons/amxmodx/data/csstats.dat /csstats.dat
