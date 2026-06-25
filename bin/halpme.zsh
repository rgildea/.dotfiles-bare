#!/usr/bin/env zsh

HALPME_DIR="${HALPME_DIR:-$HOME/.config/halpme}"
HALPME_WIDTH="${HALPME_WIDTH:-100}"

show_toc() {
  local output="" found=0 filename sections
  for f in "$HALPME_DIR"/*.md(N); do
    found=1
    filename=$(basename "$f")
    sections=$(awk '
      /^<!-- halpme:/ {
        line = $0
        sub(/^<!-- halpme: */, "", line)
        sub(/ *-->.*/, "", line)
        n = split(line, parts, / *\| */)
        printf "- `%-8s` %s\n", parts[1], parts[2]
      }
    ' "$f")
    [[ -n "$sections" ]] && output+="## $filename\n$sections\n\n"
  done

  if (( found == 0 )); then
    echo "halpme: no topic files found in $HALPME_DIR" >&2
    echo "Run 'npx skills add halpme-sh/halpme' to get started." >&2
    return 1
  fi

  if [[ -z "$output" ]]; then
    echo "halpme: found .md files but none have <!-- halpme: --> annotations" >&2
    echo "Add '<!-- halpme: keyword | description -->' after a '### Section' header." >&2
    return 1
  fi

  printf '%b' "$output" | glow -w "$HALPME_WIDTH" -
}

show_section() {
  local keyword="${(L)1}"
  local content="" section filestem
  for f in "$HALPME_DIR"/*.md(N); do
    filestem=$(basename "$f" .md)
    section=$(awk -v kw="$keyword" -v stem="${(L)filestem}" '
      BEGIN { in_section = 0; pending = "" }
      /^### / {
        if (in_section) in_section = 0
        pending = $0
        cur_header = tolower(substr($0, 5))
      }
      /^<!-- halpme:/ {
        if (pending == "") next
        line = $0
        sub(/^<!-- halpme: */, "", line)
        sub(/ *-->.*/, "", line)
        split(line, parts, / *\| */)
        slug = tolower(parts[1])
        if (slug == kw || index(cur_header, kw) > 0 || stem == kw) {
          in_section = 1
          print pending
        }
        pending = ""
        next
      }
      /^---/ { if (in_section) { in_section = 0; print; next } }
      in_section { print }
    ' "$f")
    [[ -n "$section" ]] && content+="$section\n\n"
  done

  if [[ -z "$content" ]]; then
    echo "halpme: no section matching '$1'" >&2
    echo "Run 'halpme' for a list of topics." >&2
    return 1
  fi

  printf '%b' "$content" | glow --pager -w "$HALPME_WIDTH" -
}

case "${1:-}" in
  "") show_toc ;;
  *) show_section "$1" ;;
esac
