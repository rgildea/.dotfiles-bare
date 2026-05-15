#!/usr/bin/env zsh

GUIDE="$HOME/GUIDE.md"
HALP_WIDTH="${HALP_WIDTH:-100}"

show_toc() {
  awk '
    /^<!-- halp:/ {
      line = $0
      sub(/^<!-- halp: */, "", line)
      sub(/ *-->.*/, "", line)
      n = split(line, parts, / *\| */)
      printf "- `%-8s` %s\n", parts[1], parts[2]
    }
  ' "$GUIDE" | glow -w "$HALP_WIDTH" -
}

show_section() {
  local keyword="${(L)1}"
  local content
  content=$(awk -v kw="$keyword" '
    BEGIN { in_section = 0; pending = "" }
    /^## / {
      if (in_section) exit
      pending = $0
      cur_header = tolower(substr($0, 4))
    }
    /^<!-- halp:/ {
      if (pending == "") next
      line = $0
      sub(/^<!-- halp: */, "", line)
      sub(/ *-->.*/, "", line)
      split(line, parts, / *\| */)
      slug = tolower(parts[1])
      if (slug == kw || index(cur_header, kw) > 0) {
        in_section = 1
        print pending
      }
      pending = ""
      next
    }
    /^---/ { if (in_section) exit }
    in_section && !/^<!-- / { print }
  ' "$GUIDE")

  if [[ -z "$content" ]]; then
    echo "halp: no section matching '$1'" >&2
    echo "Run 'halp me' for a list of sections." >&2
    return 1
  fi

  echo "$content" | glow --pager -w "$HALP_WIDTH" -
}

case "${1:-}" in
  "")         glow --pager -w "$HALP_WIDTH" "$GUIDE" ;;
  "me")       [[ -n "${2:-}" ]] && show_section "$2" || show_toc ;;
  *)          show_section "$1" ;;
esac
