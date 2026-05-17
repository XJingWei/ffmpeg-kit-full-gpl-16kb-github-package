# FFmpeg Kit Full GPL 16KB GitHub Package

This small repository publishes `ffmpeg-kit-full-gpl-16kb.aar` to GitHub Packages as a Maven artifact.

Published coordinate:

```text
com.chongyou.ffmpeg:ffmpeg-kit-full-gpl-16kb:6.0-16kb.1
```

The large AAR is intentionally ignored by Git. Download it locally before publishing:

```bash
./scripts/download-aar.sh
```

Then publish:

```bash
export GITHUB_OWNER="your-github-owner"
export GITHUB_REPO="ffmpeg-kit-full-gpl-16kb-github-package"
export GITHUB_USERNAME="your-github-username"
export GITHUB_TOKEN="your-token-with-write-packages"

./scripts/publish-github-packages.sh
```

After publishing, Android Gradle/UTS can consume:

```json
{
  "minSdkVersion": "24",
  "dependencies": [
    "com.chongyou.ffmpeg:ffmpeg-kit-full-gpl-16kb:6.0-16kb.1"
  ]
}
```
