# FFmpeg Kit Full GPL 16KB GitHub Package

This small repository publishes `ffmpeg-kit-full-gpl-16kb.aar` as a public Maven artifact.

Published coordinate:

```text
com.chongyou.ffmpeg:ffmpeg-kit-full-gpl-16kb:6.0-16kb.1
```

Public Maven repository:

```text
https://xjingwei.github.io/ffmpeg-kit-full-gpl-16kb-github-package/maven
```

The large source AAR under `artifacts/` is intentionally ignored by Git. Download it locally before regenerating the Maven repository:

```bash
./scripts/download-aar.sh
```

Regenerate the static Maven repository under `docs/maven`:

```bash
mvn deploy:deploy-file \
  -Durl="file://$PWD/docs/maven" \
  -DrepositoryId=local-pages \
  -Dfile=artifacts/ffmpeg-kit-full-gpl-16kb.aar \
  -DpomFile=ffmpeg-kit-full-gpl-16kb.pom \
  -Dpackaging=aar
```

Android Gradle/UTS can consume:

```json
{
  "minSdkVersion": "24",
  "dependencies": [
    "com.chongyou.ffmpeg:ffmpeg-kit-full-gpl-16kb:6.0-16kb.1"
  ],
  "repositories": [
    "maven { url 'https://xjingwei.github.io/ffmpeg-kit-full-gpl-16kb-github-package/maven' }"
  ]
}
```
