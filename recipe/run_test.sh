#!/bin/bash

set -euxo pipefail

pip check

make CC=$CC -C tests/fake-curl/libcurl

if [[ "$target_platform" == "osx-arm64" ]]; then
    ulimit -n 4096 2>/dev/null || true
fi

# Skipped tests on Unix (see pycurl upstream):
# - test_easy_pause_unpause: flaky pause/unpause, https://github.com/pycurl/pycurl/pull/921
# - test_multi_unassign_inside_socket_callback, test_clear_via_assign_none_inside_callback_resets_socketp:
#   assume an extra M_SOCKETFUNCTION with cleared socketp after in-callback unassign/assign(None);
#   libcurl + fdset/select ordering on Linux CI often completes the transfer without that callback.
pytest -v tests -k 'not test_easy_pause_unpause and not test_multi_unassign_inside_socket_callback and not test_clear_via_assign_none_inside_callback_resets_socketp'
