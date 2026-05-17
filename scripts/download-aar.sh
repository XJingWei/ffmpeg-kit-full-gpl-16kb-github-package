#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="$repo_dir/artifacts/ffmpeg-kit-full-gpl-16kb.aar"
url="https://github.com/mukuldeep/ffmpeg-kit-16KB/releases/download/ffmpeg-kit-16KB/ffmpeg-kit-fg.aar"
expected_sha256="cb7051753f6bffab918ef14a15e40a380b21fc52be4ce9d0b132de967cc0b726"

mkdir -p "$(dirname "$target")"

if [[ -f "$target" ]]; then
  actual_sha256="$(openssl dgst -sha256 "$target" | awk '{print $NF}')"
  if [[ "$actual_sha256" == "$expected_sha256" ]]; then
    echo "AAR already exists and checksum matches: $target"
    exit 0
  fi
  echo "Existing AAR checksum mismatch, re-downloading."
fi

tmp_file="$target.tmp"
curl -L -f -o "$tmp_file" "$url"
actual_sha256="$(openssl dgst -sha256 "$tmp_file" | awk '{print $NF}')"

if [[ "$actual_sha256" != "$expected_sha256" ]]; then
  rm -f "$tmp_file"
  echo "Checksum mismatch for downloaded AAR." >&2
  echo "Expected: $expected_sha256" >&2
  echo "Actual:   $actual_sha256" >&2
  exit 1
fi

mv "$tmp_file" "$target"
echo "Downloaded $target"
