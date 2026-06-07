#!/usr/bin/env bash
set -euo pipefail

# Fetch the PINNED upstream Tabler icon SVGs into gen/vendor/tabler/.
#
# Tabler ships two variants — outline + filled — as flat SVG dirs inside the
# npm tarball at package/icons/outline/*.svg and package/icons/filled/*.svg.
# (The tarball ALSO ships package/categories/<variant>/<Category>/*.svg, which
# are categorized DUPLICATES of the same icons; we deliberately ignore those.)
#
# Vendored upstream is fetched, never committed (see .gitignore) — only the
# generated .gleam shards + icons.json are committed. Re-run after bumping the
# pinned version below, then `cd gen && gleam run` to regenerate.

# ── Pinned upstream version ────────────────────────────────────────────────
TABLER_VERSION="3.44.0"
TARBALL_URL="https://registry.npmjs.org/@tabler/icons/-/icons-${TABLER_VERSION}.tgz"

# Resolve paths relative to this script so it works from any cwd.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENDOR_DIR="${SCRIPT_DIR}/vendor/tabler"
OUTLINE_DIR="${VENDOR_DIR}/outline"
FILLED_DIR="${VENDOR_DIR}/filled"

echo "Fetching @tabler/icons v${TABLER_VERSION}"
echo "  ${TARBALL_URL}"

# Idempotent: wipe the vendor dir so a re-run gives a clean snapshot.
rm -rf "${VENDOR_DIR}"
mkdir -p "${OUTLINE_DIR}" "${FILLED_DIR}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

TARBALL="${TMP_DIR}/tabler-icons.tgz"
curl -fsSL "${TARBALL_URL}" -o "${TARBALL}"

# Extract each variant's flat SVG dir, stripping the package/icons/<variant>/
# prefix (--strip-components=3) so files land flat in the vendor dir. The
# pattern is matched natively by both GNU tar and BSD tar (macOS), so no
# --wildcards flag (BSD tar rejects it).
tar -xzf "${TARBALL}" -C "${OUTLINE_DIR}" \
  --strip-components=3 \
  'package/icons/outline/*.svg'
tar -xzf "${TARBALL}" -C "${FILLED_DIR}" \
  --strip-components=3 \
  'package/icons/filled/*.svg'

OUTLINE_COUNT="$(find "${OUTLINE_DIR}" -name '*.svg' | wc -l | tr -d ' ')"
FILLED_COUNT="$(find "${FILLED_DIR}" -name '*.svg' | wc -l | tr -d ' ')"
echo "Extracted ${OUTLINE_COUNT} outline + ${FILLED_COUNT} filled SVGs into ${VENDOR_DIR}"
