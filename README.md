## Pre-requisites

- A Mac with the latest Xcode
- An Apple Developer account signed in to Xcode: **Xcode → Settings → Accounts**
- Git

## 1. Clone the repo

```bash
git clone https://github.com/jonathanbasuki/elven-plong.git
```

## 2. Set up `Local.xcconfig` (one time, at the start)

Team ID and bundle ID prefix are **not** stored in the repo because they differ per person. Every team member creates their own local file.

```bash
cp Config/Local.xcconfig.example Config/Local.xcconfig
```

Open `Config/Local.xcconfig` and fill in:

```
DEVELOPMENT_TEAM = YOUR_TEAM_ID
ORGANIZATION_IDENTIFIER = com.elven.YOUR_NAME
```

- `DEVELOPMENT_TEAM`: the Team ID of your Apple Developer account. Find it at [developer.apple.com](https://developer.apple.com/account) → **Membership details**.
- `ORGANIZATION_IDENTIFIER`: a bundle ID prefix unique to you, e.g. `com.elven.heri`. Do not reuse another teammate's prefix, since a bundle ID can only be registered by one team.

> `Local.xcconfig` is already in `.gitignore`. Never commit it.

Verify:

```bash
git check-ignore -v Config/Local.xcconfig
```

## 3. Open the project

```bash
open Plong.xcodeproj
```

Select the scheme and Run (⌘R).

Check signing: **Target → Build Settings → Levels**, and confirm `DEVELOPMENT_TEAM` and `PRODUCT_BUNDLE_IDENTIFIER` resolve from `Local.xcconfig` / `Shared.xcconfig`.

**Important:**

- Do not change Team or Bundle Identifier in the **Signing & Capabilities** tab. Changes there are written to `project.pbxproj` and override the xcconfig. Change them in the xcconfig files instead.
- Before committing, make sure no Team ID leaked into the project:
  ```bash
  grep -n "DEVELOPMENT_TEAM" Plong.xcodeproj/project.pbxproj   
  # should print nothing
  ```

## 4. Daily workflow

The main development branch is **`dev`**. Do not commit directly to `dev` or `main`.

### a. Pull the latest `dev` (every time before you start changing code)

```bash
git checkout dev
git pull origin dev
```

### b. Create a new branch from `dev`

Branch name format: `feature/FEATURE_NAME`, `fix/BUG_NAME`, or `chore/TASK_NAME`.

```bash
git checkout -b feature/YOUR_FEATURE_CHANGE
```

Examples:

```bash
git checkout -b feature/login-screen
git checkout -b fix/crash-on-launch
```

### c. Make your changes and commit

```bash
git status
git add .
git commit -m "Add login screen"
```

Run `git status` first and make sure `Config/Local.xcconfig` is not staged.

### d. Push your branch

First push of a new branch:

```bash
git push -u origin feature/YOUR_FEATURE_CHANGE
```

Subsequent pushes:

```bash
git push
```

### e. Open a Pull Request

On GitHub, open a Pull Request from `feature/YOUR_FEATURE_CHANGE` into **`dev`** and request a review from a teammate.

### f. After the PR is merged

```bash
git checkout dev
git pull origin dev
git branch -d feature/YOUR_FEATURE_CHANGE
```

## If `dev` changes while your branch is still in progress

```bash
git checkout dev
git pull origin dev
git checkout feature/YOUR_FEATURE_CHANGE
git merge dev
```

Resolve conflicts (if any), rebuild, then push.

## Folder structure

```
Plong/
├── Config/
│   ├── Shared.xcconfig          # shared settings
│   ├── macOS.xcconfig           # macOS-specific settings
│   ├── Local.xcconfig           # per-person
│   └── Local.xcconfig.example   # template
├── Packages/                    # optional
│   └── Core/
├── Plong/                       # macOS target source
└── Plong.xcodeproj
```

## Troubleshooting

| Problem | Fix |
|---|---|
| "Signing requires a development team" | `Local.xcconfig` is missing or `DEVELOPMENT_TEAM` is empty. See step 2. |
| "Bundle identifier is not available" | Your `ORGANIZATION_IDENTIFIER` collides with someone else's. Use a unique prefix. |
| xcconfig changes have no effect | A target-level override exists in Build Settings. Select the row and press Delete. |
| `Local.xcconfig` shows up in `git status` | Check `.gitignore`. If already tracked: `git rm --cached Config/Local.xcconfig` |