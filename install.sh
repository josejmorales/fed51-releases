#!/usr/bin/env bash
# Installs the latest fed51 release (macOS, Apple Silicon).
set -euo pipefail

REPO="josejmorales/fed51-releases"

if [ "$(uname -s)-$(uname -m)" != "Darwin-arm64" ]; then
  echo "This installer supports macOS on Apple Silicon only (found $(uname -s) $(uname -m))." >&2
  exit 1
fi

asset="fed51-macos-arm64"
dir="${FED51_INSTALL_DIR:-$HOME/.local/bin}"
base="https://github.com/$REPO/releases/latest/download"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "Downloading fed51..."
curl -fsSL "$base/$asset" -o "$tmp/$asset"
curl -fsSL "$base/SHA256SUMS" -o "$tmp/SHA256SUMS"

expected="$(awk -v a="$asset" '$2 == a { print $1 }' "$tmp/SHA256SUMS")"
actual="$(shasum -a 256 "$tmp/$asset" | awk '{ print $1 }')"
if [ -z "$expected" ] || [ "$expected" != "$actual" ]; then
  echo "Checksum mismatch, not installing." >&2
  exit 1
fi

mkdir -p "$dir"
install -m 755 "$tmp/$asset" "$dir/fed51"
echo "Installed fed51 to $dir/fed51"

# macOS doesn't put ~/.local/bin on the PATH, so add it to the shell's startup file.
case ":$PATH:" in
  *":$dir:"*) ;;
  *)
    case "$(basename "${SHELL:-/bin/zsh}")" in
      zsh)  rc="$HOME/.zshrc" ;;
      bash) rc="$HOME/.bash_profile" ;;
      *)    rc="" ;;
    esac
    line="export PATH=\"$dir:\$PATH\"  # added by the fed51 installer"
    if [ -z "$rc" ]; then
      echo
      echo "Add $dir to your PATH to run 'fed51' from anywhere:"
      echo "  export PATH=\"$dir:\$PATH\""
    else
      if grep -qF "added by the fed51 installer" "$rc" 2>/dev/null; then
        echo "$dir is already set up in $rc."
      else
        printf '\n%s\n' "$line" >> "$rc"
        echo "Added $dir to your PATH in $rc."
      fi
      echo "Open a NEW Terminal window (or run: source $rc) before using it."
    fi
    ;;
esac

echo
echo "Then type: fed51   (it works right away; type help to see what it can do)"
