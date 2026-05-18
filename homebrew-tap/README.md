# Homebrew tap source

This folder is **not** consumed from this repository. It is the source of
truth for the cask that lives in the separate
[`milon/homebrew-macos-unijoy`](https://github.com/milon/homebrew-macos-unijoy)
tap repository, so the cask definition can be reviewed alongside the layout
itself.

The cask uses Homebrew's `keyboard_layout` artifact stanza to install
`unijoy.keylayout` and `unijoy.icns` directly into
`/Library/Keyboard Layouts/`. It downloads them straight from the GitHub
source tarball for the matching tag — the `.pkg` installer is *not* used
by the Homebrew path.

The release workflow (`.github/workflows/release.yml`) reaches into the tap
repo on every `v*` tag push and updates `Casks/macos-unijoy.rb` there with
the new version and the SHA256 of the source tarball. You should not
normally need to edit `Casks/macos-unijoy.rb` in this repo by hand — tag a
release, and the tap is bumped automatically.

## One-time tap setup

1. Create a new public GitHub repository named exactly
   **`homebrew-macos-unijoy`** under your account (the `homebrew-` prefix
   is required by Homebrew).
2. Copy `Casks/macos-unijoy.rb` from this folder into the new repo at the
   same path (`Casks/macos-unijoy.rb`) and push it to `main`.
3. Create a fine-grained personal access token scoped to that single
   repository with **Contents: Read and write** permission.
4. In this repository's settings, add the token as a secret named
   `TAP_PUSH_TOKEN` (Settings → Secrets and variables → Actions → New
   repository secret).

After that, every `git push --tags` here will:

- Build, (optionally) sign, and notarize `Unijoy-Installer-X.Y.Z.pkg`.
- Publish it to GitHub Releases (used by the non-Homebrew install paths).
- Push a commit to `homebrew-macos-unijoy` bumping `version` and `sha256`
  of the source tarball that the cask consumes.

## Installing

```bash
brew install --cask milon/macos-unijoy/macos-unijoy
```

Or in two steps:

```bash
brew tap milon/macos-unijoy
brew install --cask macos-unijoy
```

## Local testing of the cask

From a checkout of the tap repo:

```bash
brew install --cask ./Casks/macos-unijoy.rb
brew uninstall --cask macos-unijoy
brew audit --cask --strict --online macos-unijoy
brew style Casks/macos-unijoy.rb
```
