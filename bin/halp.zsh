#!/usr/bin/env zsh

GUIDE="$HOME/GUIDE.md"

show_toc() {
  awk '
    BEGIN { header = ""; desc = ""; in_code = 0 }
    /^```/ { in_code = !in_code; next }
    in_code { next }
    /^## / {
      if (header != "") {
        if (desc == "") desc = "(see section)"
        printf "- **%s** — %s\n", header, desc
      }
      header = substr($0, 4)
      desc = ""
      next
    }
    header != "" && desc == "" && /[^ \t]/ && !/^---/ && !/^>/ && !/^\|/ {
      d = $0
      gsub(/\*\*/, "", d)
      gsub(/`/, "", d)
      gsub(/  +/, " ", d)
      gsub(/^ +| +$/, "", d)
      sub(/:$/, "", d)
      if (d != "") desc = d
    }
    END {
      if (header != "") {
        if (desc == "") desc = "(see section)"
        printf "- **%s** — %s\n", header, desc
      }
    }
  ' "$GUIDE" | glow -
}

show_section() {
  local keyword="${(L)1}"
  local content
  content=$(awk -v kw="$keyword" '
    BEGIN { in_section = 0 }
    /^## / {
      header = tolower(substr($0, 4))
      if (index(header, kw) > 0) {
        in_section = 1
        print $0
        next
      } else if (in_section) {
        exit
      }
    }
    /^---/ { if (in_section) exit }
    in_section { print }
  ' "$GUIDE")

  if [[ -z "$content" ]]; then
    echo "halp: no section matching '$1'" >&2
    echo "Run 'halp me' for a list of sections." >&2
    return 1
  fi

  echo "$content" | glow -
}

case "${1:-}" in
  "")   glow --pager "$GUIDE" ;;
  "me") show_toc ;;
  *)    show_section "$1" ;;
esac
