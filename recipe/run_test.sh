#!/bin/bash

set -euxo pipefail

pip check

make CC=$CC -C tests/fake-curl/libcurl

if [[ "$target_platform" == "osx-arm64" ]]; then
    ulimit -n 4096 2>/dev/null || true
fi

# pause/unpause test can randomly fail on Unix, see https://github.com/pycurl/pycurl/pull/921See 
pytest -v tests -k "not test_easy_pause_unpause"
