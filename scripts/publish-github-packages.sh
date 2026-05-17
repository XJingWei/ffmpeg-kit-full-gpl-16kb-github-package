#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
aar_file="$repo_dir/artifacts/ffmpeg-kit-full-gpl-16kb.aar"
pom_file="$repo_dir/ffmpeg-kit-full-gpl-16kb.pom"
expected_sha256="cb7051753f6bffab918ef14a15e40a380b21fc52be4ce9d0b132de967cc0b726"

: "${GITHUB_OWNER:?Set GITHUB_OWNER, for example XJingWei}"
: "${GITHUB_REPO:?Set GITHUB_REPO, for example ffmpeg-kit-full-gpl-16kb-github-package}"
: "${GITHUB_USERNAME:?Set GITHUB_USERNAME to your GitHub username}"
: "${GITHUB_TOKEN:?Set GITHUB_TOKEN to a GitHub token with write:packages permission}"

if [[ ! -f "$aar_file" ]]; then
  "$repo_dir/scripts/download-aar.sh"
fi

actual_sha256="$(openssl dgst -sha256 "$aar_file" | awk '{print $NF}')"
if [[ "$actual_sha256" != "$expected_sha256" ]]; then
  echo "AAR checksum mismatch." >&2
  echo "Expected: $expected_sha256" >&2
  echo "Actual:   $actual_sha256" >&2
  exit 1
fi

settings_file="$(mktemp)"
trap 'rm -f "$settings_file"' EXIT

cat > "$settings_file" <<XML
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">
  <servers>
    <server>
      <id>github</id>
      <username>${GITHUB_USERNAME}</username>
      <password>${GITHUB_TOKEN}</password>
    </server>
  </servers>
</settings>
XML

mvn --settings "$settings_file" deploy:deploy-file \
  -DrepositoryId=github \
  -Durl="https://maven.pkg.github.com/${GITHUB_OWNER}/${GITHUB_REPO}" \
  -Dfile="$aar_file" \
  -DpomFile="$pom_file" \
  -Dpackaging=aar

echo
echo "Published Maven coordinate:"
echo "com.chongyou.ffmpeg:ffmpeg-kit-full-gpl-16kb:6.0-16kb.1"
