#!/usr/bin/env bash

# Kitty on macOS uses the font's fixed-pitch metadata when it builds its
# font list. The upstream Consolas ligaturized files have fixed glyph
# advances, but leave post.isFixedPitch unset.
set -euo pipefail

if [ -n "${CONSOLAS_LIGATURIZED_FONT_DIR:-}" ]; then
  font_dir="$CONSOLAS_LIGATURIZED_FONT_DIR"
else
  case "$(uname -s)" in
  Darwin)
    font_dir="$HOME/Library/Fonts"
    ;;
  Linux)
    font_dir="$HOME/.local/share/fonts"
    ;;
  *)
    exit 0
    ;;
  esac
fi

# The external archive is optional on unsupported platforms and may not have
# been downloaded yet. Do not require Python when there is no font to repair.
font_found=false
for font_path in "$font_dir"/Consolasligaturizedv3*.ttf; do
  if [ -f "$font_path" ]; then
    font_found=true
    break
  fi
done

if [ "$font_found" != true ]; then
  exit 0
fi

python3_path="$(command -v python3 || true)"
if [ -z "$python3_path" ] && [ -x "$HOME/.local/bin/python3" ]; then
  python3_path="$HOME/.local/bin/python3"
fi

uv_path="$(command -v uv || true)"
if [ -z "$uv_path" ] && [ -x "$HOME/.local/bin/uv" ]; then
  uv_path="$HOME/.local/bin/uv"
fi

if [ -n "$python3_path" ]; then
  python_command=("$python3_path")
elif [ -n "$uv_path" ]; then
  python_command=("$uv_path" run --no-project python3)
else
  echo "Error: Python 3 is required to repair Consolas ligaturized font metadata." >&2
  exit 1
fi

"${python_command[@]}" - "$font_dir" <<'PY'
from pathlib import Path
import os
import struct
import sys


MAGIC_CHECKSUM = 0xB1B0AFBA
FONT_NAMES = (
    "Consolasligaturizedv3.ttf",
    "Consolasligaturizedv3-Bold.ttf",
    "Consolasligaturizedv3-Italic.ttf",
    "Consolasligaturizedv3-BoldItalic.ttf",
)


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
    # checkSumAdjustment is zero while the table and whole-font checksums are
    # calculated, as required by the TrueType specification.
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


font_dir = Path(sys.argv[1])
for font_name in FONT_NAMES:
    path = font_dir / font_name
    if path.is_file():
        fix_font(path)
PY
