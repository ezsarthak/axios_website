#!/usr/bin/env bash

set -o errexit

# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Run Flutter doctor to download required artifacts
flutter doctor

# Enable web support
flutter config --enable-web

# Get dependencies
flutter pub get

# Build web
flutter build web --release
