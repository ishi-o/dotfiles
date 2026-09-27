#!/usr/bin/env bash

set -euo pipefail

if [ -n "${YAHEI_CONSOLAS_HYBRID_FONT_DIR:-}" ]; then
  font_dir="$YAHEI_CONSOLAS_HYBRID_FONT_DIR"
else
  case "$(uname -s)" in
  Darwin)
    font_dir="$HOME/Library/Fonts"
    ;;
  Linux)
    font_dir="$HOME/.local/share/fonts"
    ;;
  MINGW*|MSYS*|CYGWIN*)
    if [ -n "${LOCALAPPDATA:-}" ] && command -v cygpath >/dev/null 2>&1; then
      font_dir="$(cygpath -u "$LOCALAPPDATA")/Microsoft/Windows/Fonts"
    else
      exit 0
    fi
    ;;
  *)
    exit 0
    ;;
  esac
fi

font_name='YaHei Consolas Hybrid 1.12 For Powerline.ttf'
font_path="$font_dir/$font_name"

if [ ! -f "$font_path" ]; then
  exit 0
fi

python_command=()
for candidate in \
    "$(command -v python3 || true)" \
    /usr/bin/python3 \
    /bin/python3; do
  if [ -n "$candidate" ] && "$candidate" -c 'import sys' >/dev/null 2>&1; then
    python_command=("$candidate")
    break
  fi
done

if [ "${#python_command[@]}" -eq 0 ]; then
  echo "Error: Python 3 is required to repair the YaHei Consolas Hybrid font." >&2
  exit 1
fi

"${python_command[@]}" - "$font_path" <<'PY'
import os
import struct
import sys
from pathlib import Path


MAGIC_CHECKSUM = 0xB1B0AFBA


def checksum(data: bytes) -> int:
    padded = data + b"\0" * ((4 - len(data) % 4) % 4)
    return sum(struct.unpack(f">{len(padded) // 4}I", padded)) & 0xFFFFFFFF


def fix_font(path: Path) -> None:
    original = path.read_bytes()
    if original[:4] not in (b"\x00\x01\x00\x00", b"true"):
        raise RuntimeError(f"{path}: unsupported font format")

    table_count = struct.unpack_from(">H", original, 4)[0]
    tables = {}
    for index in range(table_count):
        record = 12 + index * 16
        tag, _table_checksum, offset, length = struct.unpack_from(">4sIII", original, record)
        tables[tag] = (record, offset, length)

    if b"post" not in tables or b"head" not in tables:
        raise RuntimeError(f"{path}: missing post or head table")

    post_record, post_offset, post_length = tables[b"post"]
    head_record, head_offset, head_length = tables[b"head"]
    if post_length < 16 or head_length < 12:
        raise RuntimeError(f"{path}: malformed post or head table")

    fixed_pitch = struct.unpack_from(">I", original, post_offset + 12)[0]
    if fixed_pitch == 1:
        print(f"{path.name}: already fixed-pitch")
        return
    if fixed_pitch != 0:
        raise RuntimeError(f"{path}: unexpected post.isFixedPitch={fixed_pitch}")

    data = bytearray(original)
    struct.pack_into(">I", data, head_offset + 8, 0)
    struct.pack_into(">I", data, post_offset + 12, 1)
    struct.pack_into(
        ">I",
        data,
        post_record + 4,
        checksum(data[post_offset:post_offset + post_length]),
    )
    struct.pack_into(
        ">I",
        data,
        head_record + 4,
        checksum(data[head_offset:head_offset + head_length]),
    )

    adjustment = (MAGIC_CHECKSUM - checksum(data)) & 0xFFFFFFFF
    struct.pack_into(">I", data, head_offset + 8, adjustment)
    if checksum(data) != MAGIC_CHECKSUM:
        raise RuntimeError(f"{path}: failed to produce a valid font checksum")

    with path.open("r+b") as font_file:
        font_file.write(data)
        font_file.flush()
        os.fsync(font_file.fileno())
    print(f"{path.name}: post.isFixedPitch 0 -> 1")


fix_font(Path(sys.argv[1]))
PY
