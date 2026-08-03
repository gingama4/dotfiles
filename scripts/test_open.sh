#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
readonly ROOT_DIR
readonly OPEN_SCRIPT="${ROOT_DIR}/home/dot_local/bin/executable_open"
WORK_DIR="$(mktemp -d)"
readonly WORK_DIR
readonly MOCK_BIN="${WORK_DIR}/bin"
readonly OPEN_TEST_LOG="${WORK_DIR}/open.log"
export OPEN_TEST_LOG

function cleanup() {
  rm -rf "${WORK_DIR}"
}
trap cleanup EXIT

function fail() {
  echo "test_open: $*" >&2
  exit 1
}

function assert_log() {
  local expected="$1"
  local actual

  actual="$(cat "${OPEN_TEST_LOG}")"
  [[ "${actual}" == "${expected}" ]] || \
    fail "expected log '${expected}', got '${actual}'"
  : > "${OPEN_TEST_LOG}"
}

function create_mocks() {
  mkdir -p "${MOCK_BIN}"

  cat > "${MOCK_BIN}/explorer.exe" <<'EOF'
#!/usr/bin/env bash
printf 'explorer:%s\n' "$1" >> "${OPEN_TEST_LOG}"
EOF

  cat > "${MOCK_BIN}/powershell.exe" <<'EOF'
#!/usr/bin/env bash
last_argument="${!#}"
printf 'chrome:%s\n' "$(printf '%s' "${last_argument}" | base64 -d)" >> "${OPEN_TEST_LOG}"
EOF

  cat > "${MOCK_BIN}/wslpath" <<'EOF'
#!/usr/bin/env bash
target="${!#}"
printf 'C:\\mock\\%s\n' "$(basename "${target}")"
EOF

  chmod +x "${MOCK_BIN}/explorer.exe" "${MOCK_BIN}/powershell.exe" "${MOCK_BIN}/wslpath"
  : > "${OPEN_TEST_LOG}"
}

function run_tests() {
  local test_file="${WORK_DIR}/file with spaces.txt"
  touch "${test_file}"

  PATH="${MOCK_BIN}:${PATH}" bash "${OPEN_SCRIPT}" "https://github.com/gingama4"
  assert_log "explorer:https://github.com/gingama4"

  PATH="${MOCK_BIN}:${PATH}" bash "${OPEN_SCRIPT}" "${test_file}"
  assert_log 'explorer:C:\mock\file with spaces.txt'

  PATH="${MOCK_BIN}:${PATH}" bash "${OPEN_SCRIPT}" -a chrome "https://github.com/cli/cli"
  assert_log "chrome:https://github.com/cli/cli"

  PATH="${MOCK_BIN}:${PATH}" bash "${OPEN_SCRIPT}" -a explorer "${WORK_DIR}"
  assert_log "explorer:C:\\mock\\$(basename "${WORK_DIR}")"

  (
    cd "${WORK_DIR}"
    PATH="${MOCK_BIN}:${PATH}" bash "${OPEN_SCRIPT}"
  )
  assert_log 'explorer:C:\mock\.'

  PATH="${MOCK_BIN}:${PATH}" bash "${OPEN_SCRIPT}" -a "Google Chrome" \
    'https://example.com/search?q=$(not-a-command)&lang=ja'
  # The literal command substitution verifies that it was not evaluated.
  # shellcheck disable=SC2016
  assert_log 'chrome:https://example.com/search?q=$(not-a-command)&lang=ja'

  if PATH="${MOCK_BIN}:${PATH}" bash "${OPEN_SCRIPT}" missing > /dev/null 2>&1; then
    fail "a missing path should fail"
  fi

  if PATH="${MOCK_BIN}:${PATH}" bash "${OPEN_SCRIPT}" one two > /dev/null 2>&1; then
    fail "multiple targets should fail"
  fi

  if PATH="${MOCK_BIN}:${PATH}" bash "${OPEN_SCRIPT}" -a unknown . > /dev/null 2>&1; then
    fail "an unsupported application should fail"
  fi
}

function main() {
  create_mocks
  run_tests
}

main
