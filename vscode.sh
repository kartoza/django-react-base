#!/usr/bin/env bash

# ----------------------------------------------
# User-adjustable parameters
# ----------------------------------------------

VSCODE_PROFILE="django_project"
EXT_DIR=".vscode-profile/extensions"
VSCODE_DIR=".vscode-profile"
LOG_FILE=".vscode-profile/.log"

CODING_EXTENSIONS=(
    ms-vscode-remote.remote-containers@0.429.0
    charliermarsh.ruff@2025.26.0
)

DOCUMENTATION_EXTENSIONS=(
    bpruitt-goddard.mermaid-markdown-syntax-highlighting@1.7.1
    bierner.markdown-mermaid@1.28.0
    DavidAnson.vscode-markdownlint@0.60.0
    yzhang.markdown-all-in-one@3.6.3
)

REQUIRED_EXTENSIONS=(
    "${CODING_EXTENSIONS[@]}"
    "${DOCUMENTATION_EXTENSIONS[@]}"
)

# ----------------------------------------------
# Functions
# ----------------------------------------------

launch_vscode() {
    code --user-data-dir="$VSCODE_DIR" \
        --profile="${VSCODE_PROFILE}" \
        --extensions-dir="$EXT_DIR" "$@"
}

list_installed_extensions() {
    find "$EXT_DIR" -maxdepth 1 -mindepth 1 -type d | while read -r dir; do
        pkg="$dir/package.json"
        if [[ -f "$pkg" ]]; then
            name=$(jq -r '.name' <"$pkg")
            publisher=$(jq -r '.publisher' <"$pkg")
            version=$(jq -r '.version' <"$pkg")
            echo "${publisher}.${name}@${version}"
        fi
    done
}

print_help() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

This script sets up and launches VSCode with a custom profile and extensions for the Kartoza Django Project.

Actions performed:
    - Checks for required files and directories (deployment/.env, redis volume, etc.)
    - Ensures VSCode and Docker are installed
    - Initializes VSCode user and extension directories if needed
    - Updates VSCode settings for commit signing, formatters, and linters (Markdown, Shell, Python)
    - Installs all required VSCode extensions
    - Launches VSCode with the specified profile and directories

Options:
    --help             Show this help message and exit
    --verbose          Print final settings.json contents before launching VSCode
    --list-extensions  List installed VSCode extensions in the custom extensions directory

EOF
}

# Parameter handler
for arg in "$@"; do
    case "$arg" in
        --help)
            print_help
            exit 0
            ;;
        --verbose)
            # Handled later in the script
            ;;
        --list-extensions)
            echo "Installed extensions:"
            list_installed_extensions
            exit 0
            ;;
        *) ;;
    esac
done

# ----------------------------------------------
# Script starts here
# ----------------------------------------------

# Truncate the log file at the start
echo "🗨️ Truncating $LOG_FILE..."
true >"$LOG_FILE"

echo "🗨️ Checking deployment .env exists ..."
if [ ! -f deployment/.env ]; then
    echo "❌ deployment/.env file not found."
    echo "   Please run ./setup.sh to create it."
    exit 1
else
    echo "  ✅ deployment/.env found ok."
fi

echo "🗨️ Checking VSCode is installed ..."
if ! command -v code &>/dev/null; then
    echo "  ❌ 'code' CLI not found. Please install VSCode and add 'code' to your PATH."
    exit 1
else
    echo "  ✅ VSCode found ok."
fi

# Ensure .vscode directory exists
echo "🗨️  Checking if VSCode has been run before..."
if [ ! -d .vscode ]; then
    echo "  🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻"
    echo "  ⭐️ It appears you have not run vscode in this project before."
    echo "     After it opens, please close vscode and then rerun this script"
    echo "     so that the extensions directory initialises properly."
    echo "  🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺"
    mkdir -p .vscode
    mkdir -p .vscode-extensions
    # Launch VSCode with the sandboxed environment
    launch_vscode .
    exit 1
else
    echo "  ✅ VSCode directory found from previous runs of vscode."
fi

# Ensure profiles directory exists
echo "🗨️  Checking if VSCode has profiles..."
if [ ! -d ".vscode-profile/User/profiles" ]; then
    echo "  🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻"
    echo "  ⭐️ It appears you have have not profiles yet."
    echo "     After it opens, please close vscode and then rerun this script"
    echo "     so that the extensions directory initialises properly."
    echo "  🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺"
    # Launch VSCode with the sandboxed environment
    launch_vscode .
    exit 1
else
    echo "  ✅ ${VSCODE_PROFILE} profile has been created."
fi

echo "🗨️ Checking docker is installed ..."
if ! command -v docker &>/dev/null; then
    echo "  ❌ 'docker' CLI not found. Please install docker and ensure you have permissions to use it."
    exit 1
else
    echo "  ✅ Docker found ok."
fi

echo "🗨️ Checking redis directory permissions..."
if [ ! -d deployment/volumes/tmp_data/redis ]; then
    echo "  📂 Creating deployment/volumes/tmp_data/redis..."
    mkdir -p deployment/volumes/tmp_data/redis
    sudo chown -R 1001:1001 deployment/volumes/tmp_data/redis
