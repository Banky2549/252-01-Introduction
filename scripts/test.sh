#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

make clean >/dev/null
make >/dev/null

output="$(./bin/api_bridge_lab samples/records.txt 2>&1 || true)"
expected="$(cat <<'EOF'
01 | Ada Lovelace | legacy=ada_lovelace:1815 | modern=ada_lovelace:1815 | status=OK
02 | Grace Hopper | legacy=grace_hopper:1906 | modern=grace_hopper:1906 | status=OK
03 | Dennis Ritchie | legacy=dennis_ritchie:1941 | modern=dennis_ritchie:1941 | status=OK
04 | Linus Torvalds | legacy=linus_torvalds:0 | modern=ERROR | status=MIGRATE
05 | Ken Thompson | legacy=ken_thompson:1943 | modern=ERROR | status=MIGRATE
06 | Margaret Hamilton | legacy=margaret_hamilton:1936 | modern=margaret_hamilton:1936 | status=OK
EOF
)"

echo "$output"

if [[ "$output" != "$expected" ]]; then
    echo "visible test: output mismatch" >&2
    diff -u <(printf "%s\n" "$expected") <(printf "%s\n" "$output") || true
    exit 1
fi

echo "visible test: passed"
