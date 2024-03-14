# propromo.ios

## Install XcodeGen

### As Swift Package

```bash
git clone https://github.com/yonaskolb/XcodeGen.git && cd XcodeGen
```

```bash
swift run xcodegen
```

### As Globally Available CLI-App

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
brew install xcodegen
```

## Setup (Generate) Project (`.xcodeproj`)

### Using The Swift Package

```bash
swift run xcodegen --project ../propromo.ios/ --spec ../propromo.ios/project.yml
```

### With Global Installation

```bash
xcodegen generate
```