else
    echo "  ✅ Redis directory already exists."
fi

echo "🗨️ Checking if VSCode has been run before..."
if [ ! -d "$VSCODE_DIR" ]; then
    echo "  ⭐️ First-time VSCode run detected. Opening VSCode to initialize..."
    mkdir -p "$VSCODE_DIR"
    mkdir -p "$EXT_DIR"
    launch_vscode .
    exit 1
else
    echo "  ✅ VSCode directory detected."
fi

SETTINGS_FILE="$VSCODE_DIR/settings.json"

echo "🗨️ Checking if settings.json exists..."
if [[ ! -f "$SETTINGS_FILE" ]]; then
    echo "{}" >"$SETTINGS_FILE"
    echo "  🔧 Created new settings.json"
else
    echo "  ✅ settings.json exists"
fi

echo "🗨️ Updating git commit signing setting..."
jq '.["git.enableCommitSigning"] = true' "$SETTINGS_FILE" >"$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
echo "  🔧 git.enableCommitSigning enabled"

echo "🗨️ Ensuring markdown formatter is set..."
if ! jq -e '."[markdown]".editor.defaultFormatter' "$SETTINGS_FILE" >/dev/null; then
    jq '."[markdown]" += {"editor.defaultFormatter": "DavidAnson.vscode-markdownlint"}' "$SETTINGS_FILE" >"$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    echo "  🔧 Markdown formatter set"
else
    echo "  ✅ Markdown formatter already configured"
fi

echo "🗨️ Ensuring shell script formatter and linter are set..."
if ! jq -e '."[shellscript]".editor.defaultFormatter' "$SETTINGS_FILE" >/dev/null; then
    jq '."[shellscript]" += {"editor.defaultFormatter": "foxundermoon.shell-format", "editor.formatOnSave": true}' "$SETTINGS_FILE" >"$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    echo "  🔧 Shell script formatter set to foxundermoon.shell-format, formatOnSave enabled"
else
    echo "  ✅ Shell script formatter already configured"
fi

if ! jq -e '.["shellcheck.enable"]' "$SETTINGS_FILE" >/dev/null; then
    jq '. + {"shellcheck.enable": true}' "$SETTINGS_FILE" >"$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    echo "  🔧 ShellCheck linting enabled"
else
    echo "  ✅ ShellCheck linting already configured"
fi

if ! jq -e '.["shellformat.flag"]' "$SETTINGS_FILE" >/dev/null; then
    jq '. + {"shellformat.flag": "-i 4 -bn -ci"}' "$SETTINGS_FILE" >"$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    echo "  🔧 Shell format flags set (-i 4 -bn -ci)"
else
    echo "  ✅ Shell format flags already configured"
fi
echo "🗨️ Ensuring global format-on-save is enabled..."
if ! jq -e '.["editor.formatOnSave"]' "$SETTINGS_FILE" >/dev/null; then
    jq '. + {"editor.formatOnSave": true}' "$SETTINGS_FILE" >"$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    echo "  🔧 Global formatOnSave enabled"
else
    echo "  ✅ Global formatOnSave already configured"
fi

# Python formatter and linter
echo "🗨️ Ensuring Python formatter and linter are set..."
if ! jq -e '."[python]".editor.defaultFormatter' "$SETTINGS_FILE" >/dev/null; then
    jq '."[python]" += {"editor.defaultFormatter": "charliermarsh.ruff"}' "$SETTINGS_FILE" >"$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    echo "  🔧 Python formatter set to Black"
else
    echo "  ✅ Python formatter already configured"
fi

if ! jq -e '.["python.linting.enabled"]' "$SETTINGS_FILE" >/dev/null; then
    jq '. + {"python.linting.enabled": true, "python.linting.pylintEnabled": true}' "$SETTINGS_FILE" >"$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    echo "  🔧 Python linting enabled (pylint)"
else
    echo "  ✅ Python linting already configured"
fi

if [[ " $* " == *" --verbose "* ]]; then
    echo "🗨️ Final settings.json contents:"
    cat "$SETTINGS_FILE"
fi

echo "🗨️ Installing required extensions..."
for ext in "${REQUIRED_EXTENSIONS[@]}"; do
    if echo "$installed_exts" | grep -q "^${ext}$"; then
        echo "  ✅ Extension ${ext} already installed."
    else
        echo "  📦 Installing ${ext}..."
        # Capture both stdout and stderr to log file
        if launch_vscode --install-extension "${ext}" >>"$LOG_FILE" 2>&1; then
            # Refresh installed_exts after install
            installed_exts=$(list_installed_extensions)
            if echo "$installed_exts" | grep -q "^${ext}$"; then
                echo "  ✅ Successfully installed ${ext}."
            else
                echo "  ❌ Failed to install ${ext} (not found after install)."
                exit 1
            fi
        else
            echo "  ❌ Failed to install ${ext} (error during install). Check $LOG_FILE for details."
            exit 1
        fi
    fi
done

echo "🗨️ Launching VSCode..."
launch_vscode .
