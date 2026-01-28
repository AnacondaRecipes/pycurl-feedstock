#!/bin/bash

set -euxo pipefail

pip check

make CC=$CC -C tests/fake-curl/libcurl

if [[ "$target_platform" == "osx-arm64" ]]; then
  ulimit -n 4096 2>/dev/null || true
fi

pytest -v tests
