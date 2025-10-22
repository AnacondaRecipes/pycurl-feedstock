#!/bin/bash

set -euxo pipefail

pip check

make CC=$CC -C tests/fake-curl/libcurl
pytest -v tests
